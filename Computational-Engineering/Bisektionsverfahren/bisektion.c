// Bisektionsverfahren w/ mex
// RG 2019

#include "mex.h"

#define EPSILON        0.00001
#define MAX_ITERATIONS 100

double funVal(double, char*);
double absd(double);

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {

  double* argument2 = mxGetPr( prhs[1] );
  double* argument3 = mxGetPr( prhs[2] );

  char* functionName = mxArrayToString( prhs[0] );

  // starting points of bisection
  double xA            = argument2[0];
  double xB            = argument3[0];
  double midPoint      = 0;
  unsigned short int k = 0;

  ///////////////////////////
  //// Bisection Calculation

  // check for change in sign
  if( (funVal(xA, functionName) * funVal(xB, functionName)) >= 0 ) {
    mexErrMsgTxt("Ungültiges Startintervall!");
  }

  for( k; k < MAX_ITERATIONS; k++ ) {

    midPoint = (xA + xB) / 2;

    if( (funVal(xA, functionName) * funVal(midPoint, functionName)) < 0 ) {

      xB = midPoint;

    } else {

      xA = midPoint;

    }

    if( absd(xA - xB) < EPSILON ) {

      mexPrintf("Zielgenauigkeit erreicht!\n-------------\n");
      break;
    }

    if( k == MAX_ITERATIONS ) {

      mexPrintf("Maximale Anzahl an Iterationen erreicht!\n");
    }
  }

  //mexPrintf("x0 = %lf\n", (xA+xB)/2 );
  //mexPrintf("Number of iterations: %d\n-------------\n", k);

  //mexPrintf("I have %d outputs\n", nlhs);
  if(nlhs > 0) {

    plhs[0] = mxCreateDoubleScalar( (xA+xB)/2 );
    plhs[1] = mxCreateDoubleScalar(k);
  }

}

double funVal( double point, char* funName ) {

  mxArray* argumentPointer = mxCreateDoubleScalar(point);
  mxArray* returnPointer;

  // mexCallMATLAB (number of return mxArrays, pointers to those mxArrays,
  //                number of input mxArrays, pointers to those mxArrays)
  mexCallMATLAB( 1, &returnPointer, 1, &argumentPointer, funName );

  double* result = mxGetPr( returnPointer );

  return *result;

}

double absd(double x) {
  return (x < 0) ? -x : x;
}
