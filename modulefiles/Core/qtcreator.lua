help([[
Adds an Opt QtCreator to the path
]])

local version = "4.4"

family('QtCreator')

whatis("Sets up QtCreator")

local prefix = "/opt/Qt/Tools/QtCreator"

prepend_path("PATH", pathJoin(prefix, "/bin"))

