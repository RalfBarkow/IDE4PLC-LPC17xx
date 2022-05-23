"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POUBody is xxxxxxxxx.

Instance Variables
	networks:		<Object>
	pou:		<Object>

networks
	- xxxxx

pou
	- xxxxx

"
Class {
	#name : #'PLC_POUBody',
	#superclass : #Object,
	#instVars : [
		'networks',
		'pou'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_POUBody class >> newWithPOU: aPOU [
	"comment stating purpose of message"

	| body |
	
	body := self new.
	
	body pou: aPOU.
	
	^ body.
]

{ #category : #'initialize-release' }
PLC_POUBody >> initialize [.
	"Inicializo el programa Ladder."

	self networks: OrderedCollection new.
	self addNetwork.
]

{ #category : #test }
PLC_POUBody >> isUserDefined [
	"Responde True si es un cuerpo de pou definido por el usuario. si es estandar responde false"

	^ true
]

{ #category : #test }
PLC_POUBody >> language [
	"Devuelve el lenguaje del cuerpo de POU"

	^ ''
]

{ #category : #accessing }
PLC_POUBody >> networks [
	^ networks
]

{ #category : #accessing }
PLC_POUBody >> networks: anObject [
	networks := anObject
]

{ #category : #accessing }
PLC_POUBody >> pou [
	^ pou
]

{ #category : #accessing }
PLC_POUBody >> pou: anObject [
	pou := anObject
]

{ #category : #'add-remove Networks' }
PLC_POUBody >> removeNetwork: aNetworkView [
	"Remueve un nuevo Network de Bloques Conectables."

	self networks 
		remove: aNetworkView ladderController ladderNetwork.
]
