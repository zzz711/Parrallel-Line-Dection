#include "utils.h"
#include <stdio.h>

__global__  whiteDect(const uchar4* const rgbaImage, unsigned char* const newImage,  int numRows, int numCols){
	int threadsPerBlock = blockDim.x * blockDim.y;
	int blockId = blockIdx.y + (blockIdx.x * gridDim.y);
	int threadId = threadIdx.y + (threadIdx.x * blockDim.y);

	int offset = (blockId * threadsPerBlock) + threadId;;

	if(rgbaImage[offset].x == 255 && rgbaImage[offset].y == 255 && rgbaImage[offset].z == 255){//if  pixel is fully white. what if they're not fully white?
		//do something
	}
	else{
		newImag = 


