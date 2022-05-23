"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Literal is xxxxxxxxx.

Instance Variables
	dataType:		<Object>
	dataValue:		<Object>

dataType
	- xxxxx

dataValue
	- xxxxx

"
Class {
	#name : #'PLC_Literal',
	#superclass : #Object,
	#instVars : [
		'dataType',
		'dataValue'
	],
	#category : #'IDE4PLC-Operands'
}

{ #category : #'instance creation' }
PLC_Literal class >> newWithDataType: aType andDataValue: aValue [
	"Crea una nueva instancia"
	
	| literal |
	
	literal := self new.
	
	literal dataType: aType.
	
	"ACA SI NO ACEPTA EL VALOR DEBERIA TIRAR ERROR O PONERLE 
	EL VALOR POR DEFECTO. ELEGI PONERLE EL VALOR POR DEFECTO"	
	( aType acceptValue: aValue )
		ifTrue: [ 
			literal dataValue: aValue.
			]
		ifFalse: [ 
			"self error: 'Valor no admitido para el tipo de datos'."
			literal dataValue: aType initialValue dataValue.
			].
	
	^ literal.
]

{ #category : #compilation }
PLC_Literal >> cCompile [
	"Devuelve el string:
	
		valor
		
		ejemplo:
		
		10
	"

	^ self dataValue asString.
]

{ #category : #accessing }
PLC_Literal >> dataType [
	^ dataType
]

{ #category : #accessing }
PLC_Literal >> dataType: anObject [
	dataType := anObject
]

{ #category : #accessing }
PLC_Literal >> dataValue [
	^ dataValue
]

{ #category : #accessing }
PLC_Literal >> dataValue: anObject [
	dataValue := anObject
]

{ #category : #'actual argument' }
PLC_Literal >> identifier [
	"NO BORRAR, este mensaje se lo pide el actual argument para dibujarse"

	^ self ilCompile.
]

{ #category : #compilation }
PLC_Literal >> ilCompile [
	"Devuelve el string:
	
		keywordTipoDeDatoValor
		
		ejemplo:
		
		INT#10
	"

	^ self dataType keyword asString , '#' , self dataValue asString.
]

{ #category : #testingSubclass }
PLC_Literal >> isBitStringLiteral [
	"Devuelve true si es un PLC_BitStringlLiteral"

	^ false.
]

{ #category : #testingSubclass }
PLC_Literal >> isBooleanLiteral [
	"Devuelve true si es un PLC_BooleanLiteral"

	^ false.
]

{ #category : #testingSubclass }
PLC_Literal >> isCharacterString [
	"Devuelve true si es un PLC_CharacterString"

	^ false.
]

{ #category : #testingSubclass }
PLC_Literal >> isNumericLiteral [
	"Devuelve true si es un PLC_NumericLiteral"

	^ false.
]

{ #category : #testing }
PLC_Literal >> isPLCLiteral [
	"Devuelve true si es literal"

	^ true.
]

{ #category : #testing }
PLC_Literal >> isStructItem [
	"Devuelve true si es StructItem"

	^ false.
]

{ #category : #testingSubclass }
PLC_Literal >> isTimeLiteral [
	"Devuelve true si es un PLC_TimeLiteral"

	^ false.
]

{ #category : #testing }
PLC_Literal >> isVariable [
	"Devuelve false pues es constantee"

	^ false.
]

{ #category : #testing }
PLC_Literal >> isVoid [
	"Devuelve true si es void"

	^ false.
]
