"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Variable is xxxxxxxxx.

Instance Variables
	dataValue:		<Object>
	declaration:		<Object>

dataValue
	- xxxxx

declaration
	- xxxxx

"
Class {
	#name : #'PLC_Variable',
	#superclass : #Object,
	#instVars : [
		'declaration',
		'dataValue'
	],
	#category : #'IDE4PLC-Operands'
}

{ #category : #'instance creation' }
PLC_Variable class >> newWithDeclaration: varDecl andDataValue: aValue [
	"Crea un nuevo operando Variable Simbolica Simple"

	| var |
	
	var := self new.
	
	var declaration: varDecl.
			
	aValue 
		ifNil: [
			var	dataValue: varDecl initialValue.
			] 
		ifNotNil: [
			var	dataValue: aValue.
			]. 
		
	^ var.
	
]

{ #category : #compilation }
PLC_Variable >> cCompile [
	"Este objeto representa a la variable simbolica simple como operando."

	^ self varScopePrefix , self identifier.
	
	"
	Debe haber una lógica aca que decida si pone el pxPOU o no:
	
	^ 'pxPOU->' , self identifier."
]

{ #category : #accessing }
PLC_Variable >> dataType [
	"Devuelve el tipo de datos de la variable.
	Este lo conoce su Declaracion"

	^ self declaration dataType.
]

{ #category : #accessing }
PLC_Variable >> dataValue [
	^ dataValue
]

{ #category : #accessing }
PLC_Variable >> dataValue: anObject [

	dataValue := anObject

	"AGREGAR CHEQUEO DE LITERAL O CONSTANTE CONTRA EL TIPO DE LA VARIABLE."

	"( self dataType acceptValue: anObject dataValue )
		ifTrue: [
			dataValue := anObject
			] 
		ifFalse:[
			self error: 'Valor no valido para el tipo de datos' , (self dataType keyword asString).
			] 
	"
]

{ #category : #accessing }
PLC_Variable >> declaration [
	"Es un objeto PLC_SimpleSymbolicVarDecl"

	^ declaration
]

{ #category : #accessing }
PLC_Variable >> declaration: anObject [
	declaration := anObject
]

{ #category : #accessing }
PLC_Variable >> identifier [
	"Devuelve el identificador de su declaration"

	^ self declaration identifier.
]

{ #category : #compilation }
PLC_Variable >> ilCompile [
	"Este objeto representa a la variable simbolica simple como operando."
	
	^ self identifier.
]

{ #category : #'initialize-release' }
PLC_Variable >> initialize [
	"Este objeto representa a la variable simbolica simple como operando."

	super initialize.
]

{ #category : #testing }
PLC_Variable >> isPLCLiteral [
	"Devuelve true si es literal"

	^ false.
	
]

{ #category : #testing }
PLC_Variable >> isStructItem [
	"Devuelve true si es StructItem"

	^ false.
]

{ #category : #testing }
PLC_Variable >> isVaraible [
	"Devuelve true pues es variable"

	^ true.
]

{ #category : #testing }
PLC_Variable >> isVoid [
	"Devuelve true si es void"

	^ false.
]

{ #category : #compilation }
PLC_Variable >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ self declaration varScopePrefix.
]
