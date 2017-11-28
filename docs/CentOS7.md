This is a guide to setting up Lmod (lua environment modules) on a CentOS7 system. I've used a similar procedure to set them up on a Mac, as well, so this is still a useful guide to the workings of Lmod if you use a different system; mostly paths will change. On a Mac, you'll want to install `Lmod` from the `science` tap in `brew`.

There are several good pages covering environment modules (TCL version), but not many that use the newer Lua syntax. This document aims to fill that roll.

# Installation

To install Lmod, you should add the epel repository and then do `yum install Lmod` to set it up. It will add an init script to `/etc/profile.d` to activate the `module` command automatically for all users. If you need to customize anything, like the paths included in the `MODULEPATH`, the scripts added here are `00-modulepath.*` and `z00_lmod.*`. You might find that removing the last entry in the modulepath init script (`&& export MODULEPATH=/etc/modulefiles:/usr/share/modulefiles`) is useful, as the `MODULEPATH` is better set by the profile script already sourced.

# Setting up the directories: Core

I'll be showing you how to set up the directories in `/usr/share/modulepath/`, since that is already prepared for us. We'll make two directories, `Core` and `Compiler`. `/usr/share/modulepath/Core` should be the only one in your module path; I perfer not to have `/usr/share/modulepath` in the `MODULEPATH`, as that will add clutter when looking at the available modules (and it is already available as `MODULEPATH_ROOT`).

Inside `Core`, you'll make directories for your compilers, such as `gcc`. Inside `gcc`, we'll set up the default 4.8 compiler by creating a file called `4.8.lua`. This is what it should look like:

```
help([[
This is the module file for the GCC compiler.
]])

local version = "4.8"

whatis("Name: GCC compiler (system default)")
whatis("Version: " .. version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.gnu.org/")
whatis("Description: GNU compiler family")

family("compiler")

local prefix = "/usr/bin"

setenv("CC",  pathJoin(prefix, "gcc"))
setenv("CXX", pathJoin(prefix, "g++"))
setenv("FC",  pathJoin(prefix, "fc"))
setenv("C77", pathJoin(prefix, "fc"))

local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot, "Compiler", "gcc", version)
prepend_path("MODULEPATH", mdir)
```

This has a lot more than is needed, but provides an example of everything you need. This is in Lua syntax, so the items like the multiline string and the local statement for defining local variables might be a little unfamiliar to Python users, but otherwise it's a lot like Python.

The important features are:
* The `family` command, which means only one module marked with this string can be loaded at a time.
* The `setenv` commands, which set environment variables and forget the previous setting
  * Another option is `pushenv`, which remember the previous setting for unloading
  * Another similar command is `unsetenv`, which clears a variable on loading
* The `prepend_path` command , which adds a path to the beginning of an environment variable, and removes it on unloading
  * There is also a matching `append_path` command
* The fact that I'm changing `MODULEPATH` in a module is special to Lmod; it will also unload all modules in the added path when it is removed!

I've also chosen to use a prefix and a version to make this easy to change. The `joinPath` commmand is from one of the optional Lua libraries that Lmod includes automatically.

Feel free to add more compilers to `Core` if needed.

# Setting up the directories: Compiler

You'll notice that my compiler loaded it's matching directory in Compiler; that's where packages that are compiled with this compiler live. Matching names in multiple compiler directories will correctly swap if you swap compiliers! Inside a `/Compiler/gcc/4.8/` directory, add the modules that you want to use.

If you want the default module to be something other than the latest version number, make a `default.lua` symbolic link in the directory pointing to the file you want; if you want to alias a simpler version number, like 6 instead of 6.08.02, you can also make a similar symbolic link.

# Converting shell scripts

Many packages use a shell script to set up the environment. Lmod can capture those changes and write (most) of the `.lua` file for you. To run it, load the included `lmod` package and then run `sh_to_modulefile mysetupscript.sh -o mymodulefile.lua` and it will write a modulefile for you. You can use `--help` to see the options. If you like the prefix suggestion I used above, I have written my own version of this script that includes this, available as an example in a Plumbum branch [here](https://github.com/tomerfiliba/plumbum/blob/more_examples/examples/lmod_env.py). It also can save an environment to a file, then load and compare, creating the `.lua` file that describes the changes.

# Using modules

Some common commands you'll want are:
* `module avail` Shows all currently loadable modules
* `module load gcc` Prepares a compiler, makes the packages built with that compiler available
* `module load package` Loads a package from the current compiler
* `module list` Shows all the currently used modules
* `module unload package` Unloads a package
* `module save` Saves the current list of packages (can save to a name, or without a name is your personal default)
* `module restore` Loads a (named or default) package list - note the system default is `system`
* `module` Describes the available subcommands

> Note: a timesaver is available as the `ml` command; it is short for `module load`, but it works with any of the other module subcommands too. Without a package or subcommand it will list the in-use packages. It also supports unloading as `ml -package` too!
