help([[
Prepares the ganga from anaconda path
]])

whatis("loads the ganga environment")

family('anaconda')

local prefix = "/opt/anaconda/envs/Ganga"

pushenv("CONDA_DEFAULT_ENV", "Ganga")
pushenv("CONDA_PREFIX", prefix)

prepend_path("PATH", pathJoin(prefix, "bin"))

