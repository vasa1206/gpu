#include <stdio.h>

	__global__ void add(float *d_out, float *d_in) {
		int idx = threadIdx.x;
		float f = d_in[idx];
		d_out[idx] = f + f;
		printf("%i -> %f\n", idx, d_out[idx]);
	}

	__global__ void square(float *d_out, float *d_in) {
		int idx = threadIdx.x;
		float f = d_in[idx];
		d_out[idx] = f * f;
		printf("%i -> %f\n", idx, d_out[idx]);
	}

int main(int argc, char**argv) {
	printf("hello");

	const int ARRAY_SIZE= 1024;
	const int ARRAY_BYTES = ARRAY_SIZE *  sizeof(float);

	// declare and iniutialize CPU arrays
	float h_in[ARRAY_SIZE];
	float h_out[ARRAY_SIZE];

	for(int i=0   ; i < ARRAY_SIZE; i++) {
		h_in[i] = float(i);
	}

	/// allocate GPU memory
	float *d_in;
	float  *d_out;
	cudaMalloc((void **)&d_in, ARRAY_BYTES);
	cudaMalloc((void **)&d_out, ARRAY_BYTES);

	// Copy array to GPU
	cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

	// Launch the kernal
	square<<<1, ARRAY_SIZE>>> (d_out, d_in);
	//add<<<1, ARRAY_SIZE>>> (d_out, d_in);

	// Copy Results back to GPU
	cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

	// Cleanup
	cudaFree(d_in);
	cudaFree(d_out);
}
