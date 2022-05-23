"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LocatedSymbolicVariableDecl is xxxxxxxxx.

Instance Variables
	physicalAddress:		<Object>

physicalAddress
	- xxxxx

"
Class {
	#name : #'PLC_LocatedSymbolicVariableDecl',
	#superclass : #'PLC_VariableDecl',
	#instVars : [
		'physicalAddress'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_LocatedSymbolicVariableDecl class >> newWithDataType: aDataType andInitialValue: anInitialValue andIdentifier: anIdentifier andPhysicalAddress: aPhysicalAddress [
	"Nueva instancia con tipo de datos, valor inicial e identificador seteados"

	| var |
	
	var := self newWithDataType: aDataType andInitialValue: anInitialValue andIdentifier: anIdentifier.
	
	aPhysicalAddress
		ifNotNil: [
			var	physicalAddress: aPhysicalAddress.
			]. 
	
	^ var.
]

{ #category : #compilation }
PLC_LocatedSymbolicVariableDecl >> cCompile [
	"Compila la declaración de variable a C"

	"NO SE COMO PONERLE EL VALOR INICIAL A LA MACRO"

	self cCompileWithoutInitialValue.

]

{ #category : #compilation }
PLC_LocatedSymbolicVariableDecl >> cCompileWithoutInitialValue [
	"Compila la declaración de variable a C

	HACER   COMO  MACRO !!!

	Ejemplos de macros en C:
	
	#define PI 3.14
	#define AREA_CIRCULO(x) PI * (x) * (x)
	
	Devuelve:
	
	#define NombreVariable %I0.X.x0
	
	"

	^ '#define ' , self identifier , ' ' , self physicalAddress cCompile.

]

{ #category : #compilation }
PLC_LocatedSymbolicVariableDecl >> ilCompileWithoutInitialValue [
	"Compila la declaración de variable a IL

	Devuelve:
	
	NombreVariable :  tipoDeDatos
	
	Ej: 
	
	MyBit AT %I0.0  :  BOOL
	
	"
		
	^  self identifier , ' AT ' , self physicalAddress ilCompile , ' : ' ,  self dataType ilCompileDataType.
	

]

{ #category : #accessing }
PLC_LocatedSymbolicVariableDecl >> physicalAddress [
	
	^ physicalAddress
]

{ #category : #accessing }
PLC_LocatedSymbolicVariableDecl >> physicalAddress: anObject [
	
	physicalAddress := anObject
]
