help([[
This is the module file for the llvm and clang compiler.
]])

local version = "4.0.1"

whatis("Name: LLVM")
whatis("Version: " .. version)
whatis("Keywords: System, Compiler")
whatis("URL: http://www.llvm.org/")
whatis("Description: LLVM compiler family")

family("compiler")

local prefix = "/opt/llvm-4.0.1"
local lib = pathJoin(prefix, "lib")
local include = pathJoin(prefix, "include")

prepend_path("PATH", pathJoin(prefix, "bin"))
prepend_path("PATH", pathJoin(prefix, "share/clang"))

setenv("CC",  pathJoin(prefix, "bin/clang"))
setenv("CXX", pathJoin(prefix, "bin/clang++"))
setenv("LDFLAGS", "-L" .. lib .. " -Wl,-rpath," .. lib)
setenv("CPPFLAGS", "-I" .. include)
