/*******************************************************************************
* File Name: LCD_ST7066.h
* See original LCD.h
* Name of Your LCD User Module has to be "LCD" !
* If not, You have to edit function calls in LCD_ST7066. 
*
* Version 2.10,  buko: Aus UserModule LCD entnommene und modifizierte  
*   Funktion : Die Funktion LCD_ST7066_Init wurde  
*   fuer ein LCD Modul mit Sitronix ST7066 Controller angepasst. 
*
*   Ansonsten wird nur die lokal deklarierte und definierte Funktion 
*   static void LCD_WrCntrlNib(uint8 nibble) ; 
*   zum Schreiben beibehalten. 
*   Alle anderen Teile wurden auskommentiert oder geloescht.  

*
* Description:
*  This header file contains registers and constants associated with the
*  Character LCD component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_CHARLCD_LCD_ST7066_H)
#define CY_CHARLCD_LCD_ST7066_H


/*************************************************************
*        Function Prototypes
*    buko mit _ST7066 Ergaenzung nur bei Init und ClearDisplay 
**************************************************************/

void LCD_ST7066_Init_a(void) ;
void LCD_ST7066_Init_b(void) ;

void LCD_ST7066_ClearDisplay(void) ; 


#endif /* CY_CHARLCD_LCD_ST7066_H */


/* [] END OF FILE */
