help([[
This is the modulefile for the LLVM compiler
]])

local version = "4.0"

whatis("Name: LLVM " .. version)
whatis("Version " .. version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.llvm.org/")
whatis("Description: LLVM compiler family")

family("compiler")

local prefix = "/usr/local/opt/llvm"
local bin = pathJoin(prefix, "bin")
local lib = pathJoin(prefix, "lib")
local include = pathJoin(prefix, "include")

prepend_path("PATH", bin)

setenv("LDFLAGS", "-L" .. lib .. " -Wl,-rpath," .. lib)
setenv("CPPFLAGS", "-I" .. include)

setenv("C_INCLUDE_PATH", include)

setenv("CC",  pathJoin(bin, "clang"))
setenv("CXX", pathJoin(bin, "clang++"))

local mroot = os.getenv("MODULEPATH_ROOT")
local mdir = pathJoin(mroot, "Compiler", "llvm", version)
prepend_path("MODULEPATH", mdir)


