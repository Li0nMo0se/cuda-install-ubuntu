#include <cuda.h>
#include <stdio.h>

#define cuda_safe_call(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code,
                      const char *file,
                      int line,
                      bool abort=true)
{
   if (code != cudaSuccess)
   {
      fprintf(stderr,"GPUassert: %s %s %d\n",
              cudaGetErrorString(code),
              file,
              line);
      if (abort)
        exit(code);
   }
}


__global__ void kernel_hello()
{
    printf("Hello from the device.\n");
}

int main()
{
    printf("Hello from the host.\n");
    kernel_hello<<<1,1>>>();
    cuda_safe_call(cudaDeviceSynchronize());
    printf("Success!\n");
    return 0;
}
