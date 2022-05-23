"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Objects is xxxxxxxxx.

Instance Variables
	objects:		<Object>

objects
	- xxxxx

"
Class {
	#name : #'PLC_Objects',
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'add-remove objects' }
PLC_Objects >> add: anObject [
	"Agrega a su OC objects un objeto"

	self objects add: anObject.
]

{ #category : #compilation }
PLC_Objects >> cCompile [
	"Devuelve el string del código C del objectProgram"
	
	| string |
	
	string := ''.
	
	self objects do: [ :each |
		string := string ,  each cCompile.
		].
	
	^ string.
]

{ #category : #compilation }
PLC_Objects >> ilCompile [
	"Devuelve el string del código IL del objectProgram"
	
	| string |
	
	string := ''.
	
	self objects do: [ :each |
		string := string ,  each ilCompile.
		].
	
	^ string.
]

{ #category : #'initialize-release' }
PLC_Objects >> initialize [
	"Inicializaciones deñ ObjectProgram"

	self objects: OrderedCollection new.
]

{ #category : #accessing }
PLC_Objects >> objects [
	
	^ objects
]

{ #category : #accessing }
PLC_Objects >> objects: anObject [
	
	objects := anObject
]
