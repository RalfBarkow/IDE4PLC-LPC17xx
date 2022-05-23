"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicElementWithPinsMorph is xxxxxxxxx.

Instance Variables
	inputPins:		<Object>
	outputPins:		<Object>

inputPins
	- xxxxx

outputPins
	- xxxxx

"
Class {
	#name : #'PLC_GraphicElementWithPinsMorph',
	#superclass : #'PLC_GraphicElementMorph',
	#instVars : [
		'inputPins',
		'outputPins'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> addInputPin [
	"Añade un pin de entrada al elemento."

	| pinMorph pos |

	pinMorph := PLC_PinMorph new.
	
	( self inputPins size = 0 )
		ifTrue: [
			pinMorph topLeft: self topLeft + ( 0 @ self firstPinYDistance ).
			] 
		ifFalse: [
			pos := self inputPins last position.
			pinMorph position: ( pos x @ ( pos y + self distanceBetweenPins ) ).
			].
	
	self addMorph: pinMorph.
	self inputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> addOutputPin [
	"Añade un pin de salida al elemento."

	| pinMorph pos |

	pinMorph := PLC_PinMorph new.
	
	( self outputPins size = 0 )
		ifTrue: [
			pinMorph topRight: self topRight + ( 0 @ self firstPinYDistance ).
			] 
		ifFalse: [
			pos := self outputPins last position.
			pinMorph position: ( pos x @ ( pos y + self distanceBetweenPins ) ).
			].
	
	self addMorph: pinMorph.
	self outputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> distanceBetweenPins [
	"Devuelve la distancia en pantalla en Y ente pines del elemento."
	
	^ self minYDistanceBetweenPins.
]

{ #category : #'draw elements' }
PLC_GraphicElementWithPinsMorph >> drawHorizontalLinksFrom: aLadderView [
	"Dibuja todos los Horizontal Links a las salidas del elemento. 
	Los agrega al diccionario elements de aLadderView. 
	Por último le dice a los elementos graficos conectados 
	a sus salidas que dibujen sus horizontal links."

	| connectableBlock horizontalLink connection outputGraphicElement |
	
	connectableBlock := aLadderView modelElementForGraphicElement: self.

	"Si no tiene salidas no hace nada!!"
	( 1 to: self outputPins size ) do: [ :ind |
		
		"Creo el Horizontal Link corespondiente a la salida numero ind."
		horizontalLink := PLC_HorizontalLinkMorph new.
		
		"Lo agrego de submorph"
		aLadderView addMorphBack: horizontalLink.
		
		"Busco la conexion a la salida numero ind de connectableBlock"
		connection := connectableBlock connectedAtOutput: ind.
	
		"Lo agrego al diccionario elementos"
		aLadderView elements at: horizontalLink put: connection.
			
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		aLadderView selectedAndKeyboardFocus: horizontalLink.
		
		"Posiciono el Horizontal Link"
		horizontalLink centeredToTheRight: ( self outputPins at: ind ).
		
		"Actualizo su tamaño"
		horizontalLink extentChanged.
		
		
		"Busco el bloque conectable conectado a la salida numero ind"
		outputGraphicElement := self blockConnectedToOutput: ind.
		
		"Dibujo los horizontal links de los elementos conectados a sus salidas"
		outputGraphicElement drawHorizontalLinksFrom: aLadderView.
		
		].
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> getFirstInputPinPosition [
	"Devuelve la posición en pantalla del primer pin de entrada."
	
	"^ self position."
	^ self getPositionForInputPin: 1."Modificado el 30-6-2013"
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> getFirstOutputPinPosition [
	"Devuelve la posición en pantalla del primer pin de salida."
	
	"^ self topRight - ((self outputPins first extent x) @ 0). "
	^ self getPositionForOutputPin: 1. "Modificado el 30-6-2013"
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> getPositionForInputPin: aPinNumber [
	"Obtiene la posición del pin de entrada número aPinNumber."

	^ (self inputPins at: aPinNumber) position.
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> getPositionForOutputPin: aPinNumber [
	"Obtiene la posición del pin de salida número aPinNumber."

	^ (self outputPins at: aPinNumber) position.
]

{ #category : #'initialize-release' }
PLC_GraphicElementWithPinsMorph >> initialize [
	"Inicializaciones"

	super initialize.

	self inputPins: OrderedCollection new.
	self outputPins: OrderedCollection new.
]

{ #category : #accessing }
PLC_GraphicElementWithPinsMorph >> inputPins [
	^ inputPins
]

{ #category : #accessing }
PLC_GraphicElementWithPinsMorph >> inputPins: anObject [
	inputPins := anObject
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> minYDistanceBetweenPins [
	"Devuelve la distancia minima en pantalla en Y ente pines."
	
	^ self properties scale y * self gridExtent y.
]

{ #category : #accessing }
PLC_GraphicElementWithPinsMorph >> outputPins [
	^ outputPins
]

{ #category : #accessing }
PLC_GraphicElementWithPinsMorph >> outputPins: anObject [
	outputPins := anObject
]

{ #category : #'draw elements' }
PLC_GraphicElementWithPinsMorph >> outputPinsSize [
	"Devuelve la cantidad de pines de salida"

	^ self outputPins size.
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> setPositionForInputPin: aPinNumber to: aPosition [
	"Establece la posición del pin de entrada número aPinNumber en el valor  aPosition."
	
	(self inputPins at: aPinNumber) position: aPosition.
]

{ #category : #pins }
PLC_GraphicElementWithPinsMorph >> setPositionForOutputPin: aPinNumber to: aPosition [
	"Establece la posición del pin de salida número aPinNumber en el valor  aPosition."
	
	(self outputPins at: aPinNumber) position: aPosition.
]

{ #category : #layout }
PLC_GraphicElementWithPinsMorph >> xPositionedCascade: aBoolean [
	"Pone el flag xPosition al valor aBoolean de todos los elementos conectados a sus salidas y sus elementos hacen lo mismo."
	
	| outputGraphicElement |
	
	( 1 to: self outputPins size ) do: [ :ind |
		
		outputGraphicElement := self blockConnectedToOutput: ind.
		
		outputGraphicElement xPositioned: aBoolean.
		
		outputGraphicElement xPositionedCascade: aBoolean.
		
		].
]
