/*  ========================================

    This is an alternative version of NTC.h

    NTC_DS.h
        Function declarations for calculating
        the temperature value from ADC output 
        for the NTCLE100E3*** with the equation
        provided in the VISHAY datasheet
        
        change #define constants inside the SOURCE file
        NTC.c to fit your NTC model

        # Author: Richard Grünert, 2019
        
    ========================================*/

#ifndef NTC_DS_H
    
    #define NTC_DS_H
    
    // calculate the NTC Resistance from measured voltage
    // Input:   voltage     [V]
    // Output:  resistance  [Ohm]
    double ADC_to_R_DS(double measuredVoltage);
    
    // calculate the temperature in °C from NTC Resistance
    // Input:   resistance  [Ohm]
    // Output:  temperature [°C]
    double R_to_degC_DS(double R);
    
#endif

/* [] END OF FILE */
