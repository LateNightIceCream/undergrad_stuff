/*******************************************************************************
* File Name: LCD_ST7066.c
* Version 2.10 von LCD.c buko modifizierte Funktion 
*   Einsatz der Funktion : Die Funktion LCD_ST7066_Init wurde  
*   fuer ein LCD Modul mit Sitronix ST7066 Controller angepasst 
*
*   Ansonsten wird nur die lokal deklarierte und definierte Funktion 
*   static void LCD_WrCntrlNib(uint8 nibble) ; 
*   zum Schreiben beibehalten. 
*   Alle anderen Teile wurden auskommentiert oder geloescht.  
*
*
* Description:
*  This file provides source code for the Character LCD component's API.
*
* Note:
*
********************************************************************************
* Copyright 2008-2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "CyLib.h"
#include "LCD.h"   // User Module include file name,
	// Name of Your LCD User Module has to be "LCD" !
	// If not, You have to edit function calls in LCD_ST7066.  
#include "LCD_ST7066.h"
    
// #include "LCD_ST7066_I2C.h"
// #include "I2C_1.h"



static void LCD_WrCntrlNib(uint8 nibble) ; // copy of original function 
			//  static: for usage in this file only




/*******************************************************************************
* Function Name: LCD_ST7066_Init_a nach Vorgabe von ST7066 Datenblatt 
********************************************************************************
*
* Summary:
*  Performs initialization required for the components normal work.
*  This function initializes the LCD hardware module as follows:
*        Enables a 4-bit interface
*        Clears the display
*        Enables the auto cursor increment
*        Resets the cursor to start position
*  Also, it loads a custom character set to the LCD if it was defined in the customizer.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
* Reentrant:
*  No.
*
*******************************************************************************/
void LCD_ST7066_Init_a(void) 
{
    /* INIT CODE */
    CyDelay(40u); /* Delay 40 ms */
    CyDelay(40u); /* Delay 40 ms */
    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);  /* Selects 8-bit mode, Byte=0x30, nibble=0x03u */
    
    // Anfangszustand an den PCF8574-Ports : alle Portpins auf high mit high-Z 
    // Setze ST7066.R/W auf 1, Setze ST7066.RS auf 1, Setze Enable auf 1 = high Z 
    // fuehre Enable Impuls  l - h - l aus, lese mit RS=1 und R/W=1 dummy Wert
    // im Ergebnis liegt Enable auf low und KEIN Schreibbefehl wurde ausgeloest 
//    uiPuffer[0] = (0xff); // LED.off R/W=1 RS=1 E=1 D7..4 = high-Z high Pegel
//    uiPuffer[1] = 0xef; // D4 = Enable auf low
//    uiPuffer[2] =  0xaf; // nur R/W auf Null,   
//    I2C_1_MasterWriteBuf( SLAVE7BIT_ADDRESS, &uiPuffer[0], 3, I2C_1_MODE_COMPLETE_XFER);
    
    /* Minimum of 230 ns delay */
    CyDelay(0x05u); // 5 Millisekunden, I2C Write ist dann komplett 
    CyDelayUs(0x02u); // nur 2 Mikrosekunden als Breakpointposition 
   
    
//    // LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, LCD_DISPLAY_8_BIT_INIT);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, LCD_DISPLAY_8_BIT_INIT);
//    CyDelay(0x10u);                                 /* Delay 5 ms */
//    // LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(0x10u); 
    
//    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);    /* HD44780 Selects 8-bit mode */
//    CyDelay(15u);                              /* Delay 15 ms */
//    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);    /* HD44780 Selects 8-bit mode */
//    CyDelay(1u);     /* Delay 1 ms */
//    LCD_WrCntrlNib(LCD_DISPLAY_4_BIT_INIT);    /* HD44780 Selects 4-bit mode, nibble= 0x02u */
//    CyDelay(15u);                              /* Delay 5 ms */

    // Nach WriteCtrlByte 0x30 als WriteCtrlNibble 0x03u folgt beim ST7066 ZWEIMAL 
    // der Befehl Function set 0010 1000 0x28, 
    // also NICHT das CtrlNibble-Schreiben 0x02 aus oben auskommentiertem Befehl.
    // Dann folgt zuerst Function set und wait 37us
    // LCD_WriteControl(LCD_DISPLAY_2_LINES_5x10);   /* HD44780 2 Lines by 5x10 Characters */
    LCD_WriteControl(0x28u); /* 2 Lines by 5x8 Characters */
    CyDelay(1u); // buko 1ms warten   
    
