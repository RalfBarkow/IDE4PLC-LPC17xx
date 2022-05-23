"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LongReal is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LongReal',
	#superclass : #'PLC_Reals',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_LongReal >> bitSize [
	"Devuelve el tamaño del tipo de dato en cantidad de bits."

	^ 64.
]

{ #category : #types }
PLC_LongReal >> description [
	"Devuelve la descripción del tipo de dato."

	^ 'Real largo.'.
]

{ #category : #types }
PLC_LongReal >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #LREAL.
]

{ #category : #types }
PLC_LongReal >> maxPositiveValue [
	"Valor máximo positivo permitido del tipo de dato."
		
	^ 1.7976931348623157e308.
]

{ #category : #types }
PLC_LongReal >> minPositiveValue [
	"Valor mínimo positivo permitido del tipo de dato."
		
	^ 2.2250738585072020e-308.
]
