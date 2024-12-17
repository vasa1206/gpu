gpuconfig:
	nvcc -I . gpuconfig.cu -o gpuconfig

clean:
	rm gpuconfig
