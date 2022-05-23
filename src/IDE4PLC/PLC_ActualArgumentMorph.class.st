"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ActualArgumentMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ActualArgumentMorph',
	#superclass : #'PLC_EditableTagMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'change text' }
PLC_ActualArgumentMorph >> actualArgumentText: aString [

	self text: aString.
	self pluggableTextMorph changeText: aString asText.
	
	

]

{ #category : #'model exploration' }
PLC_ActualArgumentMorph >> addToGroup: aGroup [
	"El elemento Actual Argument se añade al grupo pasado como parámetro.
	Aquí se corta la cadena de añadir al grupo."
	
	aGroup add: self.
]

{ #category : #extent }
PLC_ActualArgumentMorph >> centerLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle
	cuado tiene alineación centrada."
	
	^ self extent.
]

{ #category : #position }
PLC_ActualArgumentMorph >> centerLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]
	cuado tiene alineación centrada."
	
	^ 0 @ 0.
]

{ #category : #'other events' }
PLC_ActualArgumentMorph >> changeFunction: anEvent [
	"Estado changeFunction."

	"Cambio el texto del pluggableTextMorph al del actualArgumentMorph"
	self pluggableTextMorph changeText: self text.
	
	"Posiciono el pluggableTextMorph"
	self pluggableTextMorph bottomLeft: self bottomLeft + self owner position + self owner owner position. "VERRRRRRRRRRR"

	"Hago que el pluggableTextMorph sea visible"
	self pluggableTextMorph visible: true.

	" Le doy el foco del teclado al pluggableTextMorph"	
	anEvent hand newKeyboardFocus: self pluggableTextMorph .
	"Selecciono todo el texto del pluggableTextMorph"
	self pluggableTextMorph  selectAll.
	
	"Pongo el pluggableTextMorph sobre todas las ventanas"	
	self currentWorld
		addMorphFront: self pluggableTextMorph.
]

{ #category : #layout }
PLC_ActualArgumentMorph >> layoutOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"El elemento se posiciona dentro del ladderView."

	"Alineo Horizontalmente a este elemento gráfico."
	self layoutHorizontallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	"Alineo Verticalmnete su grupo."
	self layoutGroupVerticallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
]

{ #category : #extent }
PLC_ActualArgumentMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle.
	Se lo pide a su estado de alineación"
	
	^ self textAlign layoutRectangleExtentFor: self.
]

{ #category : #position }
PLC_ActualArgumentMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px].
	Se lo pide a su estado de alineación"
	
	^ self textAlign layoutRectanglePositionFor: self.
]

{ #category : #extent }
PLC_ActualArgumentMorph >> leftLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle
	cuado tiene alineación izquierda."
	
	^ self extent + (self properties scale * ( 4 @ 0 ) ).
]

{ #category : #position }
PLC_ActualArgumentMorph >> leftLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]
	cuado tiene alineación izquierda."
	
	^ self properties scale * ( -4 @ 0 ).
]

{ #category : #'draw elements' }
PLC_ActualArgumentMorph >> outputPinsSize [
	"Devuelve la cantidad de pines de salida. Es un mensaje para que no 
	tire error al dibujar la vista ladder intentando dibujar las salidas de 
	un elemento que no tiene. FEOOO MEJORARR"

	^ 0.
]

{ #category : #pluggableTextMorph }
PLC_ActualArgumentMorph >> pluggableTextMorphExtent [
	"Devuelve el tamaño para setear al PluggableTextMorph"

	^ self extent x @ 50.
]

{ #category : #extent }
PLC_ActualArgumentMorph >> rightLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle
	cuado tiene alineación derecha."
	
	^ self extent + (self properties scale * ( 4 @ 0 ) ).
]

{ #category : #position }
PLC_ActualArgumentMorph >> rightLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]
	cuado tiene alineación derecha."
	
	^ 0 @ 0.
]

{ #category : #'change text' }
PLC_ActualArgumentMorph >> textChanged: aText [
	"Evento que se da al cambiar el texto del PluggableTextMorph de un ActualArgumentMorph."

	self pluggableTextMorph delete.
	
	"Owner es es un ladderView"
	self owner changeActualArgumentFor: self by: aText asString.
]

{ #category : #layout }
PLC_ActualArgumentMorph >> xPositionedCascade: aBoolean [
	"Pone el flag xPosition al valor aBoolean de todos los elementos conectados a sus salidas y sus elementos hacen lo mismo."
	
	"No hace nada. Es por polimorfismo.  Para que no se tilde con las variables de salida de los bloques."
]
