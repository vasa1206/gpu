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
    		cudaDeviceProp  prop;
    		int count;

		HANDLE_ERROR( cudaGetDeviceCount( &count ) );

		HANDLE_ERROR(cudaMalloc ((void **) &dev_c, sizeof(int)));

		add <<<1,1>>>(2, 7, dev_c);

		HANDLE_ERROR(cudaMemcpy (&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost));
		printf(" 2+ 7 = %d\n", c);

		cudaFree(dev_c);

		//kernel <<<1,1>>>();

		//printf("Hello World!\n");


	HANDLE_ERROR( cudaGetDeviceCount( &count ) ); 
//	for (int i=0; i< count; i++) {
 //       HANDLE_ERROR( cudaGetDeviceProperties( &prop, i ) );
        //Do something with our device's properties
//		printf("%s\n", *prop.name);
//		} 
//	}
	return(0);
}
