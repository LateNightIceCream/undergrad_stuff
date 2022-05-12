/*  ========================================

    NTC.c
        Function definitions for calculating
        the temperature value from ADC output
        (for the NTCLE100E3***) using interpolation
        
        This is using a simple interpolation
        for demonstration purposes
        
        # Author: Richard Grünert, 2019
        
    ========================================*/

    #include "NTC.h"
    #include <math.h>
    
    
    //// Circuit Constants
    /////////////////////////
    
    #define SERIES_RESISTANCE   3300 // Ohm
    #define DIVIDED_VOLTAGE     5    // Volt

    //// Function definitions
    /////////////////////////
    
    double ADC_to_R_Interpol(double measuredVoltage) {
    
        // voltage divider calculation
        return SERIES_RESISTANCE / ( DIVIDED_VOLTAGE / measuredVoltage - 1 );
    }
    
    double R_to_degC_Interpol(double R) {
        
        return -2.0631 * pow(10, -16) * pow(R, 5) + 3.3982 * pow(10, -12) * pow(R, 4) -2.1766 * pow(10,-8) * pow(R,3) + 6.9012 * pow(10,-5)*pow(R,2) -1.1812 * 0.1 * R + 1.2319 * pow(10,2);
    }
    
/* [] END OF FILE */