"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Void is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Void',
	#superclass : #'PLC_ElementaryDataType',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_Void >> acceptValue: aValue [
	"Devuelve un booleano que indica si el tipo de datos acepta la constante que se le queire asignar"

	^ false
]

{ #category : #types }
PLC_Void >> bitSize [
	"Devuelve el tamaño del tipo de dato en cantidad de bits."

	^ 0.
]

{ #category : #types }
PLC_Void >> description [
	"Devuelve la descripción del tipo de dato."

	^ 'Vacío.'.
]

{ #category : #types }
PLC_Void >> initialValue [
	"Devuelve el valor inicial del tipo de dato."
	
	^ PLC_Literal newWithDataType: self andDataValue: nil.
]

{ #category : #types }
PLC_Void >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #VOID.
]

{ #category : #types }
PLC_Void >> maxValue [
	"Valor mínimo permitido del tipo de dato."

	^ 'NULL'
]

{ #category : #types }
PLC_Void >> minValue [
	"Valor mínimo permitido del tipo de dato."

	^ 'NULL'
]
