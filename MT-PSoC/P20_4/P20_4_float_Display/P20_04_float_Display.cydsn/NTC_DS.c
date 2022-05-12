/*  ========================================

    This is an alternative version of NTC.c

    NTC_DS.c
        Function definitions for calculating
        the temperature value from ADC output
        for the NTCLE100E3***
        
        change #define constants to fit your
        NTC model (and voltage divider); default 
        values are for NTCLE100E3332
        
        This is using the VISHAY datasheet expression
            R(T) = R_ref * exp( A+B/T+C/T^2+D/T^3 )
        as a base to calculate the Temperature
        
        All temperatures in Kelvin
        
        # Author: Richard Grünert, 2019
        
    ========================================*/

    #include "NTC_DS.h"
    #include <math.h>

    //// NTC Constants
    /////////////////////////
    
    #define REF_TEMPERATURE (25 + 273.15)   // K
    #define REF_RESISTANCE   3300           // Ohm
    //#define B_REF            3977         // K
    #define A1  3.354016 * 0.001            // 1
    #define B1  2.56985  * 0.0001           // K^-1            
    #define C1  2.620131 * 0.000001         // K^-2
    #define D1  6.383091 * 0.00000001       // K^-3
    
    
    //// Circuit Constants
    /////////////////////////
    
    #define SERIES_RESISTANCE   3300 // Ohm
    #define DIVIDED_VOLTAGE     5    // Volt
    
    
    #define K_TO_C 273.15
    
    //// Function definitions
    /////////////////////////
    
    double ADC_to_R_DS(double measuredVoltage) {
    
        // voltage divider calculation
        return SERIES_RESISTANCE / ( DIVIDED_VOLTAGE / measuredVoltage - 1 );
    }
    
    double R_to_degC_DS(double R) {
        
        return 1 / ( A1 + B1 * log(R/REF_RESISTANCE) + C1 * pow( log(R/REF_RESISTANCE), 2 ) + D1 * pow( log(R/REF_RESISTANCE), 3 ) ) - K_TO_C;
    }
    
/* [] END OF FILE */
