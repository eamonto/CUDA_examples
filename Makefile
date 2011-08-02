
hello:
	nvcc hello_world.c -o hello_world.out

hellogpu:
	nvcc hello_world_gpu.cu -o hello_world_gpu.out

mem:
	nvcc mem_copy.c -o mem_copy.out

memgpu:
	nvcc mem_copy_gpu.cu -o mem_copy_gpu.out

sum:
	nvcc sum.c -o sum.out

sumgpu:
	nvcc sum_gpu.cu -o sum_gpu.out

sump:
	nvcc sum_parallel.cu -o sum_parallel.out

sumtb:
	nvcc sum_thr_blo.cu -o sum_thr_blo.out

dot:
	nvcc -arch sm_20 dot_prod.cu -o dot_prod.out

clean:
	rm -rf *.cu~ *.c~ *.out
