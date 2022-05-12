/******************************************************************************
* Project Name		: CE95277 ADC and UART
* File Name			: main.c
* Version 			: **
* Device Used		: CY8C5888LTI-LP097
* Software Used		: PSoC Creator 3.1 CP1
* Compiler    		: ARM GCC 4.8.4, ARM RVDS Generic, ARM MDK Generic
* Related Hardware	: CY8CKIT059 PSoC 5 LP Prototyping Kit 
* Owner				: KLMZ
*
********************************************************************************
* Copyright (2015), Cypress Semiconductor Corporation. All Rights Reserved.
*******************************************************************************/

/*

Weiterentwicklung des Projekts VoltageDisplay_DelSigADC
unter der Zielstellung "Demonstration von Ausgabevarianten"

z.B.;
    a) ConstString
    b) Zeichenfeld (array)
    c) integer Wert
    d) float Wert

In C kann eine float-Variable mit
    sprintf(str, "%.lf", f_res);
in einen String umgewandelt werden (header: stdio.h)
    
===========================================================
Nötige Modifikationen:

1.) Project -> Build Settings -> Arm -> Linker -> Additional Libraries -> Eintrag m
2.) Project -> Build Settings -> Arm -> Linker -> Command line -> Eintrag -u _printf_float

Hinweise aus dem Cypress dev forum:
3.) use newlib-nano (in build settings)
4.) and when using floats allow formatting by newlib-nano
5.) Do not forget to increase the heap
        in .cydwr, System tab: to 200 (hex) => 0x200 = 512 dez

*/

/*

    changed in original example project:
        - LCD added
        - "send Emulated data" removed bc not needed

*/

#include <device.h>
#include "stdio.h"
#include "LCD_ST7066.h"
#include "NTC.h"
#include "NTC_DS.h"
#include "NTC_Interpol.h"

/* Project Defines */
#define FALSE  0
#define TRUE   1
#define TRANSMIT_BUFFER_SIZE  16

#define DISPLAYSTR_SIZE 11

#define USBUART_BUFFER_SIZE (64u)
#define LINE_STR_LENGTH (20u)

/*******************************************************************************
* Function Name: main
********************************************************************************
*
* Summary:
*  main() performs following functions:
*  1: Starts the ADC and UART components.
*  2: Checks for ADC end of conversion.  Stores latest result in output
*     if conversion complete.
*  3: Checks for UART input.
*     On 'C' or 'c' received: transmits the last sample via the UART.
*     On 'S' or 's' received: continuously transmits samples as they are completed.
*     On 'X' or 'x' received: stops continuously transmitting samples.
*     On 'E' or 'e' received: transmits a dummy byte of data.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
*******************************************************************************/


