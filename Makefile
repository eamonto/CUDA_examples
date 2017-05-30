CUFLAGS = -Wno-deprecated-gpu-targets


hello:
	nvcc hello_world.c -o hello_world.out $(CUFLAGS)

hellogpu:
	nvcc hello_world_gpu.cu -o hello_world_gpu.out $(CUFLAGS)

mem:
	nvcc mem_copy.c -o mem_copy.out $(CUFLAGS)

memgpu:
	nvcc mem_copy_gpu.cu -o mem_copy_gpu.out $(CUFLAGS)

sum:
	nvcc sum.c -o sum.out $(CUFLAGS)

sumgpu:
	nvcc sum_gpu.cu -o sum_gpu.out $(CUFLAGS)

sump:
	nvcc sum_parallel.cu -o sum_parallel.out $(CUFLAGS)

sumtb:
	nvcc sum_thr_blo.cu -o sum_thr_blo.out $(CUFLAGS)

dot:
	nvcc -arch sm_20 dot_prod.cu -o dot_prod.out $(CUFLAGS)

clean:
	rm -rf *.cu~ *.c~ *.out

all: hello hellogpu mem memgpu sum sumgpu sump sumtb dot
	


