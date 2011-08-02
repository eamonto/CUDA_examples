
 #include <stdio.h>
 #include <stdlib.h>

 int main(void){

   int *a,*b,*c;
   int size = sizeof(int);
   
   // Allocate host memory
   a = (int *) malloc (size);
   b = (int *) malloc (size);
   c = (int *) malloc (size);
   
   // Initialize
   *a = 1; *b = 2;
   
   // Sum
   *c = *a + *b;

   //Print result
   printf("%d\n",*c);
   
   // Free host memory
   free(a);
   free(b);
   free(c);
   
   return 0;
 }




