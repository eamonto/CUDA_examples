
 #include <stdio.h>
 #include <stdlib.h>

 // Kernel to give a value
 __global__ void value( int *a ){
   *a = 1;
 }

 // Main program
 int main(void){
   int *a;                     // Host memory
   int *a_dev;                 // Device memory
   int size = sizeof(int);     // size of integer
  
   a = (int *) malloc(size);            // Allocate host memory

   cudaMalloc( (void**) &a_dev, size);  // Allocate device memory
      
   value <<<1,1>>> (a_dev);             // Launch kernel on device
   
   // Copy device result back to host
   cudaMemcpy( a, a_dev, size, cudaMemcpyDeviceToHost );
   
   printf("%d\n",*a);   // Print result
   
   cudaFree(a_dev);     // Free device memory

   free(a);             // Free host memory
   
   return 0;
 }


