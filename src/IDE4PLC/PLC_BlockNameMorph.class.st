"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_BlockNameMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_BlockNameMorph',
	#superclass : #'PLC_TagMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_BlockNameMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	"aCanvas 
		fillRectangle: self backgroundRectangle 
		color: self drawingLayer1 blockFootAndHeaderColor."
]

{ #category : #extent }
PLC_BlockNameMorph >> elementDoubleWidth [
	"Doble ancho del elemento"

	^ self properties scale x * 180.
]

{ #category : #extent }
PLC_BlockNameMorph >> elementWidth [
	"Ancho estandar del elemento"

	^ self properties scale x * 84.
]

{ #category : #'event handling' }
PLC_BlockNameMorph >> handlesMouseOver: anEvent [
	"Permite manejar el evento de que el puntero pasa sobre el morph."

	^false.
]

{ #category : #'initialize-release' }
PLC_BlockNameMorph >> initialize [
	"comment stating purpose of message"

	super initialize.

	text := 'BLOCK'.
]

{ #category : #extent }
PLC_BlockNameMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent.
]

{ #category : #position }
PLC_BlockNameMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ ( 0 @ 0 ).
]

{ #category : #margin }
PLC_BlockNameMorph >> leftMargin [
	"Retorna el margen izquierdo del texto con respecto al elemento."
	
	^ self properties scale x * 4.
]

{ #category : #margin }
PLC_BlockNameMorph >> rightMargin [
	"Retorna el margen derecho del texto con respecto al elemento."
	
	^ self properties scale x * 4.
]
