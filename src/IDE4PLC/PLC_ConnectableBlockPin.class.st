"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_ConnectableBlockPin is xxxxxxxxx.

Instance Variables
	block:		<Object>
	connection:		<Object>

block
	- xxxxx

connection
	- xxxxx

"
Class {
	#name : #'PLC_ConnectableBlockPin',
	#superclass : #Object,
	#instVars : [
		'block',
		'connection'
	],
	#category : #'IDE4PLC-ConnectableBlocks'
}

{ #category : #'instance creation' }
PLC_ConnectableBlockPin class >> InputFor: aConnectableBlock [
	"Devuelve un nuevo PLC_ConnectableBlockInputPin con bloque aConnectableBlock."

	| inputPin |
	
	inputPin := PLC_ConnectableBlockInputPin new.
	inputPin block: aConnectableBlock.
	^ inputPin.

]

{ #category : #'instance creation' }
PLC_ConnectableBlockPin class >> OutputFor: aConnectableBlock [
	"Devuelve un nuevo PLC_ConnectableBlockOutputPin con bloque aConnectableBlock."

	| outputPin |
	
	outputPin := PLC_ConnectableBlockOutputPin new.
	outputPin block: aConnectableBlock.
	^ outputPin.

]

{ #category : #accessing }
PLC_ConnectableBlockPin >> block [
	^ block
]

{ #category : #accessing }
PLC_ConnectableBlockPin >> block: anObject [
	block := anObject
]

{ #category : #connection }
PLC_ConnectableBlockPin >> connected [
	"Responde true si el pin esta conectado."
	
	^ self connection isNil not.
]

{ #category : #accessing }
PLC_ConnectableBlockPin >> connection [
	^ connection
]

{ #category : #accessing }
PLC_ConnectableBlockPin >> connection: anObject [
	connection := anObject
]

{ #category : #connection }
PLC_ConnectableBlockPin >> disconnect [
	"Desconecta al pin que le envio este mensaje."

	| connect |
	
	(self connected)
		ifTrue: [
			self connection disconnect.
			]


]

{ #category : #connection }
PLC_ConnectableBlockPin >> disconnectPin [
	"Borra la conexion del pin."

	self connection: nil.
]

{ #category : #connection }
PLC_ConnectableBlockPin >> disconnected [
	"Responde true si el pin esta desconectado."
	
	^ self connection isNil.
]

{ #category : #test }
PLC_ConnectableBlockPin >> isInputPin [
	"Responde true si es un pin de entrada"

	^ false.
]

{ #category : #test }
PLC_ConnectableBlockPin >> isOutputPin [
	"Responde true si es un pin de salida"

	^ false.
]
