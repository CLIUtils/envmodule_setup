help([[
This is the modulefile for the gcc compiler
]])

local version = myModuleVersion()

whatis("Name: GCC " .. version)
whatis("Version " .. version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.gnu.org/")
whatis("Description: GNU compiler family")

family("compiler")

local prefix = "/usr/local/opt/gcc"
local bin = pathJoin(prefix, "bin")
local lib = pathJoin(prefix, "lib")
local include = pathJoin(prefix, "include")

prepend_path("PATH", bin)

setenv("LDFLAGS", "-L" .. lib .. " -Wl,-rpath," .. lib)
setenv("CPPFLAGS", "-I" .. include)

setenv("C_INCLUDE_PATH", include)

setenv("CC",  pathJoin(bin, "gcc-8"))
setenv("CXX", pathJoin(bin, "g++-8"))
setenv("FC", pathJoin(bin, "gfortran-8"))
setenv("F77", pathJoin(bin, "gfortran-8"))

local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot, "Compiler", "gcc", version)
prepend_path("MODULEPATH", mdir)
