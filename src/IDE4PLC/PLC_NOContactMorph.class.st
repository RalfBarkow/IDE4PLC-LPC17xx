"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_NOContactMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_NOContactMorph',
	#superclass : #'PLC_ContactsAndCoils',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_NOContactMorph >> drawElementOn: aCanvas [
	"Comentario"

	aCanvas fillRectangle: self leftHBar color: self userInteractionStateLayer1 elementColor;
		fillRectangle: self leftVBar color: self userInteractionStateLayer1 elementColor;
		fillRectangle: self rightHBar color: self userInteractionStateLayer1 elementColor;
		fillRectangle: self rightVBar color: self userInteractionStateLayer1 elementColor.
		
	self drawPatchOn: aCanvas.
	

]

{ #category : #drawing }
PLC_NOContactMorph >> hBar [
	"Barra horizontal que representa el cable del contacto"

	| width height|
	
	width := (self properties scale x * 30) rounded. "Redondeo explicitamente para que se dibuje bien."	 "30"
	height := (self properties scale y * 2) rounded.	"2"
	
	^ Rectangle origin: (0@0) corner: ( width @ height ).
]

{ #category : #'instance variable' }
PLC_NOContactMorph >> instanceVariableFor: aConnectableBlock [
	"Devuelve el bloque conectable de la variable desde el bloque conectable del elemento"

	^ aConnectableBlock blockConnectedToInput: 2
]

{ #category : #'model exploration' }
PLC_NOContactMorph >> isContact [
	"Devuelve true si el elemento grafico es un Contacto."

	^ false
]

{ #category : #drawing }
PLC_NOContactMorph >> leftVBar [
	"Barra vertical  izquierda del contacto."

	^ self vBar translateBy: self backgroundRectangle origin + (self leftHBar extent x @ 0).
]

{ #category : #'commands recive from ladder view' }
PLC_NOContactMorph >> removeElementFrom: aLadderView [
	"Remueve el elemento pidiendoselo a su ladder view. Hace un double dispatching con este"
	
	aLadderView removeContact: self.
]

{ #category : #drawing }
PLC_NOContactMorph >> rightVBar [
	"Barra vertical  derecha del contacto."

	^ self vBar translateBy: self backgroundRectangle origin + (self extent x @ 0) - (self leftHBar extent x + self vBar width @ 0).
	
]

{ #category : #'connection states' }
PLC_NOContactMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	
	| outputGraphicElement |
		
	"Busco el elemento grafico conectado a la salida numero 1"
	outputGraphicElement := self blockConnectedToOutput: 1.
	
	"Cambio el estado de conexion de capa 2 al que traiga el elemento actual"
	outputGraphicElement connectionStateLayer2: self connectionStateLayer2.
	outputGraphicElement changed.
		
	"El estado de conexion de capa 1 es conectado a self"
	outputGraphicElement connectedToContact.
	
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	outputGraphicElement updateOutputsConnectonStates.
]

{ #category : #drawing }
PLC_NOContactMorph >> vBar [
	"Barra horizontal que representa el cable del contacto"

	| width height|
	
	width := self properties scale x * 2.
	height := self properties scale y * 14.
	
	^ Rectangle origin: (0@0) corner: ( width @ height ).
]
