help([[
Prepares the anaconda path
]])

family('anaconda')

whatis("loads the anaconda environment")

local home    = os.getenv("HOME")
local prefix = pathJoin(home, "anaconda")

prepend_path("PATH", pathJoin(prefix, "bin"))


