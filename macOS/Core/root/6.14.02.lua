help([[
Loads the ROOT environment from Homebrew
]])

whatis("loads the ROOT environment from Homebrew")

prefix = "/usr/local/opt/root"

prepend_path("MANPATH", pathJoin(prefix, "/man"))
prepend_path("PATH", pathJoin(prefix, "/bin"))

prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "/lib/root"))
prepend_path("DYLD_LIBRARY_PATH", pathJoin(prefix, "/lib/root"))

prepend_path("CMAKE_PREFIX_PATH", pathJoin(prefix, "/share/root/cmake"))
prepend_path("PYTHONPATH", pathJoin(prefix, "/lib/root"))

setenv("JUPYTER_PATH", pathJoin(prefix, "/etc/root/notebook"))
setenv("LIBPATH", pathJoin(prefix, "/lib/root"))
setenv("ROOTSYS", prefix)
setenv("SHLIB_PATH", pathJoin(prefix, "/lib/root"))

