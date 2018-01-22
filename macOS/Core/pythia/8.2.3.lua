depends_on("root")

help([[
Loads the Pythia environment
]])


local version = myModuleVersion()

whatis("loads the Pythia environment")

prefix = "/opt/pythia8230"


prepend_path("PATH", pathJoin(prefix, "/bin"))
prepend_path("PYTHONPATH", pathJoin(prefix, "/lib"))

