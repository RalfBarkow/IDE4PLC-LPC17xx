"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Boolean is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Boolean',
	#superclass : #'PLC_BitStrings',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #testing }
PLC_Boolean >> acceptValue: aValue [
	"Devuelve un booleano que indica si el tipo de datos acepta la constante que se le queire asignar"

	^ aValue = true or: [ aValue = false ].
]

{ #category : #wired }
PLC_Boolean >> acceptWire [
	"Responde true si el tipo de datos puede cablearse en un lenguaje gráfico si es utilizado como pin de una POU.
	No riene sentido en los lenguajes textuales."

	^ true.
]

{ #category : #types }
PLC_Boolean >> bitSize [
	"Devuelve el tamaño del tipo de dato en cantidad de bits."

	^ 1.
]

{ #category : #types }
PLC_Boolean >> description [
	"Devuelve la descripción del tipo de dato."

	^ 'Booleano, ' ,  self range asString.
]

{ #category : #types }
PLC_Boolean >> initialValue [
	"Devuelve el valor inicial del tipo de dato."
	
	^ PLC_Literal newWithDataType: self andDataValue: false.
]

{ #category : #types }
PLC_Boolean >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #BOOL.
]

{ #category : #types }
PLC_Boolean >> range [
	"Devuelve el rango de representacion del tipo de dato."

	^ '0 o 1, o bien, TRUE o FALSE'.
]
