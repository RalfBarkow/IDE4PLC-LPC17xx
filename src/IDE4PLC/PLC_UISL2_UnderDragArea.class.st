"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL2_UnderDragArea is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL2_UnderDragArea',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL2_UnderDragArea >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que se dibuje, este estado de drawin layer 1conoce los colores."
	
	aPLC_GraphicElementMorph drawBackgroundOn: aCanvas;
		drawElementOn: aCanvas.
]

{ #category : #drawing }
PLC_UISL2_UnderDragArea >> insertionPointBackgroundColor [
	"Color del área de drop del punto de inserción. Se aplica al fondo del punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance underDragAreaInsertionPointBackgroundColor.
]

{ #category : #drawing }
PLC_UISL2_UnderDragArea >> insertionPointBorderColor [
	"Color de borde del cuadradito que representa el punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance underDragAreaInsertionPointBorderColor.
]

{ #category : #drawing }
PLC_UISL2_UnderDragArea >> insertionPointColor [
	"Color del cuadradito que representa el punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance underDragAreaInsertionPointColor.
]