//  LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x02);
//  CyDelay(5u);
//  LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x08);
//  CyDelay(5u);

    // und als Wiederholung .. da ZWEIMAL
    LCD_WriteControl(0x28u); /* 2 Lines by 5x10 Characters */
    CyDelay(1u); // buko 1ms warten  
    
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x02);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x08);
//    CyDelay(5u);

    // buko danach Display ON/OFF Control und wait 37us
    LCD_WriteControl(LCD_DISPLAY_CURSOR_ON);    /* Turn Display, Cursor ON,  0x0Eu */
    CyDelay(1u); // buko 1ms warten, Cursor ist an, Pos. [0,0] blinkt nicht   
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x0E);
//    CyDelay(5u);
 
    /* buko dann display clear und wait 1,52ms ,  Byte = 0x01u, nibbles = 0x00u und 0x01u */
    LCD_WrCntrlNib(0x00u);    /* High Nibble 0000  */
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
    CyDelay(5u); 
    LCD_WrCntrlNib(0x01u);    /* low Nibble 0001 */
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x01);
    CyDelay(5u); 
    
//    LCD_WriteControl(LCD_CLEAR_DISPLAY);  /* HD44780 Clear LCD Screen, Byte = 0x01u */
//    CyDelay(3u); // buko 3ms warten
    
    // buko dann Entry Mode Set und 
    LCD_WriteControl(LCD_CURSOR_AUTO_INCR_ON);  /* Incr Cursor After Writes, Byte = 0x06u */
    CyDelay(1u); // buko 1ms warten
    
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x06);
//    CyDelay(5u);

    // buko Cursor Home auf Position 0,0 und wait 1,52ms 
    LCD_WriteControl(LCD_RESET_CURSOR_POSITION);  /* Set Cursor to 0,0; Byte = 0x03u  */
    CyDelay(3u);
    
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x01); // 3);
//    CyDelay(5u);

    // buko Display 0ff , cursor off Blinken off 
    LCD_WriteControl(LCD_DISPLAY_CURSOR_OFF);  /* Turn Display, Cursor OFF, Byte = 0x08u */
    CyDelay(1u); // buko 1ms warten
    
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x08);
//    CyDelay(5u);

    // buko Display on
    LCD_WriteControl(LCD_DISPLAY_ON_CURSOR_OFF);  /* Turn Display ON, Cursor OFF, Byte = 0x0Cu */
    CyDelay(5u);
    
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x00);
//    CyDelay(5u);
//    LCD_I2C_WrNib( SLAVE7BIT_ADDRESS, 0, 0x0C);
//    CyDelay(5u);
    
//    LCD_WriteControl(LCD_DISPLAY_CURSOR_ON);      /* HD44780 Turn Display, Cursor ON, Byte = 0x0Eu */
//    LCD_WriteControl(LCD_DISPLAY_2_LINES_5x10);   /* 2 Lines by 5x10 Characters, Byte = 0x2Cu */
//    LCD_WriteControl(LCD_DISPLAY_CURSOR_OFF);     /* Turn Display, Cursor OFF, Byte = 0x08u */
//    LCD_WriteControl(LCD_CLEAR_DISPLAY);          /* Clear LCD Screen, Byte = 0x01u */
//    LCD_WriteControl(LCD_DISPLAY_ON_CURSOR_OFF);  /* Turn Display ON, Cursor OFF, Byte = 0x0Cu */
//    LCD_WriteControl(LCD_RESET_CURSOR_POSITION);  /* Set Cursor to 0,0; Byte = 0x03u */


    #if(LCD_CUSTOM_CHAR_SET != LCD_NONE)
        LCD_LoadCustomFonts(LCD_customFonts);
    #endif /* LCD_CUSTOM_CHAR_SET != LCD_NONE */
}

