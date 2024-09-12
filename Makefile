gpuconfig:
	nvcc -I ../CUDA-by-Example-source-code-for-the-book-s-examples/common gpuconfig.cu -o gpuconfig

clean:
	rm gpuconfig
