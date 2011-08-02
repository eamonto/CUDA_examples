
 #include <stdio.h>
 #include <stdlib.h>

 // Kernel to add two integers
 __global__ void add(int *a, int *b, int *c){
   *c = *a + *b;
 }

 // Main program
 int main(void){

   int *a,*b,*c;              // Host copies
   int *a_dev,*b_dev,*c_dev;  // Device copies
   int size = sizeof(int);
   
   // Allocate host memory
   a = (int *) malloc (size);
   b = (int *) malloc (size);
   c = (int *) malloc (size);
   
   // Allocate device memory
   cudaMalloc( (void**)&a_dev, size);
   cudaMalloc( (void**)&b_dev, size);
   cudaMalloc( (void**)&c_dev, size);
   
   // Initialize
   *a = 1;
   *b = 2;
   
   // Copy inputs to device
   cudaMemcpy( a_dev, a, size, cudaMemcpyHostToDevice );
   cudaMemcpy( b_dev, b, size, cudaMemcpyHostToDevice );
   
   // Launch kernel on device
   add <<<1,1>>> (a_dev,b_dev,c_dev);
   
   // Copy device result back to host
   cudaMemcpy( c, c_dev, size, cudaMemcpyDeviceToHost );
   
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
