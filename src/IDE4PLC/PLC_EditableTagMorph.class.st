"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_EditableTagMorph is xxxxxxxxx.

Instance Variables
	pluggableTextMorph:		<Object>

pluggableTextMorph
	- xxxxx

"
Class {
	#name : #'PLC_EditableTagMorph',
	#superclass : #'PLC_TagMorph',
	#instVars : [
		'pluggableTextMorph'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_EditableTagMorph class >> newWithText: aString [
	"Nuevo con texto asString"

	| alctualArgumentMorph |
	
	alctualArgumentMorph := self new.
	
	alctualArgumentMorph text: aString.
	
	alctualArgumentMorph extentChanged.
	
	alctualArgumentMorph buildPluggableTextMorph.
	
	^ alctualArgumentMorph.
]

{ #category : #pluggableTextMorph }
PLC_EditableTagMorph >> buildPluggableTextMorph [
	"Construye el PluggableTextMorph, que por defecto esta oculto."

	pluggableTextMorph := (PluggableTextMorph
		on: self
		text: #text
		accept: #textChanged:).
		
	pluggableTextMorph extent: self pluggableTextMorphExtent;
		borderWidth: 1;
		color: Color white;
		"hasUnacceptedEdits: true;"
		acceptOnCR: true;
		acceptOnFocusChange: true;
		"autoAccept: true;"
		setNameTo: #pluggableTextTag;
		openInWorld.
		
	"Lo hago invisible"		
	pluggableTextMorph visible: false.
]

{ #category : #'other events' }
PLC_EditableTagMorph >> changeFunction [
	"Estado changeFunction."

	| aWorld |

	"Cambio el texto del pluggableTextMorph al del actualArgumentMorph"
	self pluggableTextMorph changeText: self text.
	
	"Posiciono el pluggableTextMorph"
	self pluggableTextMorph position: self position. "VERRRRRRRRRRR"

	"Hago que el pluggableTextMorph sea visible"
	self pluggableTextMorph visible: true.
	
	"Pongo el pluggableTextMorph sobre todas las ventanas"	
	(aWorld := self currentWorld) addMorphFront: self pluggableTextMorph.
]

{ #category : #extent }
PLC_EditableTagMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent.
]

{ #category : #position }
PLC_EditableTagMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ 0 @ 0.
]

{ #category : #'other events' }
PLC_EditableTagMorph >> lostKeyboardFocus [
	"Evento que ejecuta el Morph cuando pierde el foco del teclado"

	"self textChanged: self pluggableTextMorph text."
]

{ #category : #accessing }
PLC_EditableTagMorph >> pluggableTextMorph [
	"Retorna el pluggableTextMorph que es el único submorph del ActualArgumentMorph"

	^ pluggableTextMorph " self submorphs first."
]

{ #category : #pluggableTextMorph }
PLC_EditableTagMorph >> pluggableTextMorphExtent [
	"Devuelve el tamaño para setear al PluggableTextMorph"

	^ self extent x @ 50.
]

{ #category : #'change text' }
PLC_EditableTagMorph >> textChanged: aText [
	"Evento que se da al cambiar el texto del PluggableTextMorph de un ActualArgumentMorph."

	self pluggableTextMorph delete.  "Si refibujo el Morph"
	"self pluggableTextMorph visible: false." "Si no refibujo el Morph"
	
	"Owner es es un ladderView"
	self owner textChangedIn: self by: aText asString.
]
