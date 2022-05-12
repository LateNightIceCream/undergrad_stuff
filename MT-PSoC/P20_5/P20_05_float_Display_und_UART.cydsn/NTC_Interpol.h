/*  ========================================

    NTC_interpol.h
        Function declarations for calculating
        the temperature value from ADC output
        using an interpolation method
        (for the NTCLE100E3***)

        # Author: Richard Grünert, 2019
        
    ========================================*/

#ifndef NTC_INTERPOL_H
    #define NTC_INTERPOL_H
    
    // calculate the NTC Resistance from measured voltage
    // Input:   voltage     [V]
    // Output:  resistance  [Ohm]
    double ADC_to_R_Interpol(double measuredVoltage);
    
    // calculate the temperature in °C from NTC Resistance w/ interpolation function
    // Input:   resistance  [Ohm]
    // Output:  temperature [°C]
    double R_to_degC_Interpol(double R);
    
#endif


/* [] END OF FILE */
