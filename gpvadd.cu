#include "book.h"

#define N 5

__global__ void add (int *a, int *b, int *c) {
	int tid = blockIdx.x; // this is CPU zero, so we star at zero

	if (tid < N ) {
			c[tid] = a[tid] + b[tid];
	}
}

void addcpu( int *a, int *b, int *c ) {
	int tid = 0; // this is CPU zero, so we start at zero while (tid < N) {
	while(tid < N) {
        	c[tid] = a[tid] + b[tid];
		tid += 1; // we have one CPU, so we increment by one }
	}
}

int main(void) {
	int a[N], b[N], c[N];
	int *dev_a, *dev_b, *dev_c;

	// allocate GPU memory
	HANDLE_ERROR(cudaMalloc((void **) &dev_a, N * sizeof(int)));
	HANDLE_ERROR(cudaMalloc((void **) &dev_b, N * sizeof(int)));
	HANDLE_ERROR(cudaMalloc((void **) &dev_c, N * sizeof(int)));

	//fill the arrays a & b on the CPU
	for(int i = 0; i < N; i++) {
		a[i] = -i;
		b[i] = i * i;
	}

	// copy the arrays 'a' and 'b' to the GPU
	HANDLE_ERROR(cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice));
	HANDLE_ERROR(cudaMemcpy(dev_b, b, N * sizeof(int), cudaMemcpyHostToDevice));

	add <<<N, 1>>> (dev_a, dev_b, dev_c);
	//addcpu(dev_a, dev_b, dev_c);

	// copy the array 'c' back from GPU to CPU
	HANDLE_ERROR(cudaMemcpy(c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost));

	for (int i=0; i < N; i++) {
		printf("%d + %d = c %d\n", a[i], b[i], c[i]);
	}

	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);

	return 0;
}
