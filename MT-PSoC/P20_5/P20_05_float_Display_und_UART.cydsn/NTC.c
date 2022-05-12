/*  ========================================

    NTC.c
        Function definitions for calculating
        the temperature value from ADC output
        for the NTCLE100E3***
        
        change #define constants to fit your
        NTC model (and voltage divider); default 
        values are for NTCLE100E3332
        
        This is using the simplified expression
            R(T) = R_ref * exp( B * (1/T - 1/T_ref) )
        as a base to calculate the Temperature, the
        maximum error to the equation provided in the
        VISHAY datasheet is around -0.9% at 40 °C
        
        All temperatures in Kelvin
        
        # Author: Richard Grünert, 2019
        
    ========================================*/

    #include "NTC.h"
    #include <math.h>

    //// NTC Constants
    /////////////////////////
    
    #define REF_TEMPERATURE (25 + 273.15)   // K
    #define REF_RESISTANCE   3300           // Ohm
    #define B_REF            3977           // K
    
    
    //// Circuit Constants
    /////////////////////////
    
    #define SERIES_RESISTANCE   3300 // Ohm
    #define DIVIDED_VOLTAGE     5    // Volt
    
    
    #define K_TO_C 273.15
    
    //// Function definitions
    /////////////////////////
    
    double ADC_to_R(double measuredVoltage) {
    
        // voltage divider calculation
        return SERIES_RESISTANCE / ( DIVIDED_VOLTAGE / measuredVoltage - 1 );
    }
    
    double R_to_degC(double R) {
        
        return 1 / ( log(R / REF_RESISTANCE) / B_REF + 1/REF_TEMPERATURE ) - K_TO_C;
    }
    
/* [] END OF FILE */