void main()
{
    //// Variables
    /////////////////////////
    
    /* Variable to store ADC result */
    uint32 Output;
    /* Variable to store UART rec/peived character */
    uint8 Ch;
    /* Flags used to store transmit data commands */
    uint8 ContinuouslySendData;
    uint8 SendSingleByte;

    /* Transmit Buffer */
    char TransmitBuffer[TRANSMIT_BUFFER_SIZE];
    
    /* Spannungswert als floting point */
    double dfUinVolt = 0;
    /* Temperaturwert */
    double temperature   = 0;
    double temperatureDS = 0;
    double temperatureInterpol = 0;
    
    char displayStr[DISPLAYSTR_SIZE] = {}; // check String/Array size! 
    char displayStr_DS[DISPLAYSTR_SIZE] = {}; // datasheet calculation
    

    //// LCD initialization
    /////////////////////////
    
    #if (CY_PSOC3 || CY_PSOC5LP)
        
        uint8 state;
        char8 lineStr[LINE_STR_LENGTH];
        
        if(LCD_initVar == 0u) { // keine initialisierung
        
            // LCD_Init();
            LCD_ST7066_Init_a();
            LCD_initVar=1u;
            
        }
        
        // Turn on the LCD
        LCD_Enable();
        
        // Start LCD, set position, print strings
        LCD_Start();
        
        LCD_Position(0,0);
        LCD_PrintString("Normal:"); // at position 9 now
        
        LCD_Position(1,0);
        LCD_PrintString("DS dif:");
        
    #endif
    
    //// ADC and UART setting
    /////////////////////////
    
    /* Start the components */
    ADC_DelSig_1_Start();
    UART_1_Start();
    
    /* Initialize Variables */
    ContinuouslySendData = FALSE;
    SendSingleByte = FALSE;
    
    /* Start the ADC conversion */
    ADC_DelSig_1_StartConvert();
    
    /* Send message to verify COM port is connected properly */
    UART_1_PutString("COM Port Open");
    
    
    /* Output string on LCD. */
    Output = ADC_DelSig_1_CountsTo_mVolts(ADC_DelSig_1_GetResult16());
    
    
    //// Loop
    /////////////////////////
    
    for(;;)
    {
        /* Non-blocking call to get the latest data recieved  */
        Ch = UART_1_GetChar();
        /* Set flags based on UART command */
        switch(Ch)
        {
            case 0:
                /* No new data was recieved */
                break;
            case 'C':
            case 'c':
                SendSingleByte = TRUE;
                break;
            case 'S':
            case 's':
                ContinuouslySendData = TRUE;
                break;
            case 'X':
            case 'x':
                ContinuouslySendData = FALSE;
                break;
			default:
                /* Place error handling code here */
                break;    
        }
        
        /* Check to see if an ADC conversion has completed */
        if(ADC_DelSig_1_IsEndConversion(ADC_DelSig_1_RETURN_STATUS))
        {
            /* Use the GetResult16 API to get an 8 bit unsigned result in
             * single ended mode.  The API CountsTo_mVolts is then used
             * to convert the ADC counts into mV before transmitting via
             * the UART.  See the datasheet API description for more
             * details */
            Output = ADC_DelSig_1_CountsTo_mVolts(ADC_DelSig_1_GetResult16());
            
            
            //sprintf(TransmitBuffer, "%lu", Output);
            
            
            ///// Calc Temperatures 
            /////////////////////////
            
            // Calculate voltage in V
            dfUinVolt = 0.001*Output;
            
            // Calculate temperatures in °C
            temperature         = R_to_degC(ADC_to_R(dfUinVolt));
            temperatureDS       = R_to_degC_DS(ADC_to_R_DS(dfUinVolt));
            temperatureInterpol = R_to_degC_Interpol(ADC_to_R_Interpol(dfUinVolt));

            ///// UART send
            /////////////////////////
            
            /* Send data based on last UART command */
            if(SendSingleByte || ContinuouslySendData)
            {
                /* Format ADC result for transmition */
                sprintf(TransmitBuffer, "%.3f,%.3f,%.3f\n", temperature, temperatureDS, temperatureInterpol);
                //sprintf(TransmitBuffer, "%.1f\n\r", temperature);
                /* Send out the data */
                UART_1_PutString(TransmitBuffer);
                /* Reset the send once flag */
                SendSingleByte = FALSE;
                
            } // emulation branch removed 
            
        }
        
        ///// Output to Display 
        /////////////////////////

        // Convert voltage to "floating point" string and display it on LCD
        sprintf( displayStr,    "%.3f %cC", temperature,               223 );
        sprintf( displayStr_DS, "%.3f %cC", temperature-temperatureDS, 223 );
        
        // delete right half of upper row and write new row
        LCD_Position(0,9);
        for(char i=0; i < 11; i++) {
            LCD_WriteData(0x20); // write 0x20 (=space) 11 times from [0,9] to [0,19]
        }
        
        LCD_Position(1,9);
        for(char i=0; i < 11; i++) {
            LCD_WriteData(0x20); // write 0x20 (=space) 11 times from [0,9] to [0,19]
        }
        
        // reset LCD position and write
        LCD_Position(0,9);
        LCD_PrintString(displayStr);
        
        LCD_Position(1,9);
        LCD_PrintString(displayStr_DS);
        
        /////////////////////////
        
        // artificially reduce sampling frequency
        CyDelay(21u);
        
    } // end of for loop
}


/* [] END OF FILE */
