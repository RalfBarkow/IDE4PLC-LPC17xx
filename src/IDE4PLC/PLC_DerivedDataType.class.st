"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_DerivedDataType is xxxxxxxxx.

Instance Variables
	description:		<Object>

description
	- xxxxx

"
Class {
	#name : #'PLC_DerivedDataType',
	#superclass : #'PLC_DataType',
	#instVars : [
		'description'
	],
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_DerivedDataType >> acceptValue: aValue [
	"Devuelve un booleano que indica si el tipo de datos acepta la constante que se le queire asignar"

	^ aValue structDecl = self.
]

{ #category : #types }
PLC_DerivedDataType >> acceptedDataTypes [
	"Devuelve un Array que contiene la lista de los tipos aceptados"

	^ {self keyword.}.
]

{ #category : #accessing }
PLC_DerivedDataType >> description [
	^ description
]

{ #category : #accessing }
PLC_DerivedDataType >> description: anObject [
	description := anObject
]

{ #category : #'initialize-release' }
PLC_DerivedDataType >> initialize [
	"Inicializa la declaracion de variable"
	
	description := ''.
	
]

{ #category : #testing }
PLC_DerivedDataType >> isDerivedDataType [
	"Devuelve un booleano respondiendo si es un tipo derivado"

	^ true.
]

{ #category : #testing }
PLC_DerivedDataType >> isElementaryDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ false.
]

{ #category : #testing }
PLC_DerivedDataType >> isGenericDataType [
	"Devuelve un booleano respondiendo si es un tipo genérico"

	^ false.
]

{ #category : #testing }
PLC_DerivedDataType >> isStructDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ false.
]

{ #category : #types }
PLC_DerivedDataType >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #TYPE
]