/*******************************************************************************
* Function Name: LCD_ST7066_Init_b  wie HD44780 nur return home in 2x nibble geaendert 
********************************************************************************
*
* Summary:
*  Performs initialization required for the components normal work.
*  This function initializes the LCD hardware module as follows:
*        Enables a 4-bit interface
*        Clears the display
*        Enables the auto cursor increment
*        Resets the cursor to start position
*  Also, it loads a custom character set to the LCD if it was defined in the customizer.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
* Reentrant:
*  No.
*
*******************************************************************************/
void LCD_ST7066_Init_b(void) 
{
    /* INIT CODE */
    CyDelay(40u);                                                        /* Delay 40 ms */
    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);    /* Selects 8-bit mode */
    CyDelay(5u);                                                         /* Delay 5 ms */
    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);    /* Selects 8-bit mode */
    CyDelay(15u);                                                        /* Delay 15 ms */
    LCD_WrCntrlNib(LCD_DISPLAY_8_BIT_INIT);    /* Selects 8-bit mode */
    CyDelay(1u);                                                         /* Delay 1 ms */
    LCD_WrCntrlNib(LCD_DISPLAY_4_BIT_INIT);    /* Selects 4-bit mode */
    CyDelay(5u);                                                         /* Delay 5 ms */

    LCD_WriteControl(LCD_CURSOR_AUTO_INCR_ON);    /* Incr Cursor After Writes */
    LCD_WriteControl(LCD_DISPLAY_CURSOR_ON);      /* Turn Display, Cursor ON */
    LCD_WriteControl(LCD_DISPLAY_2_LINES_5x10);   /* 2 Lines by 5x10 Characters */
    LCD_WriteControl(LCD_DISPLAY_CURSOR_OFF);     /* Turn Display, Cursor OFF */
      
    // Ersatz des erstmaligen Aufrufs von 
    // LCD_WriteControl(LCD_CLEAR_DISPLAY); /* Clear LCD Screen */
    // durch 2 x Nibble-Schreiben: erst 0x00 dann Pause dann  0x01 dann Pause 
    // sonst kommt es ueberwiegend zu dauerhaften ReadBusyFlag auf 1 !!
    LCD_WrCntrlNib(0x00u);    /* High Nibble 0000  */
    CyDelay(5u); 
    LCD_WrCntrlNib(0x01u);    /* low Nibble 0001 */
    CyDelay(5u);                                        
    // trotzdem ist ein zweiter Aufruf erforderlich 
    LCD_WriteControl(LCD_CLEAR_DISPLAY);          /* Clear LCD Screen */

    LCD_WriteControl(LCD_DISPLAY_ON_CURSOR_OFF);  /* Turn Display ON, Cursor OFF */
    LCD_WriteControl(LCD_RESET_CURSOR_POSITION);  /* Set Cursor to 0,0 */
    CyDelay(5u);
    LCD_WriteControl(LCD_DISPLAY_ON_CURSOR_OFF);  /* Turn Display ON, Cursor OFF */
    LCD_WriteControl(LCD_RESET_CURSOR_POSITION);  /* Set Cursor to 0,0 */
    CyDelay(5u);

    #if(LCD_CUSTOM_CHAR_SET != LCD_NONE)
        LCD_LoadCustomFonts(LCD_customFonts);
    #endif /* LCD_CUSTOM_CHAR_SET != LCD_NONE */
}



/*******************************************************************************
*  Function Name: LCD_WrCntrlNib
********************************************************************************
*
* Summary:
*  Writes a control nibble to the LCD module.
*
* Parameters:
*  nibble: The byte containing a nibble in the four least significant bits.????
*
* Return:
*  None.
*
*******************************************************************************/
static void LCD_WrCntrlNib(uint8 nibble) 
{
    /* RS and RW should be low to select instruction register and  write operation respectively */
    LCD_PORT_DR_REG &= ((uint32)(~(LCD_RS | LCD_RW)));

    /* Two following lines of code will give 40ns delay */
    /* Clear data pins */
    LCD_PORT_DR_REG &= ((uint32)(~LCD_DATA_MASK));

    /* Write control data and set enable signal */
    #if(0u != LCD_PORT_SHIFT) /* MISRA forbids shift by 0 so need to handle that */
        LCD_PORT_DR_REG |= 
            (LCD_E | ((uint8)(((uint8) nibble) << LCD_PORT_SHIFT)));
    #else
        LCD_PORT_DR_REG |= (LCD_E | nibble);
    #endif /* (0u != LCD_PORT_SHIFT) */

    /* Minimum of 230 ns delay */
    CyDelayUs(1u);

    LCD_PORT_DR_REG &= ((uint32)(~LCD_E));
}


/*******************************************************************************
*  Function Name: LCD_ST7066_ClearDisplay()
********************************************************************************
*
* Summary:
* ersetzt das Makro aus LCD.h 
* see LCD.h: Clear Macro 
*    #define LCD_ClearDisplay() LCD_WriteControl(LCD_CLEAR_DISPLAY)
* 
* durch Schreiben von zwei Nibbles mit Pause dazwischen
* 
* Parameters:
* nibble: The byte containing a nibble in the four least significant bits.????
*
* Return:
*  None.
*
*******************************************************************************/
void LCD_ST7066_ClearDisplay(void)  
{
   CyDelay(1u); // buko 1ms warten, Cursor ist an
   /* buko dann display clear und wait 1,52ms ,  Byte = 0x01u, nibbles = 0x00u und 0x01u */
   LCD_WrCntrlNib(0x00u);    /* High Nibble 0000  */
   CyDelay(5u); 
   LCD_WrCntrlNib(0x01u);    /* low Nibble 0001 */
   CyDelay(5u); 
   
   // ersetzt 
   // LCD_WriteControl(LCD_CLEAR_DISPLAY);  /* HD44780 Clear LCD Screen, Byte = 0x01u */
}




/* [] END OF FILE */
