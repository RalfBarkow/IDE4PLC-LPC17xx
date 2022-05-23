"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_DevicePhysicalAddress is xxxxxxxxx.

Instance Variables
	device:		<Object>
	index:		<Object>
	locationPrefix:		<Object>
	sizePrefix:		<Object>

device
	- xxxxx

index
	- xxxxx

locationPrefix
	- xxxxx

sizePrefix
	- xxxxx

"
Class {
	#name : #'PLC_DevicePhysicalAddress',
	#superclass : #Object,
	#instVars : [
		'device',
		'locationPrefix',
		'sizePrefix',
		'index'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_DevicePhysicalAddress class >> newWithDevice: aDevice locationPrefix: aLocation sizePrefix: aSize index: anIndex [
	"Crea una nueva instancia con los parametros indicados"

	| physicalAddress |
	
	physicalAddress := self new.
	
	physicalAddress device: aDevice.
	physicalAddress locationPrefix: aLocation.
	physicalAddress sizePrefix: aSize.
	physicalAddress index: anIndex.
	
	^ physicalAddress.
]

{ #category : #compilation }
PLC_DevicePhysicalAddress >> cCompile [ 
	"Devuelve el string de código C de este Objeto de Programa"

	"Ejemplo: I0.X.x6"

	| sizePref |

	self sizePrefix
		ifNil: [ 
			sizePref := 'X'.
			] 
		ifNotNil:[ 
			sizePref := self sizePrefix.
			 ] .	

	^ self locationPrefix, self slot asString , '.' , sizePref , '.' , sizePref asLowercase , self index asString.
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> device [
	"Es el dispositivo que contiene a esta direccion fisica"
	
	^ device
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> device: anObject [
	
	device := anObject
]

{ #category : #compilation }
PLC_DevicePhysicalAddress >> ilCompile [ 
	"Devuelve el string de código IL de este Objeto de Programa"

	"Ejemplo: %IX0.6"

	| sizePref |

	self sizePrefix
		ifNil: [ 
			sizePref := ''.
			] 
		ifNotNil:[ 
			sizePref := self sizePrefix.
			 ] .	

	^ '%' , self locationPrefix , sizePref , self slot asString , '.' , self index asString.
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> index [
	"El ultimo numero que da el numero de Io O por ejemplo"
	
	index
		ifNil: [ 
			^ 0.
			] 
		ifNotNil:[ 
			^ index.
			 ] .
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> index: anObject [
	
	index := anObject
]

{ #category : #'initialize-release' }
PLC_DevicePhysicalAddress >> initialize [
	"Inicializa el pin del PLC"
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> locationPrefix [
	"I, Q o M"
	
	locationPrefix
		ifNil: [ 
			^ 'M'.
			] 
		ifNotNil:[ 
			^ locationPrefix.
			 ] .
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> locationPrefix: anObject [
	
	locationPrefix := anObject
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> sizePrefix [
	"nil, X, B, W, D o L"
	
	^ sizePrefix
]

{ #category : #accessing }
PLC_DevicePhysicalAddress >> sizePrefix: anObject [
	
	sizePrefix := anObject
]

{ #category : #device }
PLC_DevicePhysicalAddress >> slot [
	"Devuelve su numero de Slot o RANURA pidiendoselo a su Dispositivo"

	"^ self device slot."
	
	self device 
		ifNil: [ 
			^ 0.
			] 
		ifNotNil:[ 
			^ self device slot.
			 ] .
	
]
