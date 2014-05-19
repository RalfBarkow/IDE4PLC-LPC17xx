/*------------------------------------------------------------------------

Copyright © 2012-2014 Eric Nicolás Pernia.

This file is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it 
under the terms of the GNU Lesser General Public License as published 
by the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but 
WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------------*/
/*
 * PLC_ElementaryDataTypes.h
 *
 *  Created on: 04/02/2012
 *      Author: Eric Pernia
 */

#ifndef PLC_ELEMENTARY_DATA_TYPES_H_
	#define PLC_ELEMENTARY_DATA_TYPES_H_

/* PLC Elementary data types */

	// Tipo de datos					// Tamaño 		| Rango
										//(bits) (bytes)|
	typedef bool 	 PLC_BOOL;			// 1			| 0 a 1
	typedef uint8_t  PLC_BYTE;			// 8		1	| 16#00 a 16#FF
	typedef uint16_t PLC_WORD;			// 16		2	| 16#0000 a 16#FFFF
	typedef uint32_t PLC_DWORD;			// 32		4	| 16#00000000 a 16#FFFFFFFF
	typedef uint64_t PLC_LWORD;			// 32		4	| 16#0000000000000000 a 16#FFFFFFFFFFFFFFFF

	typedef int8_t   PLC_SINT;			// 8		1	| -128 a 127
	typedef int16_t  PLC_INT;			// 16		2	| -32768 a 32767
	typedef int32_t  PLC_DINT;			// 32		4	| -2147483648 a 2147483647
	typedef int64_t  PLC_LINT;			// 64		8	| -9223372036854775808 a 9223372036854775807

	typedef uint8_t  PLC_USINT;			// 8		1	| 0 a 255
	typedef uint16_t PLC_UINT;			// 16		2	| 0 a 65535
	typedef uint32_t PLC_UDINT;			// 32		4	| 0 a 4294967295
	typedef uint64_t PLC_ULINT;			// 64		8	| -18446744073709551616 a 18446744073709551615

	typedef float 	 PLC_REAL;			// 32		4	| +/- 1.18 x 10e-38 a +/- 3.40 x 10e38
	typedef double 	 PLC_LREAL;			// 64		8	| +/- 2.23 x 10e-308 a +/- 1.79 x 10e308

	// Duración de tiempo
	typedef PLC_DINT PLC_TIME;			// 32		4	| T#-24d_20h_31m_23s_648ms a T#24d_20h_31m_23s_647ms (almacenado como DInt -2147483648ms a 2147483647ms)

	// Fechas calendario
	typedef struct						// 40		5	| D#1970-01-01 a D#2554-12-31
	{					// valor inicial
		PLC_UINT  YEAR;			// 1970		16		2	| 1970 a 2554
		PLC_USINT MONTH;		// 1		 8		1	| 1 a 12
		PLC_USINT DAY;			// 1		 8		1	| 1 a 31
		PLC_USINT WEEKDAY;		// 5		 8		1	| 1 (domingo) a 7 (sabado). Dia de la semana, lo calcula con la funcion DT_Weekday, no lo ingresa el usuario.
	}PLC_DATE;

	// Hora del día
	typedef struct						// 56		7	| TOD#00:00:00.0 a 23:59:59.999999999
	{					// valor inicial
		PLC_USINT HOUR;			// 0		 8		1	| 0 a 23
		PLC_USINT MINUTE;		// 0		 8		1	| 0 a 59
		PLC_USINT SECOND;		// 0		 8		1	| 0 a 59
		PLC_UDINT NANOSECOND;	// 0		32		4	| 0 a 999999999 (VER DEPENDE del RTC RealTimeClock DTL usa nanoseconds)
	}PLC_TIME_OF_DAY;

	// Fecha y hora día
	typedef struct						// 96	   12	| DT#1970-01-01-00:00:00.0 a DT#2554-12-31-23:59:59.999999999
	{					// valor inicial
		PLC_UINT  YEAR;			// 1970		16		2	| 1970 a 2554
		PLC_USINT MONTH;		// 1		 8		1	| 1 a 12
		PLC_USINT DAY;			// 1		 8		1	| 1 a 31
		PLC_USINT WEEKDAY;		// 5		 8		1	| 1 (domingo) a 7 (sabado)
		PLC_USINT HOUR;			// 0		 8		1	| 0 a 23
		PLC_USINT MINUTE;		// 0		 8		1	| 0 a 59
		PLC_USINT SECOND;		// 0		 8		1	| 0 a 59
		PLC_UDINT NANOSECOND;	// 0		32		4	| 0 a 999999999 (VER DEPENDE del RTC RealTimeClock DTL usa nanoseconds)
	}PLC_DATE_AND_TIME;	// Idem DTL S7 1200



  	// VER TIPOS STRING, WSTRING, BCD16 y BCD32

  	typedef struct						// Variable		| 0 a 254 caracteres en tamaño de byte
	{
		PLC_BYTE NumeroCaracteresTotal;
		PLC_BYTE NumeroCaracteresActual;
		char	 Caracteres[254];			// hasta 254 caracteres
	}PLC_STRING;

  	typedef struct						// Variable		| 0 a 254 caracteres en tamaño de byte
	{
		PLC_BYTE NumeroCaracteresTotal;
		PLC_BYTE NumeroCaracteresActual;
		int16_t	 Caracteres[254];		// hasta 254 caracteres
	}PLC_WSTRING;

	typedef int16_t PLC_BCD16;		// 16			| -999 a 999
	typedef int32_t PLC_BCD32;		// 32			| -9999999 a 9999999


#endif /* PLC_ELEMENTARY_DATA_TYPES_H_ */
