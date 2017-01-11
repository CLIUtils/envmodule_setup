#!/usr/bin/env python

'''
This example cli program saves and loads an environment, noting the changes in a lmod (Lua Environment Modules) compatible format. It can also directly run and compare the changes made in a bash script. The ability to take a prefix is a set above lmod's built in script.

'''

from plumbum import local, cli, FG
import json

def intersperse(lst, item):
    result = [item] * (len(lst) * 2 - 1)
    result[0::2] = lst
    return result


def prefixify(value, prefix=None):
    '''
    Converts to a version that uses prefixes, if prefix given. Examples:

    >>> prefixify('one two three ', ' ')
    'joinPath("one", prefix, "two", prefix, "three", prefix)'
    >>> prefixify(' ', ' ')
    'prefix'
    >>> prefixify('this', ' ')
    '"this"'
    '''

    if prefix is None or prefix not in value:
        return '"{0}"'.format(value)
    if prefix == value:
        return 'prefix'
    vals = ['"{0}"'.format(v) for v in value.split(prefix)]
    vals = intersperse(vals, 'prefix')
    vals = [v for v in vals if v != '""']
    return 'joinPath({0})'.format(', '.join(vals))

def make_changes(orig, curr, prefix = None):
    '''
    >>> orig = dict(
    ...    same = 'hello',
    ...    gone = 'not here',
    ...    changed = 'anything',
    ...    prepended = 'base/string',
    ...    appended = 'base/string'
    ... )
    >>> curr = dict(
    ...    same = 'hello',
    ...    added = 'wowsa',
    ...    changed = 'nothing',
    ...    prepended = 'new/base/string',
    ...    appended = 'base/string/more'
    ... )
    >>> sorted(make_changes(orig, curr))
    ['append_path("appended", "/more")', 'prepend_path("prepended", "new/")', 'pushenv("changed", "nothing")', 'setenv("added", "wowsa")', 'unsetenv("gone")']
    '''
    only_in_orig = set(orig) - set(curr)
    only_in_curr = set(curr) - set(orig)
    both = set(orig) & set(curr)

    for name in only_in_orig:
        yield 'unsetenv("{0}")'.format(name)

    for name in only_in_curr:
        yield 'setenv("{0}", {1})'.format(name, prefixify(curr[name], prefix))

    for name in both:
        curr_val = curr[name]
        orig_val = orig[name]
        if curr_val != orig_val:
            if curr_val.startswith(orig_val):
                yield 'append_path("{0}", {1})'.format(name,
                                        prefixify(curr_val[len(orig_val):], prefix))
            elif curr_val.endswith(orig_val):
                yield 'prepend_path("{0}", {1})'.format(name,
                                        prefixify(curr_val[:-len(orig_val)], prefix))
            else:
                yield 'pushenv("{0}", {1})'.format(name, prefixify(curr_val, prefix))

def get_current_env(output):
    dic = {line.split('=',1)[0]:line.split('=',1)[1] for line in output.splitlines() if '=' in line}
    return dic

class LmodEnv(cli.Application):
    'Save then load an environment, noting the changes.'

    prefix = cli.SwitchAttr(['-p', '--prefix'], help='A common prefix to factor out')
    
    @cli.positional(cli.ExistingFile)
    def main(self, filename=None):
        if self.nested_command is not None:
            if self.prefix:
                self.nested_command.prefix = self.prefix
            return
        if filename is None:
            print("Error! please give a filename or a subcommand! See --help for details.")
            return 1
        orig = get_current_env(local['bash']('-c', 'env'))
        curr = get_current_env(local['bash']('-c', 'source '+filename+' && env'))
        if self.prefix:
            print('prefix = "{0}"\n'.format(self.prefix))
        print('\n'.join(sorted(make_changes(orig, curr, self.prefix))))


@LmodEnv.subcommand("save")
class Save(cli.Application):

    @cli.positional(cli.NonexistentPath)
    def main(self, filename):
        with open(filename, 'w') as f:
            json.dump(dict(local.env), f)

@LmodEnv.subcommand("load")
class Load(cli.Application):

    prefix = cli.SwitchAttr(['-p', '--prefix'], help='A common prefix to factor out')
    
    @cli.positional(cli.ExistingFile)
    def main(self, filename):
        with open(filename) as f:
            orig = json.load(f)
        curr = dict(local.env)
        if self.prefix:
            print('prefix = "{0}"\n'.format(self.prefix))
        print('\n'.join(sorted(make_changes(orig, curr, self.prefix))))

if __name__ == '__main__':
    LmodEnv()
