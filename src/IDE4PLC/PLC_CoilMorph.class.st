"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CoilMorph is xxxxxxxxx.

Instance Variables
	isConnectedToRightPowerRail:		<Object>

isConnectedToRightPowerRail
	- xxxxx

"
Class {
	#name : #'PLC_CoilMorph',
	#superclass : #'PLC_ContactsAndCoils',
	#instVars : [
		'isConnectedToRightPowerRail'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_CoilMorph >> centralCircle [
	"Circulo centra para dibujar la bobina, se ve como ( ) debido a que se corta."

	| width height rectangle origin corner |
	
	width := (self properties scale x * 20) rounded.
	height := (self properties scale y * 20) rounded.
	
	rectangle := Rectangle origin: (0@0) corner: ( width @ height ).

	^ rectangle align: rectangle center with: self bounds center.
		
	"origin := self position + (self extent / 2.0) rounded - (width /2.0) rounded.
	corner := origin + (width @ height).

	^ Rectangle origin: origin corner: corner."
]

{ #category : #accessing }
PLC_CoilMorph >> connectedToRightPowerRail [
	
	self isConnectedToRightPowerRail: true.
]

{ #category : #layout }
PLC_CoilMorph >> connectedToRightPowerRailLayoutHorizontallyLeft: aDistanceX [
	"Como esta conectado a un RPR lo alineo a izquierda de este"
	
	"Alineo el elemento a aDistanceX como si fuese un contacto."
	"Alineando a derecha incicialemente me aseguro que la Bobina no pise ningun morph pues reserva el lugar."	
	self layoutLeft: aDistanceX.

	"Alineo el RightPowerRail a derecha de la bobina"
	(self blockConnectedToOutput: 1) layoutHorizontallyLeft: super layoutRectangle right.

	"Alineo la Bobina a izquierda del RightPowerRail"			
	self layoutLeft: (self blockConnectedToOutput: 1) layoutRectangle left - super layoutRectangle extent x.
	
"	Transcript show: ( (self blockConnectedToOutput: 1) layoutRectangle left - super layoutRectangle extent x ) asString , '
'."
]

{ #category : #drawing }
PLC_CoilMorph >> drawElementOn: aCanvas [
	"Dibuja el elemento"

	aCanvas fillRectangle: self leftHBar color: self userInteractionStateLayer1 elementColor;
		fillRectangle: self rightHBar color: self userInteractionStateLayer1 elementColor;
		fillOval: self centralCircle 
			color: self userInteractionStateLayer1 backgroundColor 
			borderWidth: self leftHBar extent y 
			borderColor: self userInteractionStateLayer1 elementColor.

	self drawPatchOn: aCanvas.
]

{ #category : #drawing }
PLC_CoilMorph >> hBar [
	"Barra horizontal que representa el cable de la bobina"

	| width height hBar|
	
	width := (self properties scale x * 28) rounded. "Redondeo explicitamente para que se dibuje bien."	 "28"
	height := (self properties scale y * 2) rounded.	"2"
	
	hBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ hBar align: hBar center with: self bounds center.
]

{ #category : #'initialize-release' }
PLC_CoilMorph >> initialize [
	"Inicializo el elemento grafico"

	super initialize.
	
	isConnectedToRightPowerRail := false.
]

{ #category : #'instance variable' }
PLC_CoilMorph >> instanceVariableFor: aConnectableBlock [
	"Devuelve el bloque conectable de la variable desde el bloque conectable del elemento"

	^ aConnectableBlock blockConnectedToOutput: 2
]

{ #category : #'model exploration' }
PLC_CoilMorph >> isCoil [
	"Devuelve true si el elemento grafico es una bobina."

	^ true
]

{ #category : #accessing }
PLC_CoilMorph >> isConnectedToRightPowerRail [
	
	^ isConnectedToRightPowerRail
]

{ #category : #accessing }
PLC_CoilMorph >> isConnectedToRightPowerRail: anObject [
	
	isConnectedToRightPowerRail := anObject
]

{ #category : #layout }
PLC_CoilMorph >> layoutHorizontallyLeft: aDistanceX [
	"self se posiciona  de alguna manera con respecto a aDistanceX. 
	self solo se mueve horizontalmente."

	self isConnectedToRightPowerRail
		ifTrue: [ 
			self connectedToRightPowerRailLayoutHorizontallyLeft: aDistanceX
			] 
		ifFalse: [ 
			self notConnectedToRightPowerRailLayoutHorizontallyLeft: aDistanceX
			].

]

{ #category : #position }
PLC_CoilMorph >> layoutRectangleRelativePosition [
	"Posicion relativa entre el layoutRectangle y el position del elemento
	MODIFICADO para que no genere errores con respecto al 
	layoutRectangle calculado al acomodar bobinas en pantalla.
	
	SI SACO ESTE METODO NO ACOMODA BIEN LAS BOBINAS"

	^ self topLeft - super layoutRectangle topLeft.
]

{ #category : #layout }
PLC_CoilMorph >> notConnectedToRightPowerRailLayoutHorizontallyLeft: aDistanceX [
	"Como NO esta conectado a un RPR solo alineo el elemento a aDistanceX como si fuese un contacto."
	
	self layoutLeft: aDistanceX.
]

{ #category : #'commands recive from ladder view' }
PLC_CoilMorph >> removeElementFrom: aLadderView [
	"Remueve el elemento pidiendoselo a su ladder view. Hace un double dispatching con este"
	
	aLadderView removeCoil: self.
]

{ #category : #'connection states' }
PLC_CoilMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	
	| outputGraphicElement |
		
	"Busco el elemento grafico conectado a la salida numero 1"
	outputGraphicElement := self blockConnectedToOutput: 1.
	
	"Cambio el estado de conexion de capa 2 al que traiga el elemento actual"
	outputGraphicElement connectedToLeftPowerRailTroughFirstOutputPin.
		
	"El estado de conexion de capa 1 es conectado a self"
	outputGraphicElement connectedToCoil.
	
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	outputGraphicElement updateOutputsConnectonStates.
]
