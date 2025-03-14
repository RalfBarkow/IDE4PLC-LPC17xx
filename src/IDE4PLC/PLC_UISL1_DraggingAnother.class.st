"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL1_DraggingAnother is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL1_DraggingAnother',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL1_DraggingAnother >> backgroundColor [
	"Color de fondo del elemento"

	^ PLC_GraphicElementProperties uniqueInstance draggingAnotherBackgroundColor.
]

{ #category : #drawing }
PLC_UISL1_DraggingAnother >> blockBodyColor [ 
	"Color de cuerpo del bloque"

	^ PLC_GraphicElementProperties uniqueInstance draggingAnotherBlockBodyColor.
]

{ #category : #drawing }
PLC_UISL1_DraggingAnother >> blockFootAndHeaderColor [
	"Color de cabecera y pie del bloque"

	^ PLC_GraphicElementProperties uniqueInstance draggingAnotherBlockFootAndHeaderColor.
]

{ #category : #states }
PLC_UISL1_DraggingAnother >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que se dibuje, este estado de drawin layer 1conoce los colores."
	
	aPLC_GraphicElementMorph drawBackgroundOn: aCanvas;
		drawElementOn: aCanvas.
]

{ #category : #states }
PLC_UISL1_DraggingAnother >> elementColor [
	"Color del elemento"

	^ PLC_GraphicElementProperties uniqueInstance draggingAnotherElementColor.
]

{ #category : #states }
PLC_UISL1_DraggingAnother >> keyboardFocus [
	"Devuelve un estado keyboard focusr solo si le llega este mensaje a 
	un estado de drawingLayer1 y es selected o unselected."

	^ PLC_GraphicElementState voidState.
]

{ #category : #states }
PLC_UISL1_DraggingAnother >> mouseOver [
	"Devuelve un estado mouse over solo si le llega este mensaje a 
	un estado de drawingLayer1 y es unselected."

	^ PLC_GraphicElementState voidState.
]

{ #category : #drawing }
PLC_UISL1_DraggingAnother >> textColor [
	"Color de texto del elemento"

	^ self elementColor.
]
