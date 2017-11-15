help([[
Setup CUDA
]])


local version = myModuleVersion()

whatis('Description: Setup CUDA')

local prefix = "/usr/local/cuda-" .. version .. "/"

prepend_path("PATH", pathJoin(prefix, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(prefix, "lib64"))

setenv("CUDA_HOME", prefix)
setenv("CUDALOCATION", prefix)
setenv("CUDA_PATH", prefix)


