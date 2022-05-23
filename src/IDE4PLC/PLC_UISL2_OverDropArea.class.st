"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL2_OverDropArea is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL2_OverDropArea',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL2_OverDropArea >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que se dibuje, este estado de drawin layer 1conoce los colores."
	
	aPLC_GraphicElementMorph drawBackgroundOn: aCanvas;
		drawElementOn: aCanvas.
]

{ #category : #drawing }
PLC_UISL2_OverDropArea >> insertionPointBackgroundColor [
	"Color del área de drop del punto de inserción. Se aplica al fondo del punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance overDropAreaInsertionPointBackgroundColor.
]

{ #category : #drawing }
PLC_UISL2_OverDropArea >> insertionPointBorderColor [
	"Color de borde del cuadradito que representa el punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance overDropAreaInsertionPointBorderColor.
]

{ #category : #drawing }
PLC_UISL2_OverDropArea >> insertionPointColor [
	"Color del cuadradito que representa el punto de inserción."

	^ PLC_GraphicElementProperties uniqueInstance overDropAreaInsertionPointColor.
]
