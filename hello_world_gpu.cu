
 #include <stdio.h>

 __global__ void kernel(){
 }

 int main(void){

   kernel <<<1,1>>> ();
   
   printf("Hola, soy tu esclavo!\n");
   
   return 0;
 }



