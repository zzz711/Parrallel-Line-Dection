#include "utils.h"
#include <stdio.h>

__global__  whiteDect(const uchar4* const rgbaImage, unsigned char* const newImage,  int numRows, int numCols){
	int col = threadIdx.x;
	int row = blockIdx.x;
	int xID = col + row * numRows;
	uchar4 linedImage = rgbaImage[xID];	

	if(rgbaImage[xID].x != 255 && rgbaImage[xID].y != 255 && rgbaImage[xID].z != 255){//if  pixel isn't fully white
		newImage[xID] = linedImage.x * 0 + linedImage.y * 0 + linedImage.z*0; //make pixel black
	}

}

__global__  whiteToRed(const uchar4* const rgbaImage, unsigned char* const newImage,  int numRows, int numCols){
	int col = threadIdx.x;
	int row = blockIdx.x;
	int xID = col + row * numRows;
	uchar4 linedImage = rgbaImage[xID];	

	if( rgaImage[xID].x == 255 && rgaImage[xID].y == 255 && rgaImage[xID].z == 255){
		newImage[xID] = linedImage.x * 1 + linedImage.y * 0 + linedImage.z * 0; //white to red
	}

}

void lineDetect(const uchar4 * const h_rgbaImage, uchar4 * const d_rgbaImage, unsigned char* const d_greyImage, size_t numRows, size_t numCols) {


