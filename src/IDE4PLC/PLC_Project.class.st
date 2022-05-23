"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Project is xxxxxxxxx.

Instance Variables
	hardwareConfigurations:		<Object>
	libraries:		<Object>

hardwareConfigurations
	- xxxxx

libraries
	- xxxxx

"
Class {
	#name : #'PLC_Project',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'hardwareConfigurations',
		'libraries'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_Project class >> newWithName: aString [ 
	"Crea una nueva isntancia con el nombre indicado"

	| project |
	
	project := self new.
	project projectName: aString.
	
	^ project.
]

{ #category : #'Hardware Configuration' }
PLC_Project >> addHardwareConfiguration [
	"Añade una nueva Configuración de Hardware vacía"

	| hardConfig |
	
	hardConfig := PLC_HardwareConfiguration new.

	hardwareConfigurations add: hardConfig.
	
	^ hardConfig.
]

{ #category : #'Hardware Configuration' }
PLC_Project >> addHardwareConfiguration: hardConfig [
	"Añade la Configuración de Hardware que le llega como parámetro"

	hardwareConfigurations add: hardConfig.
	
	^ hardConfig.
]

{ #category : #accessing }
PLC_Project >> hardwareConfigurations [
	
	^ hardwareConfigurations
]

{ #category : #accessing }
PLC_Project >> hardwareConfigurations: anObject [
	
	hardwareConfigurations := anObject
]

{ #category : #'initialize-release' }
PLC_Project >> initialize [.
	"Inicializo el Proyecto."

	libraries := PLC_Libraries uniqueInstance.
	
	hardwareConfigurations := OrderedCollection new.

	
]

{ #category : #accessing }
PLC_Project >> libraries [
	^ libraries
]

{ #category : #accessing }
PLC_Project >> libraries: anObject [
	libraries := anObject
]

{ #category : #accessing }
PLC_Project >> projectName [

	^ self identifier
]

{ #category : #accessing }
PLC_Project >> projectName: anObject [
	
	self identifier: anObject.
]

{ #category : #'Hardware Configuration' }
PLC_Project >> removeHardwareConfiguration: hardConfig [
	"Añade la Configuración de Hardware que le llega como parámetro"

	hardwareConfigurations remove: hardConfig.
	
	^ hardConfig.
]
