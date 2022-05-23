"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_FormalParameterMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_FormalParameterMorph',
	#superclass : #'PLC_TagMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_FormalParameterMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	aCanvas 
		"fillRectangle: self backgroundRectangle 
		color: self userInteractionLayer1 blockBodyColor;"
		
		fillRectangle: self underline
		fillStyle: ( self textAlign 
			underlineStyleWithColor: self userInteractionStateLayer1 blockBodyColor
			andOrigin: self position
			andDirection: self extent x @ 0 ). 
]

{ #category : #extent }
PLC_FormalParameterMorph >> elementDoubleWidth [
	"Doble ancho del elemento"

	^ self properties scale x * 90.
]

{ #category : #extent }
PLC_FormalParameterMorph >> elementWidth [
	"Ancho estandar del elemento"

	^ self properties scale x * 42.
]

{ #category : #'event handling' }
PLC_FormalParameterMorph >> handlesMouseOver: anEvent [
	"Permite manejar el evento de que el puntero pasa sobre el morph."

	^false.
]

{ #category : #accessing }
PLC_FormalParameterMorph >> inOutFPAssociated [
	
	^ nil
]

{ #category : #'initialize-release' }
PLC_FormalParameterMorph >> initialize [
	"comment stating purpose of message"
	
	super initialize.
	
	text := 'VAR'.


]

{ #category : #extent }
PLC_FormalParameterMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent.
]

{ #category : #position }
PLC_FormalParameterMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ ( 0 @ 0 ).
]

{ #category : #margin }
PLC_FormalParameterMorph >> leftMargin [
	"Retorna el margen izquierdo del texto con respecto al elemento."
	
	^ self properties scale x * 4.
]

{ #category : #margin }
PLC_FormalParameterMorph >> rightMargin [
	"Retorna el margen derecho del texto con respecto al elemento."
	
	^ self properties scale x * 4.
]

{ #category : #text }
PLC_FormalParameterMorph >> text: anObject [
	text := anObject.

	( text asMorph extent x > self textWidth )
		ifTrue: [ 
			self doubleWidth.
			self owner ifNotNil: [ self owner formalParameterWithDoubleWidth. ].
			].
		
	self extentChanged.
]

{ #category : #drawing }
PLC_FormalParameterMorph >> underline [ 
	"Morph que representa el subrrayado de la etiqueta."

	| underline |
	
	underline := Rectangle 
		origin: (0@0)
		corner: ( self extent x - (self properties scale x * 2) ) @ (self properties scale y).
		
	^ underline align: underline bottomCenter with: self bounds bottomCenter.
]
