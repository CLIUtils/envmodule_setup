help([[
Prepares the ganga from anaconda path
]])

whatis("loads the ganga environment")

family('anaconda')

prefix = "/opt/anaconda/envs/Ganga"

pushenv("CONDA_DEFAULT_ENV", "Ganga")
pushenv("CONDA_PREFIX", "/opt/anaconda/envs/Ganga")
pushenv("PS1", [[(Ganga) [\ua@\h \W]\$ ]])


prepend_path("PATH", pathJoin(prefix, "/bin"))

