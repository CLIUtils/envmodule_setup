help([[
This is the module file for the GCC compiler.
]])

local gcc_version = "4.8"

whatis("Name: GCC compiler (system default)")
whatis("Version: " .. gcc_version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.gnu.org/")
whatis("Description: GNU compiler family")

family("compiler")

local prefix = "/usr/bin"

setenv("CC",  pathJoin(prefix, "gcc"))
setenv("CXX", pathJoin(prefix, "g++"))
setenv("FC",  pathJoin(prefix, "gfortran"))
setenv("F77", pathJoin(prefix, "gfortran"))

local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot, "Compiler", "gcc", gcc_version)
prepend_path("MODULEPATH", mdir)
