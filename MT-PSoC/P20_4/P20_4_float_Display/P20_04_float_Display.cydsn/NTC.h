/*  ========================================

    NTC.h
        Function declarations for calculating
        the temperature value from ADC output 
        for the NTCLE100E3***
        
        change #define constants inside the SOURCE file
        NTC.c to fit your NTC model

        # Author: Richard Grünert, 2019
        
    ========================================*/

#ifndef NTC_H
    
    #define NTC_H
    
    // calculate the NTC Resistance from measured voltage
    // Input:   voltage     [V]
    // Output:  resistance  [Ohm]
    double ADC_to_R(double measuredVoltage);
    
    // calculate the temperature in °C from NTC Resistance
    // Input:   resistance  [Ohm]
    // Output:  temperature [°C]
    double R_to_degC(double R);
    
#endif

/* [] END OF FILE */
