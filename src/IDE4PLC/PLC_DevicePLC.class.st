"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_DevicePLC is xxxxxxxxx.

Instance Variables
	analogInputs:		<Object>
	analogOutputs:		<Object>
	cpu:		<Object>
	deviceName:		<Object>
	digitalInputs:		<Object>
	digitalOutputs:		<Object>
	hardwareConfiguration:		<Object>

analogInputs
	- xxxxx

analogOutputs
	- xxxxx

cpu
	- xxxxx

deviceName
	- xxxxx

digitalInputs
	- xxxxx

digitalOutputs
	- xxxxx

hardwareConfiguration
	- xxxxx

"
Class {
	#name : #'PLC_DevicePLC',
	#superclass : #Object,
	#instVars : [
		'hardwareConfiguration',
		'deviceName',
		'digitalInputs',
		'digitalOutputs',
		'analogInputs',
		'analogOutputs',
		'cpu'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_DevicePLC class >> plericLPC1769 [
	"Devuelve una instancia de PLC PLeriC"

	| devicePLC |
	
	devicePLC := self new.	
	devicePLC deviceName: 'PLeriC_LPC1769'.
	devicePLC cpu: PLC_CPU lpc1769.
	
	"Entradas Digitales"
	
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 0 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 1 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 2 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 3 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 4 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 5 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 6 ).
	devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'X' index: 7 ).
		
	"devicePLC digitalInputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'I' sizePrefix: 'B' index: 0 )."
	
	
	"Salidas Digitales"
	
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 0 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 1 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 2 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 3 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 4 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 5 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 6 ).
	devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'X' index: 7 ).
		
	"devicePLC digitalOutputs add: 
		( PLC_DevicePhysicalAddress newWithDevice: devicePLC locationPrefix: 'Q' sizePrefix: 'B' index: 0 )."
	
	^ devicePLC.
]

{ #category : #'instance creation' }
PLC_DevicePLC class >> voidDeviceWithNumber: aNumber [
	"Devuelve un dispositivo vacio para crear la ranura vacia con el numero que le llega como parametro"

	| devicePLC |
	
	devicePLC := self new.	
	devicePLC deviceName: 'Ranura_' , aNumber asString.
	
	^ devicePLC.
]

{ #category : #accessing }
PLC_DevicePLC >> analogInputs [
	^ analogInputs
]

{ #category : #accessing }
PLC_DevicePLC >> analogInputs: anObject [
	analogInputs := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> analogOutputs [
	^ analogOutputs
]

{ #category : #accessing }
PLC_DevicePLC >> analogOutputs: anObject [
	analogOutputs := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> cpu [
	^ cpu
]

{ #category : #accessing }
PLC_DevicePLC >> cpu: anObject [
	cpu := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> deviceName [
	^ deviceName
]

{ #category : #accessing }
PLC_DevicePLC >> deviceName: anObject [
	deviceName := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> digitalInputs [
	^ digitalInputs
]

{ #category : #accessing }
PLC_DevicePLC >> digitalInputs: anObject [
	digitalInputs := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> digitalOutputs [
	^ digitalOutputs
]

{ #category : #accessing }
PLC_DevicePLC >> digitalOutputs: anObject [
	digitalOutputs := anObject
]

{ #category : #accessing }
PLC_DevicePLC >> hardwareConfiguration [
	^ hardwareConfiguration
]

{ #category : #accessing }
PLC_DevicePLC >> hardwareConfiguration: anObject [
	hardwareConfiguration := anObject
]

{ #category : #collections }
PLC_DevicePLC >> includesDigitalInput: aString [.
	"Devuelve true si contiene la entrada digital que recibe como parametro.
	Este metodo se utiliza para validar los actualArguments"

	^ self digitalInputs anySatisfy: [ :each |
		each ilCompile = aString.
		].
]

{ #category : #collections }
PLC_DevicePLC >> includesDigitalOutput: aString [.
	"Devuelve true si contiene la salida digital que recibe como parametro
	Este metodo se utiliza para validar los actualArguments"

	^ self digitalOutputs anySatisfy: [ :each |
		each ilCompile = aString.
		].
]

{ #category : #'initialize-release' }
PLC_DevicePLC >> initialize [
	"comment stating purpose of message"

	| temporary variable names |
	
	deviceName  := ''.
	
	digitalInputs := OrderedCollection new.
	digitalOutputs := OrderedCollection new.
	
	analogInputs := OrderedCollection new.
	analogOutputs := OrderedCollection new.
]

{ #category : #resource }
PLC_DevicePLC >> resource [
	"Devuelve el recurso que crea si tiene CPU"

	| res |
	
	self cpu 
		ifNil: [ 
			^ nil.
			]
		ifNotNil: [ 
			
			"Creo el recurso y le asigno el porcesador y nombre, 
			la config de soft se la agrega la config cuando hace add"
			res := PLC_Resource 
				newWithName: self deviceName 
				andSoftConfig: nil 
				andProcessor: self cpu.
				
"res := PLC_Resource 
	newWithName: 'RecursoEj' 
	andSoftConfig: nil 
	andProcessor: PLC_CPU lpc1769."
				
			"Agrego las Declaraciones de las variables Globales de 
			Entradas digitales (%I0) del PLC al RECURSO"
			self digitalInputs do: [ :each |
				res globalVarDecls add: ( 
					PLC_LocatedVariableDecl 
						newWithDataType: PLC_DataType Bool 
						andInitialValue: nil 
						andPhysicalAddress: each
					).	
				].
				
			"Agrego las Declaraciones de las variables Globales de 
			Salidas digitales (%Q0) del PLC al RECURSO"
			self digitalOutputs do: [ :each |
				res globalVarDecls add: ( 
					PLC_LocatedVariableDecl 
						newWithDataType: PLC_DataType Bool 
						andInitialValue: nil 
						andPhysicalAddress: each
					).	
				].
				
			^ res.
			]. 
]

{ #category : #'physical address' }
PLC_DevicePLC >> slot [
	"Devuelve el numero de slot a la dirección fisica pidiendoselo a la configuración de hardware"

	self hardwareConfiguration
		ifNil: [
			^ 0.
			]
		ifNotNil: [
			^ self hardwareConfiguration slotFor: self.
			].
	
	 
	


]
