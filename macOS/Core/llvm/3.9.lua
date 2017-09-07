help([[
This is the modulefile for the LLVM compiler
]])

local version = myModuleVersion()

whatis("Name: LLVM " .. version)
whatis("Version " .. version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.llvm.org/")
whatis("Description: LLVM compiler family")

family("compiler")

local prefix = "/usr"
local bin = pathJoin(prefix, "bin")
local lib = pathJoin(prefix, "lib")
local include = pathJoin(prefix, "include")

setenv("CC",  pathJoin(bin, "clang"))
setenv("CXX", pathJoin(bin, "clang++"))

local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot, "Compiler", "llvm", version)
prepend_path("MODULEPATH", mdir)


