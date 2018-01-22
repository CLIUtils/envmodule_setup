help([[
Loads the Pythia environment
]])

local version = "8.2.3"

whatis("loads the Pythia environment")

prefix = "/opt/pythia8230"

if (depends_on) then
    depends_on("root")
else
    if (not isloaded("root")) then always_load("root") end
end

prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "/lib"))
prepend_path("DYLD_LIBRARY_PATH", pathJoin(prefix, "/lib"))

prepend_path("PATH", pathJoin(prefix, "/bin"))
prepend_path("PYTHONPATH", pathJoin(prefix, "/lib"))

