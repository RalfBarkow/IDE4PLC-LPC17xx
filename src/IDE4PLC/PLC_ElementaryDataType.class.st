"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ElementaryDataType is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ElementaryDataType',
	#superclass : #'PLC_DataType',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_ElementaryDataType >> acceptValue: aValue [
	"Devuelve un booleano que indica si el tipo de datos acepta la constante que se le queire asignar"

	aValue isInteger 
		ifTrue: [ ^ aValue between: self minValue and: self maxValue. ] 
		ifFalse: [ ^ false ].
]

{ #category : #types }
PLC_ElementaryDataType >> acceptedDataTypes [
	"Devuelve un Array que contiene la lista de los tipos aceptados"

	^ {self keyword.}.
]

{ #category : #types }
PLC_ElementaryDataType >> initialValue [
	"Devuelve el valor inicial del tipo de dato."
	
	^ PLC_Literal newWithDataType: self andDataValue: 0.
]

{ #category : #testing }
PLC_ElementaryDataType >> isDerivedDataType [
	"Devuelve un booleano respondiendo si es un tipo derivado"

	^ false.
]

{ #category : #testing }
PLC_ElementaryDataType >> isElementaryDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ true.
]

{ #category : #testing }
PLC_ElementaryDataType >> isGenericDataType [
	"Devuelve un booleano respondiendo si es un tipo genérico"

	^ false.
]

{ #category : #testing }
PLC_ElementaryDataType >> isStructDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ false.
]

{ #category : #testing }
PLC_ElementaryDataType >> range [
	"Devuelve el rango de representacion del tipo de dato."

	^ self minValue asString , ' a ' , self maxValue asString.
]
