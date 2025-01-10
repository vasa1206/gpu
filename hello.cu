#include <stdio.h>
#include <iostream>
#include <book.h>

__global__ void add(int a, int b, int *c) {
	*c = a + b;
}

__global__ void kernel(void) {
	printf("in kernel\n");
}

int main(void) {
		int c;
		int *dev_c;
		
		HANDLE_ERROR(cudaMalloc((void**)&dev_c, sizeof(int)));

		add<1,1>>>(2, 7, dev_c);

		HANDLE_ERROE(cudaMencpy(&c, dev_c, sizeof(int), cudaMencpyDeviceToHost));

		printf("2 + 7 = %d\n", c);

		cudaFree(dev_c);

		printf("Hello World!\n");

		return(0);
}
