"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_StructureInitialization is xxxxxxxxx.

Instance Variables
	structDecl:		<Object>
	values:		<Object>

structDecl
	- xxxxx

values
	- xxxxx

"
Class {
	#name : #'PLC_StructureInitialization',
	#superclass : #Object,
	#instVars : [
		'structDecl',
		'values'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_StructureInitialization class >> newWithStructDecl: aStructDecl [
	"Crea una nueva instancia con aSaStructDecl."

	| structInit |
	
	structInit := self new.
	
	structInit structDecl: aStructDecl.
	
	structInit structDecl declarations do: [ :each |
		structInit values add: each initialValue.
		].
	
	^ structInit.
]

{ #category : #compilation }
PLC_StructureInitialization >> cCompile [
	"Compila a codigo C"

	| value |
	
	value := '{'.
	
	self values do: [ :each |
		value := value , '
			' ,
		each cCompile , ','.
		].
	
	value := value copyFrom: 1 to: ( value size ) - 1. "BORRO LA ULTIMA COMA DE MAS"
		
	value := value , '
		}'.
	
	^ value
]

{ #category : #compilation }
PLC_StructureInitialization >> dataValue [
	
	"PARCHEEEEEEEEEEEEEEEE"
	
	^ PLC_Literal newWithDataType: PLC_DataType Int andDataValue: 0.
]

{ #category : #compilation }
PLC_StructureInitialization >> ilCompile [
	"Compila a codigo C"

	| value |
	
	value := '('.
	
	self values do: [ :each |
		value := value , '
					' ,
		each ilCompile , ','.
		].
	
	value := value copyFrom: 1 to: ( value size ) - 1. "BORRO LA ULTIMA COMA DE MAS"
		
	value := value , '
				)'.
	
	^ value
]

{ #category : #'initialize-release' }
PLC_StructureInitialization >> initialize [
	"Inicializa la coleccion values"

	values := OrderedCollection new.
]

{ #category : #accessing }
PLC_StructureInitialization >> structDecl [
	
	^ structDecl
]

{ #category : #accessing }
PLC_StructureInitialization >> structDecl: anObject [
	
	structDecl := anObject
]

{ #category : #accessing }
PLC_StructureInitialization >> values [
	
	^ values
]

{ #category : #accessing }
PLC_StructureInitialization >> values: anObject [
	
	values := anObject
]
