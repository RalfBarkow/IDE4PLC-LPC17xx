"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_ConnectableBlockOutputPin is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ConnectableBlockOutputPin',
	#superclass : #'PLC_ConnectableBlockPin',
	#category : #'IDE4PLC-ConnectableBlocks'
}

{ #category : #connections }
PLC_ConnectableBlockOutputPin >> connectTo: anInputPin [
	"Conecta al pin que le envio este mensaje con anInputPin si ambos estan libres. self es un output pin"

	| connec |
	
	(anInputPin isInputPin and:  [self disconnected and: [ anInputPin disconnected ] ] )
		ifTrue: [
			connec := PLC_ConnectableBlockConnection newWithInput: anInputPin andOutput: self.
			
			connec checkAutoconnectionWithPin: self andPin: anInputPin.
			
			self connection: connec.
			anInputPin connection: connec.
			
			^ connec.
			
			]
		ifFalse: [
			].
]

{ #category : #test }
PLC_ConnectableBlockOutputPin >> isOutputPin [
	"Responde true si es un pin de salida"

	^ true.
]
