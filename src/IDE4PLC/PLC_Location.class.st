"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Location is xxxxxxxxx.

Instance Variables
	dataValue:		<Object>
	declaration:		<Object>

dataValue
	- xxxxx

declaration
	- xxxxx

"
Class {
	#name : #'PLC_Location',
	#superclass : #Object,
	#instVars : [
		'declaration',
		'dataValue'
	],
	#category : #'IDE4PLC-Operands'
}

{ #category : #'instance creation' }
PLC_Location class >> newWithDeclaration: varDecl andDataValue: aValue [
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
PLC_Location >> cCompile [
	"Este objeto representa a una ubicacion en memoria como operando."

	^ self declaration physicalAddress cCompile.
	
]

{ #category : #accessing }
PLC_Location >> dataType [
	"Devuelve el tipo de datos de la variable.
	Este lo conoce su Declaracion"

	^ self declaration dataType.
]

{ #category : #accessing }
PLC_Location >> dataValue [
	^ dataValue
]

{ #category : #accessing }
PLC_Location >> dataValue: anObject [

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
PLC_Location >> declaration [
	"Es un objeto PLC_SimpleSymbolicVarDecl"

	^ declaration
]

{ #category : #accessing }
PLC_Location >> declaration: anObject [
	declaration := anObject
]

{ #category : #accessing }
PLC_Location >> identifier [
	"Devuelve el identificador de su declaration"

	^ self declaration identifier.
]

{ #category : #compilation }
PLC_Location >> ilCompile [
	"Este objeto representa a la variable simbolica simple como operando."
	
	^ self declaration physicalAddress ilCompile.
]

{ #category : #'initialize-release' }
PLC_Location >> initialize [
	"Este objeto representa a la variable simbolica simple como operando."

	super initialize.
]

{ #category : #testing }
PLC_Location >> isPLCLiteral [
	"Devuelve true si es literal"

	^ false.
	
]

{ #category : #testing }
PLC_Location >> isStructItem [
	"Devuelve true si es StructItem"

	^ false.
]

{ #category : #testing }
PLC_Location >> isVaraible [
	"Devuelve true pues es variable"

	^ true.
]

{ #category : #testing }
PLC_Location >> isVoid [
	"Devuelve true si es void"

	^ false.
]

{ #category : #compilation }
PLC_Location >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ self declaration varScopePrefix.
]
