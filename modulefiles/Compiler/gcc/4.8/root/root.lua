help([[
Loads the root environment
]])

local version = "6.06.08"

whatis("loads the ROOT environment")

prefix = "/opt/root-" .. version

prepend_path("MANPATH", pathJoin(prefix, "/man"))
prepend_path("PATH", pathJoin(prefix, "/bin"))

prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "/lib"))
prepend_path("DYLD_LIBRARY_PATH", pathJoin(prefix, "/lib"))

prepend_path("CMAKE_PREFIX_PATH", prefix)
prepend_path("PYTHONPATH", pathJoin(prefix, "/lib"))

setenv("JUPYTER_PATH", pathJoin(prefix, "/etc/notebook"))
setenv("LIBPATH", pathJoin(prefix, "/lib"))
setenv("ROOTSYS", prefix)
setenv("SHLIB_PATH", pathJoin(prefix, "/lib"))

