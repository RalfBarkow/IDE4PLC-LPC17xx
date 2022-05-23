"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CalledPOU is xxxxxxxxx.

Instance Variables
	standardFunctionBlocks:		<Object>
	standardFunctions:		<Object>
	standardPrograms:		<Object>
	userFunctionBlocks:		<Object>
	userFunctions:		<Object>
	userPrograms:		<Object>

standardFunctionBlocks
	- xxxxx

standardFunctions
	- xxxxx

standardPrograms
	- xxxxx

userFunctionBlocks
	- xxxxx

userFunctions
	- xxxxx

userPrograms
	- xxxxx

"
Class {
	#name : #'PLC_CalledPOU',
	#superclass : #Object,
	#instVars : [
		'standardFunctions',
		'userFunctions',
		'standardFunctionBlocks',
		'userFunctionBlocks',
		'standardPrograms',
		'userPrograms'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'add - remove' }
PLC_CalledPOU >> addStandardFunctionBlocks: aPOUDeclsOrderedCollection [
	"Añade las declaraciones que le llegan como una Ordered Collection"
	
	self standardFunctionBlocks addAll: aPOUDeclsOrderedCollection asSet.
]

{ #category : #'add - remove' }
PLC_CalledPOU >> addStandardFunctions: aPOUDeclsOrderedCollection [
	"Añade las declaraciones que le llegan como una Ordered Collection"
	
	self standardFunctions addAll: aPOUDeclsOrderedCollection asSet.
]

{ #category : #'add - remove' }
PLC_CalledPOU >> addUserFunctionBlocks: aPOUDeclsOrderedCollection [
	"Añade las declaraciones que le llegan como una Ordered Collection"
	
	self userFunctionBlocks addAll: aPOUDeclsOrderedCollection asSet.
]

{ #category : #'add - remove' }
PLC_CalledPOU >> addUserFunctions: aPOUDeclsOrderedCollection [
	"Añade las declaraciones que le llegan como una Ordered Collection"
	
	self userFunctions addAll: aPOUDeclsOrderedCollection asSet.
]

{ #category : #'add - remove' }
PLC_CalledPOU >> addUserPrograms: aPOUCallsOrderedCollection [
	"Añade las declaraciones de programas a ártir de los llamados a programas que
	 le llegan como una Ordered Collection"
	
	| pouDecls |
	
	pouDecls := aPOUCallsOrderedCollection collect: [ :each | 
		each declaration.
		].

	self userPrograms addAll: pouDecls asSet.
]

{ #category : #'initialize-release' }
PLC_CalledPOU >> initialize [
	"Inicializo las colecciones, son set para evitar repetidos."

	standardFunctions := Set new.
	userFunctions := Set new.
	
	standardFunctionBlocks := Set new.
	userFunctionBlocks := Set new.
	
	standardPrograms := Set new.
	userPrograms := Set new.
]

{ #category : #accessing }
PLC_CalledPOU >> standardFunctionBlocks [
	
	^ standardFunctionBlocks
]

{ #category : #accessing }
PLC_CalledPOU >> standardFunctionBlocks: anObject [
	
	standardFunctionBlocks := anObject
]

{ #category : #accessing }
PLC_CalledPOU >> standardFunctions [
	
	^ standardFunctions
]

{ #category : #accessing }
PLC_CalledPOU >> standardFunctions: anObject [
	
	standardFunctions := anObject
]

{ #category : #accessing }
PLC_CalledPOU >> standardPrograms [
	
	^ standardPrograms
]

{ #category : #accessing }
PLC_CalledPOU >> standardPrograms: anObject [
	
	standardPrograms := anObject
]

{ #category : #accessing }
PLC_CalledPOU >> userFunctionBlocks [
	
	^ userFunctionBlocks
]

{ #category : #accessing }
PLC_CalledPOU >> userFunctionBlocks: anObject [
	
	userFunctionBlocks := anObject
]

{ #category : #accessing }
PLC_CalledPOU >> userFunctions [
	
	^ userFunctions
]

{ #category : #accessing }
PLC_CalledPOU >> userFunctions: anObject [
	
	userFunctions := anObject
]

{ #category : #accessing }
PLC_CalledPOU >> userPrograms [
	
	^ userPrograms
]

{ #category : #accessing }
PLC_CalledPOU >> userPrograms: anObject [
	
	userPrograms := anObject
]
