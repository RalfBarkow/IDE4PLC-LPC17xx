"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LocatedVariableDecl is xxxxxxxxx.

Instance Variables
	physicalAddress:		<Object>

physicalAddress
	- xxxxx

"
Class {
	#name : #'PLC_LocatedVariableDecl',
	#superclass : #'PLC_VariableDecl',
	#instVars : [
		'physicalAddress'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_LocatedVariableDecl class >> newWithDataType: aDataType andInitialValue: anInitialValue andPhysicalAddress: aPhysicalAddress [
	"Nueva instancia con tipo de datos, valor inicial y direcccion seteados"

	| var initVal |
	
	var := self new.
	
	var dataType: aDataType.
	
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
		
	aPhysicalAddress
		ifNotNil: [
			var	physicalAddress: aPhysicalAddress.
			]. 
		
	^ var.
]

{ #category : #compilation }
PLC_LocatedVariableDecl >> cCompileWithoutInitialValue [
	"Compila la declaración de variable a IL	"
	
	"NO SIRVE PERO SI NO SECUELGA SI ALGUIEN LE DICE C COMPILE"	
	^ self physicalAddress cCompile.
	
]

{ #category : #compilation }
PLC_LocatedVariableDecl >> ilCompileWithoutInitialValue [
	"Compila la declaración de variable a IL	"
		
	^ 'AT ' , self physicalAddress ilCompile , ' : ' ,  self dataType ilCompileDataType.
	
]

{ #category : #accessing }
PLC_LocatedVariableDecl >> physicalAddress [
	
	^ physicalAddress
]

{ #category : #accessing }
PLC_LocatedVariableDecl >> physicalAddress: anObject [
	
	physicalAddress := anObject
]
