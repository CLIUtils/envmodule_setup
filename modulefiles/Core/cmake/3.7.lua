help([[
Prepares the path for CMake
]])

local version = "3.7.2"

family('cmake')

whatis("Prepares CMake " .. version)

local prefix = "/opt/cmake-" .. version

prepend_path("PATH", pathJoin(prefix, "/bin"))


