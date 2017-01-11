help([[
Loads the root environment
]])

local version = "6.06.08"

whatis("loads the ROOT environment")

prefix = "/opt/root-" .. version

prepend_path("MANPATH", joinPath(prefix, "/man:"))
prepend_path("PATH", joinPath(prefix, "/bin:"))

prepend_path("LD_LIBRARY_PATH", joinPath(prefix, "/lib"))
prepend_path("DYLD_LIBRARY_PATH", joinPath(prefix, "/lib"))

prepend_path("CMAKE_PREFIX_PATH", prefix)
prepend_path("PYTHONPATH", joinPath(prefix, "/lib"))

setenv("JUPYTER_PATH", joinPath(prefix, "/etc/notebook"))
setenv("LIBPATH", joinPath(prefix, "/lib"))
setenv("ROOTSYS", prefix)
setenv("SHLIB_PATH", joinPath(prefix, "/lib"))

