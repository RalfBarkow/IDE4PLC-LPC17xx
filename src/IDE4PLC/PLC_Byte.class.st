"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Byte is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Byte',
	#superclass : #'PLC_BitStrings',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_Byte >> bitSize [
	"Devuelve el tamaño del tipo de dato en cantidad de bits."

	^ 8.
]

{ #category : #types }
PLC_Byte >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #BYTE.
]
