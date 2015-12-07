#include "utils.h"
#include <stdio.h>

__global__ void  whiteDect(const uchar4*  rgbaImage, unsigned char* const newImage,  int numRows, int numCols){
	int col = threadIdx.x;
	int row = blockIdx.x;
	int xID = col + row * numRows;
	uchar4 linedImage = rgbaImage[xID];	

	if(rgbaImage[xID].x < 100 && rgbaImage[xID].y < 100 && rgbaImage[xID].z < 100){//if  pixel isn't fully white
		newImage[xID] = linedImage.x * 0 + linedImage.y * 0 + linedImage.z*0; //make pixel black
	}
	
	__syncthreads();
}

__global__ void whiteToRed(const uchar4*  rgbaImage, unsigned char* const newImage,  int numRows, int numCols){
	int col = threadIdx.x;
	int row = blockIdx.x;
	int xID = col + row * numRows;
	uchar4 linedImage = rgbaImage[xID];	

	if( rgbaImage[xID].x == 255 && rgbaImage[xID].y == 255 && rgbaImage[xID].z == 255){
		newImage[xID] = linedImage.x * 255 + linedImage.y * 100 + linedImage.z * 50; //white to red
	}

	__syncthreads();
}

void lineDetect(const uchar4 * const h_rgbaImage, uchar4 * const d_rgbaImage, unsigned char* const d_greyImage, size_t numRows, size_t numCols) {
	const dim3 blockSize(numRows, 1, 1);
	const dim3 gridSize( numCols, 1, 1); 

	whiteDect<<<gridSize, blockSize>>>(d_rgbaImage, d_greyImage, numRows, numCols);
	 cudaDeviceSynchronize();
	whiteToRed<<<gridSize, blockSize>>>(d_rgbaImage, d_greyImage, numRows, numCols);
	 cudaDeviceSynchronize();
	 checkCudaErrors(cudaGetLastError());
}

