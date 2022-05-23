"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_ConnectableBlockConnection is xxxxxxxxx.

Instance Variables
	inputPin:		<Object>
	outputPin:		<Object>

inputPin
	- xxxxx

outputPin
	- xxxxx

"
Class {
	#name : #'PLC_ConnectableBlockConnection',
	#superclass : #Object,
	#instVars : [
		'outputPin',
		'inputPin'
	],
	#category : #'IDE4PLC-ConnectableBlocks'
}

{ #category : #'instance creation' }
PLC_ConnectableBlockConnection class >> newWithInput: anInputPin andOutput: anOutputPin [

	| tempConnection |
	
	tempConnection := self new.
	tempConnection inputPin: anInputPin;
		outputPin: anOutputPin.
	^ tempConnection.
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> blockConnectedToInput: anInputNumber [
	"Devuelve el bloque conectado a la entrada de la conexion."
	
	^ self connectedAtInput: anInputNumber.
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> blockConnectedToOutput: anOutputNumber [
	"Devuelve el bloque conectado a la salida de la conexion."
	
	^ self connectedAtOutput: anOutputNumber.
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> checkAutoconnectionWithPin: aPLC_Pin1 andPin: aPLC_Pin2 [
	"Chequea si el Bloque Conectable del OutputPin de la conexion y el 
	Bloque Conectable del InputPin de la conexion son iguales."

	(aPLC_Pin1 block = aPLC_Pin2 block) 
		ifTrue: [
			self error: 'No se puede conectar a si mismo.'.
			]. 

]

{ #category : #connection }
PLC_ConnectableBlockConnection >> checkOutputPin: anOutputPin andInputPin: anInputPin [.
	"Chequea si el Bloque Conectable del OutputPin de la conexion y el 
	Bloque Conectable del InputPin de la conexion son iguales."

	( anOutputPin isOutputPin and: [ anInputPin isInputPin ] ) 
		ifFalse: [
			self error: 'Error de direccionamiento de conexión. Se debe conectar un Pin de salida con un Pin de entrada.'.
			]. 

]

{ #category : #connection }
PLC_ConnectableBlockConnection >> connect: anOutputPin To: anInputPin [.
	"Agrega los 2 elementos que forman la conexión, es decir un bloque conectable y el número de pin correspondiente."
	
	( anOutputPin isNil or: [ anInputPin isNil ] )
		ifFalse: [ 
			self checkAutoconnectionWithPin: anOutputPin andPin: anInputPin.
			self checkOutputPin: anOutputPin andInputPin: anInputPin.
			].
		
	self outputPin: anOutputPin.
	self inputPin: anInputPin.
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> connectedAtInput: anInputNumber [
	"Devuelve el bloque a la entrada."
	
	anInputNumber = 1
		ifTrue: [
			^ self outputPin block.
			]
		ifFalse: [
			^ nil.
			].
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> connectedAtOutput: anOutputNumber [
	"Devuelve el bloque a la salida."
	
	anOutputNumber = 1
		ifTrue: [
			^ self inputPin block.
			]
		ifFalse: [
			^ nil.
			].
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> connectionToAddElement: aPLC_ElemenMorph [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ self.
	
	"Hacer que compruebe aquí si puede conectar o no el elemento nuevo pidiendole a los bloques de sus extremos si lo permiten"
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> disconnect [
	"Borra  los 2 elementos que forman la conexión, es decir, ambos pines."

	self inputPin disconnectPin.
	self outputPin disconnectPin.
	
	self connect: nil To: nil.
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> disconnectInput: anInputNumber [
	"Borra  los el pin de entrada de la conexion."

	anInputNumber = 1
		ifTrue: [
			self outputPin disconnectPin.
			self connect: nil To: self inputPin.
			].
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> disconnectOutput: anOutputNumber [
	"Borra  los 2 elementos que forman la conexión, es decir, ambos pines."

	anOutputNumber = 1
		ifTrue: [
			self inputPin disconnectPin.
			self connect: self outputPin To: nil.
			].
]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> inputPin [
	^ inputPin
]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> inputPin: anObject [
	inputPin := anObject
]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> isConnectableBlock [
	"Devuelve true si es una instancia de la clase PLC_ConnectableBlock"

	^ false.

]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> isConnection [
	"Devuelve true si es una instancia de la clase PLC_ConnectableBlockConnection"

	^ true.

]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> outputPin [
	^ outputPin
]

{ #category : #accessing }
PLC_ConnectableBlockConnection >> outputPin: anObject [
	outputPin := anObject
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> outputPinNumberConnectedToInput: anInputNumber [
	"Devuelve el Numero de pin de salida que esta conectado al pin de entrada anInputNumber."
	
	| connectableBlock |
	
	anInputNumber = 1
		ifTrue: [
			connectableBlock := self outputPin block.
			^ connectableBlock outputs indexOf: self outputPin.
			]
		ifFalse: [
			^ nil.
			].
]

{ #category : #connection }
PLC_ConnectableBlockConnection >> replaceConnectionByConnectingToInputPin: anInputPin andOutputPin: anOutputPin [
	"Elimina la conexion que recibe el mensaje y conecta el pin de salida de esa conexion al pin anInputPin,
	que puede un pin de un bloque conectado a un circuito complejo, y conecta el pin anOutputPin, que puede
	ser un pin de salida de un bloque de un circuito complejo, al pin de entrada de la conexion.
	
	self es:
	
		connectionOutputPin -----------> connectionInputPin  
	
	lo reemplazo por:
												    -------------------
		 connectionOutputPin -----------> anInputPin |    circuito   |  anOutputPin -----------> connectionInputPin  
												    -------------------
	 "
	
	| connectionOutputPin connectionInputPin |
	
	"Busco los pines de los Bloques Conectables a entrada y salida de la conexion."
	connectionOutputPin := self outputPin.
	connectionInputPin := self inputPin.
	
	"Desconecto la conexion"
	self disconnect.
	
	connectionOutputPin connectTo: anInputPin.
	anOutputPin connectTo: connectionInputPin.
]
