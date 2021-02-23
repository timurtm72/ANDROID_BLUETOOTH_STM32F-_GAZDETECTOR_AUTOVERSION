#include "hider.h"
//==============================================================================
double calculatePPM(double adcValue,double R0,double cal_data)
{
  return  (double) map((double)adcValue,(double)R0,(double)cal_data,0,MAX_GAS_LEVEL);
}
//==============================================================================
double map(double x, double in_min, double in_max, double out_min, double out_max)
{
  return (double)(x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
//==============================================================================
float getR0(float Rl,float  adcValue,float koef, float volt, float adcRange)
{
  float Vrl;
  float Rs;
  float R0;
  Vrl = (float)adcValue * (volt / adcRange); //Convert analog values to voltage
  Rs  = (((volt - Vrl) / Vrl) * Rl);         //Calculate sensor resistance
  R0 = (Rs / koef);
  return R0;
}
//==============================================================================
