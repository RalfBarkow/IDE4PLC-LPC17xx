"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_HardwareConfiguration is xxxxxxxxx.

Instance Variables
	devices:		<Object>
	devicesChange:		<Object>
	softwareConfiguration:		<Object>

devices
	- xxxxx

devicesChange
	- xxxxx

softwareConfiguration
	- xxxxx

"
Class {
	#name : #'PLC_HardwareConfiguration',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'softwareConfiguration',
		'devices',
		'devicesChange'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_HardwareConfiguration class >> newWithName: aString [
	"Crea una nueva isntancia con el nombre indicado"

	| hardConfig |
	
	hardConfig := self new.
	hardConfig hardConfigName: aString.
	
	^ hardConfig.
]

{ #category : #devices }
PLC_HardwareConfiguration >> addDevice: aDevice [
	"Añade un dispositivo en un nuevo slot"

	self devices add: aDevice.
	
	aDevice hardwareConfiguration: self.
	
	self devicesChange: true.
]

{ #category : #devices }
PLC_HardwareConfiguration >> addDevice: aDevice at: index [
	"Añade el dispositivo aDevice en el slot de indice index"

	self devices at: index + 1 put: aDevice.
	
	aDevice hardwareConfiguration: self.
	
	self devicesChange: true.
]

{ #category : #devices }
PLC_HardwareConfiguration >> addSlot [
	"Añade un nuevo slot"

	self devices add: nil.
	
	self devicesChange: true.
]

{ #category : #'software configuration' }
PLC_HardwareConfiguration >> createSoftwareConfiguration [
	"Crea la Configuración de Software a partir de sus dispositivos"
	
	"Si hubo un cambio de dispositivos, debe crear de nuevo la configuración de software"
	self devicesChange
		ifTrue: [ 
			
			"Crea la Configuración de Software"
			self softwareConfiguration: (
				PLC_SoftwareConfiguration 
					newFromHardwareConfiguration: self
				).
				
			"Avisa que ya no hay mas cambios"
			self devicesChange: false.
			
			].

	^ self softwareConfiguration.
	
	
]

{ #category : #accessing }
PLC_HardwareConfiguration >> devices [
	
	^ devices
]

{ #category : #accessing }
PLC_HardwareConfiguration >> devices: anObject [
	
	devices := anObject
]

{ #category : #accessing }
PLC_HardwareConfiguration >> devicesChange [
	
	^ devicesChange
]

{ #category : #accessing }
PLC_HardwareConfiguration >> devicesChange: anObject [
	
	devicesChange := anObject
]

{ #category : #accessing }
PLC_HardwareConfiguration >> hardConfigName [

	^ self identifier
]

{ #category : #accessing }
PLC_HardwareConfiguration >> hardConfigName: anObject [
	
	identifier := anObject
]

{ #category : #'initialize-release' }
PLC_HardwareConfiguration >> initialize [
	"Inicializaciones de Recurso"

	devices := OrderedCollection new.
	
	"Creo la Ranura 0. Es un dispositivo vacio con ese nombre"
	self addDevice: (PLC_DevicePLC voidDeviceWithNumber: 0). 
	
	self devicesChange: false.
]

{ #category : #'software configuration' }
PLC_HardwareConfiguration >> program [
	"Devuelve la Configuración de Software, si no Existía, la Crea"

	self softwareConfiguration
		ifNil: [ 
			self createSoftwareConfiguration.
			].
	
	^ self softwareConfiguration.
]

{ #category : #devices }
PLC_HardwareConfiguration >> removeDeviceAt: index [
	"Remueve el dispositivo en el índice indicado"

	self devices removeAt: index + 1.
	
	self devicesChange: true.
]

{ #category : #devices }
PLC_HardwareConfiguration >> removeSlotAt: index [
	"Remueve el un nuevo slot en el índice dado"

	self devices removeAt: index + 1.
	
	self devicesChange: true.
]

{ #category : #'software configuration' }
PLC_HardwareConfiguration >> resources [
	"Devuelve una Ordered Collection de Recursos a partir de sus dispositivos"
	
	^ self devices 
		collect: [ :device | 
			device resource 
			].
]

{ #category : #devices }
PLC_HardwareConfiguration >> slotFor: aDevice [
	"Devuelve el numero de slot a la dirección fisica pidiendoselo a la configuración de hardware"

	^ ( self devices indexOf: aDevice ifAbsent: [ ^ nil ] ) - 1.
]

{ #category : #accessing }
PLC_HardwareConfiguration >> softwareConfiguration [
	
	^ softwareConfiguration
]

{ #category : #accessing }
PLC_HardwareConfiguration >> softwareConfiguration: anObject [
	
	softwareConfiguration := anObject
]
