
 #include <stdio.h>
 #include <stdlib.h>

 // Main program
 int main(void){

   // Host memory
   int *a;                  

   // size of integer
   int size = sizeof(int);   
   
   // Allocate host memory
   a = (int *) malloc(size); 
   
   // Assign value
   *a = 1;                     
   
   // Print result
   printf("%d\n",*a);  
   
   // Free host memory
   free(a);     
   
   return 0;
 }


