help([[
Setup cuda.
]])

whatis('Description: Setup cuda')

local prefix = "/usr/local/cuda-8.0/"

prepend_path("PATH", pathJoin(prefix, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "lib64"))

setenv("CUDA_HOME", prefix)
setenv("CUDALOCATION", prefix)


