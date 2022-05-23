"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_StructureItem is xxxxxxxxx.

Instance Variables
	items:		<Object>

items
	- xxxxx

"
Class {
	#name : #'PLC_StructureItem',
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'IDE4PLC-Operands'
}

{ #category : #'instance creation' }
PLC_StructureItem class >> newWithItem: item1 andItem: item2 [
	"Nueva instancia con 2 items cada uno deve ser un operando variable, 
	el primero de estructura y el otro de una var de un campo interno de esta estructura.
	"

	| structItem |
	
	structItem := self new.
	
	structItem add: item1.
	structItem add: item2.
	
	
	^ structItem.
	
	

]

{ #category : #'add-remove' }
PLC_StructureItem >> add: anObject [
	"Agrega anObject a su coleccion items"

	self items add: anObject.
]

{ #category : #compilation }
PLC_StructureItem >> cCompile [
	"Este representa al Objeto de programa que representa un acceso a una variable de una estructura.
	
	Devuelve el string:   item1.item2.item3 ... itemn
	ej:	StructName.VarName
	"
	
	| string |

	string := ''.

	self items do: [ :each |
		string := string , each cCompile , '.' 
		].
	
	^ string copyFrom: 1 to: (string size ) - 1.
]

{ #category : #compilation }
PLC_StructureItem >> dataType [ 
	"Devuelve el tipo de datos del objeto despues del último punto.
	Este puede ser una variable u otra estructura
	
	Este método lo utilizan los Actual Argument.
	"
	
	^ self items last dataType.
	
]

{ #category : #compilation }
PLC_StructureItem >> dataValue [ 
	"Devuelve el valor del objeto despues del último punto.
	Este puede ser una variable u otra estructura
	
	Este método lo utilizan los Actual Argument.
	"
	
	^ self  items last dataValue.
	
]

{ #category : #compilation }
PLC_StructureItem >> ilCompile [
	"Este representa al Objeto de programa que representa un acceso a una variable de una estructura.
	
	Devuelve el string:   item1.item2.item3 ... itemn
	ej:	StructName.VarName
	"
		
	^ self cCompile.
]

{ #category : #'initialize-release' }
PLC_StructureItem >> initialize [
	"comment stating purpose of message"

	items := OrderedCollection new.
]

{ #category : #testing }
PLC_StructureItem >> isPLCLiteral [
	"Devuelve true si es literal"

	^ false.
]

{ #category : #testing }
PLC_StructureItem >> isStructItem [
	"Devuelve true si es StructItem"

	^ true.
]

{ #category : #testing }
PLC_StructureItem >> isVaraible [
	"Devuelve true si es variable"

	^ false.
]

{ #category : #testing }
PLC_StructureItem >> isVoid [
	"Devuelve true si es void"

	^ false.
]

{ #category : #accessing }
PLC_StructureItem >> items [
	^ items
]

{ #category : #accessing }
PLC_StructureItem >> items: anObject [
	items := anObject
]

{ #category : #compilation }
PLC_StructureItem >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ self declaration varScopePrefix.
]
