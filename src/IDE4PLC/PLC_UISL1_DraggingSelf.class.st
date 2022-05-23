"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL1_DraggingSelf is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL1_DraggingSelf',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL1_DraggingSelf >> backgroundColor [
	"Color de fondo del elemento"

	^ PLC_GraphicElementProperties uniqueInstance draggingSelfBackgroundColor.
]

{ #category : #drawing }
PLC_UISL1_DraggingSelf >> blockBodyColor [ 
	"Color de cuerpo del bloque"

	^ PLC_GraphicElementProperties uniqueInstance draggingSelfBlockBodyColor.
]

{ #category : #drawing }
PLC_UISL1_DraggingSelf >> blockFootAndHeaderColor [
	"Color de cabecera y pie del bloque"

	^ PLC_GraphicElementProperties uniqueInstance draggingSelfBlockFootAndHeaderColor.
]

{ #category : #drawing }
PLC_UISL1_DraggingSelf >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que se dibuje, este estado de drawin layer 1conoce los colores."
	
	aPLC_GraphicElementMorph drawBackgroundOn: aCanvas;
		drawElementOn: aCanvas.
]

{ #category : #drawing }
PLC_UISL1_DraggingSelf >> elementColor [
	"Color del elemento"

	^ PLC_GraphicElementProperties uniqueInstance draggingSelfElementColor.
]

{ #category : #states }
PLC_UISL1_DraggingSelf >> keyboardFocus [
	"Devuelve un estado keyboard focusr solo si le llega este mensaje a 
	un estado de drawingLayer1 y es selected o unselected."

	^ PLC_GraphicElementState voidState.
]

{ #category : #states }
PLC_UISL1_DraggingSelf >> mouseOver [
	"Devuelve un estado mouse over solo si le llega este mensaje a 
	un estado de drawingLayer1 y es unselected."

	^ PLC_GraphicElementState voidState.
]

{ #category : #states }
PLC_UISL1_DraggingSelf >> textColor [
	"Color de texto del elemento"

	^ self elementColor.
]
