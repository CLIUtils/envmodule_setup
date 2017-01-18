help([[
Prepares the anaconda path
]])

local version = "4.2"

family('anaconda')

whatis("loads the anaconda environment")

prefix = "/opt/anaconda"

prepend_path("PATH", pathJoin(prefix, "/bin"))


