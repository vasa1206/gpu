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
    		int dev;

		HANDLE_ERROR( cudaGetDeviceCount( &dev ) );

		printf(("ID of current CUDA device: %d\n", dev);

		memset(&prop, 0, sizeof(cudaDeviceProp));

		prop.major = 1;
		prop.minor = 3;

		HANDLE_ERROR(cudaChooseDevice( ((void **) &dev_c, sizeof(int)));

		add <<<1,1>>>(2, 7, dev_c);

		HANDLE_ERROR(cudaMemcpy (&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost));
		printf(" 2+ 7 = %d\n", c);

		cudaFree(dev_c);


	HANDLE_ERROR( cudaGetDeviceCount( &count ) ); 
	for (int i=0; i< count; i++) {
        HANDLE_ERROR( cudaGetDeviceProperties( &prop, i ) );
        //Do something with our device's properties
	printf( " --- General Information for device %d ---\n", i ); printf( "Name: %s\n", prop.name );
	printf( "Compute capability: %d.%d\n", prop.major, prop.minor ); printf( "Clock rate: %d\n", prop.clockRate );
	printf( "Device copy overlap: " );
	if (prop.deviceOverlap)
		printf( "Enabled\n" ); 
		else
		printf( "Disabled\n" );
	printf( "Kernel execition timeout : " ); 
	if (prop.kernelExecTimeoutEnabled)
		printf( "Enabled\n" ); 
	else
            	printf( "Disabled\n" );
        printf( "   --- Memory Information for device %d ---\n", i );
        printf( "Total global mem:  %ld\n", prop.totalGlobalMem );
        printf( "Total constant Mem:  %ld\n", prop.totalConstMem );
        printf( "Max mem pitch:  %ld\n", prop.memPitch );
        printf( "Texture Alignment:  %ld\n", prop.textureAlignment );

             printf( "   --- MP Information for device %d ---\n", i );
           printf( "Multiprocessor count:  %d\n",
                       prop.multiProcessorCount );
           printf( "Shared mem per mp:  %ld\n", prop.sharedMemPerBlock );
           printf( "Registers per mp:  %d\n", prop.regsPerBlock );
           printf( "Threads in warp:  %d\n", prop.warpSize );
           printf( "Max threads per block:  %d\n",
                       prop.maxThreadsPerBlock );
           printf( "Max thread dimensions:  (%d, %d, %d)\n",
                       prop.maxThreadsDim[0], prop.maxThreadsDim[1],
                       prop.maxThreadsDim[2] );
           printf( "Max grid dimensions:  (%d, %d, %d)\n",
                       prop.maxGridSize[0], prop.maxGridSize[1],
                       prop.maxGridSize[2] );
           printf( "\n" );
		} 
	}
