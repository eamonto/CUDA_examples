
 #include <stdio.h>
 #include <stdlib.h>

 #define N 256*128
 #define THREADS_PER_BLOCK 128
 #define N_BLOCKS N/THREADS_PER_BLOCK

 // Kernel for dot product
 __global__ void dot( int *a, int *b, int *c ) {

   __shared__ int prod[THREADS_PER_BLOCK]; // Shared memory
   int index = blockIdx.x * blockDim.x + threadIdx.x;
   
   prod[threadIdx.x] = a[index] * b[index];
   
   __syncthreads();  // Threads synchronization
   
   if( threadIdx.x == 0) {
     int par_sum = 0;
     
     for(int i=0; i<THREADS_PER_BLOCK; i++)
       par_sum += prod[threadIdx.x]; // Threads reduction
     
     atomicAdd(c,par_sum); // Blocks reduction
   }
 }


 // Main program
 int main(void){
   int *a,*b,*c;              // Host copies
   int *a_dev,*b_dev,*c_dev;  // Device copies
   int size = N*sizeof(int);  // Size of N integer
   
   // Allocate host memory
   a = (int *) malloc (size);
   b = (int *) malloc (size);
   c = (int *) malloc (sizeof(int));
   
   // Allocate device memory
   cudaMalloc( (void**)&a_dev, size);
   cudaMalloc( (void**)&b_dev, size);
   cudaMalloc( (void**)&c_dev, sizeof(int));
   
   // Initialize
   for (int i=0; i<N; i++){  
     a[i] = 1;
     b[i] = 1;
   }
   *c = 0;
   
   // Copy inputs to device
   cudaMemcpy( a_dev, a, size       , cudaMemcpyHostToDevice );
   cudaMemcpy( b_dev, b, size       , cudaMemcpyHostToDevice );
   cudaMemcpy( c_dev, c, sizeof(int), cudaMemcpyHostToDevice );
   
   // Launch kernel on device
   dot <<< N_BLOCKS , THREADS_PER_BLOCK >>> (a_dev, b_dev, c_dev);
   
   // Copy device result back to host
   cudaMemcpy( c, c_dev, sizeof(int), cudaMemcpyDeviceToHost );
   
   // Print result
   printf("%d\n",*c);
   
   // Free device memory
   cudaFree(a_dev);
   cudaFree(b_dev);
   cudaFree(c_dev);
   
   // Free host memory
   free(a);
   free(b);
   free(c);
   
   return 0;
 }
