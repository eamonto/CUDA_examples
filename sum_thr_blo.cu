
 #include <stdio.h>
 #include <stdlib.h>

 #define N 128*256
 #define THREADS_PER_BLOCK 256
 #define N_BLOCKS N/THREADS_PER_BLOCK

 // Kernel to add N integers using threads and blocks
 __global__ void add(int *a, int *b, int *c){
   int index = blockIdx.x * blockDim.x + threadIdx.x;

   c[index] = a[index] + b[index];
 }

 // Main program
 int main(void){
   int *a,*b,*c;              // Host copies
   int *a_dev,*b_dev,*c_dev;  // Device copies
   int size = N*sizeof(int);  // Size of N integer
   
   // Allocate host memory
   a = (int *) malloc (size);
   b = (int *) malloc (size);
   c = (int *) malloc (size);
   
   // Allocate device memory
   cudaMalloc( (void**)&a_dev, size);
   cudaMalloc( (void**)&b_dev, size);
   cudaMalloc( (void**)&c_dev, size);
   
   // Initialize
   for (int i=0; i<N; i++){  
     a[i] = i;
     b[i] = i;
   }
   
   // Copy inputs to device
   cudaMemcpy( a_dev, a, size, cudaMemcpyHostToDevice );
   cudaMemcpy( b_dev, b, size, cudaMemcpyHostToDevice );
   
   // Launch kernel on device
   add <<< N_BLOCKS , THREADS_PER_BLOCK >>> (a_dev,b_dev,c_dev);
   
   // Copy device result back to host
   cudaMemcpy( c, c_dev, size, cudaMemcpyDeviceToHost );
   
   // Print result
   for (int i=0; i<N; i++)
     printf("%d\n",c[i]);
   
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

