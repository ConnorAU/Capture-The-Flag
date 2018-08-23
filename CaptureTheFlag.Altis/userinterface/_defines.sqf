/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */


#define SZ_X safezoneX
#define SZ_Y safezoneY
#define SZ_W safezoneW
#define SZ_H safezoneH

#define SZ_sizeEx(n) ((((SZ_W/SZ_H)min 1.2)/1.2)/25)*n  // (((((safezoneW/safezoneH)min 1.2)/1.2)/25)*x)
#define SZ_sizeEx_034 SZ_sizeEx(0.85)
#define SZ_sizeEx_04 SZ_sizeEx(1)

#define SZ_W_N(n) n*SZ_W
#define SZ_H_N(n) n*SZ_H

#define SZ_X_OFFSET(n) SZ_X+(SZ_W_N(n))
#define SZ_Y_OFFSET(n) SZ_Y+(SZ_H_N(n))

#define SZ_centerX		SZ_X_OFFSET(0.5)
#define SZ_centerXA(n)	(SZ_X_OFFSET(0.5))-(0.5*n)
#define SZ_centerXW(n)	(SZ_X_OFFSET(0.5))-(0.5*(SZ_W_N(n)))
#define SZ_centerY		SZ_Y_OFFSET(0.5)
#define SZ_centerYA(n)	(SZ_Y_OFFSET(0.5))-(0.5*n)
#define SZ_centerYH(n)	(SZ_Y_OFFSET(0.5))-(0.5*(SZ_H_N(n)))


//#define PX_G pixelGrid
//#define PX_W pixelW
//#define PX_H pixelH