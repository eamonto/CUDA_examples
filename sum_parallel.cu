
 #include <stdio.h>
 #include <stdlib.h>

 #define N 128

 // Kernel to add N integers with N parallel blocks
 __global__ void add_block(int *a, int *b, int *c){
   c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
 }

 // Kernel to add N integers with N parallel threads
 __global__ void add_thread(int *a, int *b, int *c){
   c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
 }


 // Main program
 int main(void){

   int *a,*b,*c;              // Host copies
   int *a_dev,*b_dev,*c_dev;  // Device copies
   int size = N*sizeof(int);
   
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
   
   { // Parallel sum using threads
     
     // Launch kernel on device
     add_thread <<<1,N>>> (a_dev,b_dev,c_dev);
     
     // Copy device result back to host
     cudaMemcpy( c, c_dev, size, cudaMemcpyDeviceToHost );
     
     // Print result
     for (int i=0; i<N; i++)
       printf("%d\n",c[i]);
   }
   
   {// Parallel sum using blocks
     
    // Launch kernel on device
     add_block <<<N,1>>> (a_dev,b_dev,c_dev);
     
     // Copy device result back to host
     cudaMemcpy( c, c_dev, size, cudaMemcpyDeviceToHost );
     
     // Print result
     for (int i=0; i<N; i++)
       printf("%d\n",c[i]);
   }
   
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


