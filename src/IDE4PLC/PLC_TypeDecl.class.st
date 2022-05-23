"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_TypeDecl is xxxxxxxxx.

Instance Variables
	dataType:		<Object>

dataType
	- xxxxx

"
Class {
	#name : #'PLC_TypeDecl',
	#superclass : #'PLC_DerivedDataType',
	#instVars : [
		'dataType'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_TypeDecl class >> newWithDataType: type andIdentifier: ident [ 
	"cNueva isntancia con tipo de datos type e identificador ident."

	| typedef |
	
	typedef := self new.
	
	typedef dataType: type.
	typedef identifier: ident.
	
	"Añado el nuevo tipo de datos al dicccionario de tipos 
	de datos Dervidados o Creados por el usuario"
	PLC_DataType addDerivedDataType: typedef.
	
	^ typedef.
]

{ #category : #compilation }
PLC_TypeDecl >> cCompile [
	"Compila la declaración de tipo de dato estructurado a C

	Devuelve:
	
	typedef dataType dataName;
	"
	
	^ 
'		typedef ' , 
		dataType cCompile , 
		' ' , 
		self identifier , ';
'.
]

{ #category : #compilation }
PLC_TypeDecl >> cCompileDataType [
	"Compila a C"

	^ self identifier.
]

{ #category : #compilation }
PLC_TypeDecl >> cCompileWithoutInitialValue [
	"Compila la declaración de tipo de dato estructurado a C

	Devuelve:
	
	typedef dataType dataName;
	"
	
	^ '		typedef ' , 
		dataType cCompileWithoutInitialValue , 
		' ' , self identifier , ';
'.

]

{ #category : #accessing }
PLC_TypeDecl >> dataType [
	
	^ dataType
]

{ #category : #accessing }
PLC_TypeDecl >> dataType: anObject [
	
	dataType := anObject
]

{ #category : #compilation }
PLC_TypeDecl >> ilCompile [
	"Compila la declaración de tipo de dato estructurado a IL

	Devuelve:
	
	TYPE
		dataName : dataType ;
	END_TYPE
	
	"
	
	| type |
	
	type :=  '		TYPE
			' , 
	self identifier ,
	' : '.
	
	( self dataType isStructDataType )
		ifTrue: [ 
			type := type ,'
'.
			].
	
	type := type ,
		self dataType ilCompile , 
		' ;
' ,
		'		END_TYPE
'.

	^ type. 

]

{ #category : #compilation }
PLC_TypeDecl >> ilCompileWithoutInitialValue [
	"Compila la declaración de tipo de dato estructurado a IL

	Devuelve:
	
	TYPE
		dataName : dataType ;
	END_TYPE
	
	"
	
	| type |
	
	type :=  '		TYPE
	' , 
	self identifier ,
	' : '.
	
	( self dataType isStructDataType )
		ifTrue: [ 
			type := type ,'
'.
			].
	
	type := type ,
		self dataType ilCompileWithoutInitialValue , 
		' ;
' ,
		'		END_TYPE
'.

	^ type. 
]

{ #category : #'Data Types' }
PLC_TypeDecl >> initialValue [
	"Devuelve el valor inicial del tipo de dato."

	^ self dataType initialValue.
]

{ #category : #'Data Types' }
PLC_TypeDecl >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ self identifier asSymbol.
]
