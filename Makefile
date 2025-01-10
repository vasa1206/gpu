first:
	nvcc -I ./common first.cu -o first

hello:
	nvcc -I ./common hello.cu -o hello

hello2:
	nvcc -I ./common hello2.cu -o hello2

gpuconfig:
	nvcc -I ./common gpuconfig.cu -o gpuconfig

cpu_vector_sums:
	nvcc -I ./common ./cpu_vector_sums.cu cpu_vector_sums.cu -o cpu_vector_sums

vcpuadd:
	nvcc -I ./common vcpuadd.cu -o vcpuadd

vgpuadd:
	nvcc -I ./common vgpuadd.cu -o vgpuadd

clean:
	rm gpuconfig hello vgpuadd vcpuadd
