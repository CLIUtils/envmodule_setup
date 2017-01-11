help([[
Prepares the anaconda path
]])

local version = "4.2"

whatis("loads the anaconda environment")

prefix = "/anaconda"

prepend_path("PATH", pathJoin(prefix, "/bin"))


