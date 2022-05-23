"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VariableDecl is xxxxxxxxx.

Instance Variables
	dataType:		<Object>
	description:		<Object>
	initialValue:		<Object>
	operand:		<Object>
	variableCategory:		<Object>

dataType
	- xxxxx

description
	- xxxxx

initialValue
	- xxxxx

operand
	- xxxxx

variableCategory
	- xxxxx

"
Class {
	#name : #'PLC_VariableDecl',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'dataType',
		'variableCategory',
		'description',
		'initialValue',
		'operand'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_VariableDecl class >> newWithDataType: aDataType andInitialValue: anInitialValue andIdentifier: anIdentifier [
	"Nueva instancia con tipo de datos, valor inicial e identificador seteados"

	| var initVal |
	
	var := self new.
	
	var dataType: aDataType.
	
	" P A R C H E   le clavo una categoria para que haga bien lo de pxPOU->"	
	var variableCategory: PLC_VariableCategoryDecl varDecls.	
	
	anInitialValue 
		ifNil: [
			"Por defecto"
			var initialValue: aDataType initialValue.
			] 
		ifNotNil: [
			"Por defecto, si no es ninguno de los sigueintes"
			initVal := aDataType initialValue.
			
			"Si es tipo Elemental"
			( aDataType isElementaryDataType )
				ifTrue: [
					initVal := PLC_Literal 
						newWithDataType: aDataType 
						andDataValue: anInitialValue.
					].
				
			"Si es tipo Estructurado"
			( aDataType isStructDataType )
				ifTrue: [
					aDataType initialValue: anInitialValue.
					initVal := aDataType initialValue.
					].
				
			"Asigno el valor inicial"
			var initialValue: initVal.
			]. 
		
	anIdentifier
		ifNotNil: [
			var	identifier: anIdentifier.
			]. 		
		
	^ var.
]

{ #category : #'instance creation' }
PLC_VariableDecl class >> newWithDataType: aDataType andInitialValue: anInitialValue andIdentifier: anIdentifier andCategory: aCategory [
	"Nueva instancia con tipo de datos, valor inicial e identificador seteados"

	| var |
	
	var := self newWithDataType: aDataType andInitialValue: anInitialValue andIdentifier: anIdentifier.
	
	var variableCategory: aCategory.	
			
	^ var.
]

{ #category : #accept }
PLC_VariableDecl >> acceptDataType: aDataType [
	"Responde true si su tipo de datos acepta el tipo de datos"

	self dataType acceptDataType: aDataType.
]

{ #category : #accept }
PLC_VariableDecl >> acceptLiteral: aLiteral [
	"Responde true si:
		Su tipo de datos acepta el valor y
		Su tipo de datos acepta el tipo y
		Su categoría  acepta literal"
	
	^ ( self dataType acceptValue: aLiteral dataValue ) 
		and: [ 
			( self dataType acceptDataType: aLiteral dataType )
				and: [
					self variableCategory acceptLiteral
					]
			].
]

{ #category : #accept }
PLC_VariableDecl >> acceptValue: aValue [
	"Responde true si su tipo de datos acepta el valor"

	self dataType acceptValue: aValue.
]

{ #category : #accept }
PLC_VariableDecl >> acceptVariable: aVariableOperand [
	"Responde true si su tipo de datos acepta el tipo.
	
		El chequeo de si aVariableOaVariableOperand está entre las declaraciones 
		de la POU que contiene a esta declaracion se hace luego del parseo."
	
	^ self dataType acceptDataType: aVariableOperand dataType.
		

]

{ #category : #wired }
PLC_VariableDecl >> acceptWire [
	"Responde true si la declaración de variable puede cablear su variable 
	en un lenguaje gráfico si es utilizado como pin de una POU.
	Le pregunta a su categoría y a su tipo de datos para responder esto,
	No riene sentido en los lenguajes textuales. "

	^ self variableCategory acceptWire and: [ self dataType acceptWire ].
	
]

{ #category : #compilation }
PLC_VariableDecl >> cCompile [
	"Compila la declaración de variable a C

	Devuelve:
	
	tipoDeDatos NombreVariable = ValorInicial
	
	Ej: 
	
	PLC_Bool MyBit = 1;
	
	"
	| varDecl |
	
	varDecl := self cCompileWithoutInitialValue.
	
	initialValue
		ifNil: [
			^ varDecl.
			]
		ifNotNil: [
			^ varDecl , ' = ' , self initialValue cCompile.
			].
]

{ #category : #accessing }
PLC_VariableDecl >> dataType [
	^ dataType
]

{ #category : #accessing }
PLC_VariableDecl >> dataType: anObject [
	dataType := anObject
]

{ #category : #accessing }
PLC_VariableDecl >> description [
	^ description
]

{ #category : #accessing }
PLC_VariableDecl >> description: anObject [
	description := anObject
]

{ #category : #compilation }
PLC_VariableDecl >> ilCompile [
	"Compila la declaración de variable a IL

	Devuelve:
	
	NombreVariable : tipoDeDatos  := ValorInicial
	
	Ej: 
	
	MyBit : BOOL  := 1

	
	"
	| varDecl |
	
	varDecl := self ilCompileWithoutInitialValue.
	
	initialValue
		ifNil: [
			^ varDecl.
			]
		ifNotNil: [
			^ varDecl , ' := ' , self initialValue ilCompile.
			].
]

{ #category : #accessing }
PLC_VariableDecl >> initialValue [
	^ initialValue
]

{ #category : #accessing }
PLC_VariableDecl >> initialValue: anObject [
	initialValue := anObject
]

{ #category : #'initialize-release' }
PLC_VariableDecl >> initialize [
	"Inicializa la declaracion de variable"
	
	description := ''.
	
]

{ #category : #testing }
PLC_VariableDecl >> isConstant [
	"Devuelve false pues es variable"

	^ false.
]

{ #category : #testing }
PLC_VariableDecl >> isLiteral [
	"Devuelve true pues es variable"

	^ false.
]

{ #category : #testing }
PLC_VariableDecl >> isVaraible [
	"Devuelve true pues es variable"

	^ true.
]

{ #category : #accessing }
PLC_VariableDecl >> operand [
	
	operand ifNil: [ 
		operand := PLC_Variable 
			newWithDeclaration: self 
			andDataValue: self initialValue.
			].
		
	^ operand.

]

{ #category : #accessing }
PLC_VariableDecl >> operand: anObject [
	
	operand := anObject
]

{ #category : #compilation }
PLC_VariableDecl >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ self variableCategory varScopePrefix.  "==> Va este el de abajo es un PARCHE"
	
	
	"self variableCategory 
		ifNil: [ 
			^ 'pxPOU->'.
			] 
		ifNotNil: [  
			^ self variableCategory varScopePrefix.
			 ]."

	"Este parche hace que si una declaración de variable no pertenece a ninguna categoría le sampe por las dudas el pxPOU->"
]

{ #category : #accessing }
PLC_VariableDecl >> variableCategory [
	
	^ variableCategory
]

{ #category : #accessing }
PLC_VariableDecl >> variableCategory: anObject [
	
	variableCategory := anObject
]
