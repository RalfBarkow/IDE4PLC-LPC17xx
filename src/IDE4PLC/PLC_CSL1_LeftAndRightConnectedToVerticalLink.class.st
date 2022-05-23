"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CSL1_LeftAndRightConnectedToVerticalLink is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CSL1_LeftAndRightConnectedToVerticalLink',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #extent }
PLC_CSL1_LeftAndRightConnectedToVerticalLink >> layoutRectangleExtentFor: aPLC_GraphicElementMorph [
	"Tamaño del LayoutRectangle en este estado"
	
	^ aPLC_GraphicElementMorph leftAndRightConnectedToVerticalLinkLayoutRectangleExtent.
]

{ #category : #position }
PLC_CSL1_LeftAndRightConnectedToVerticalLink >> layoutRectanglePositionFor: aPLC_GraphicElementMorph [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px] en este estado."
	
	^ aPLC_GraphicElementMorph leftAndRightConnectedToVerticalLinkLayoutRectanglePosition.
]

{ #category : #layout }
PLC_CSL1_LeftAndRightConnectedToVerticalLink >> leftConnectedToVerticalLinkFor: aPLC_GraphicElementMorph [
	"No cambia nada pues ya está en el estado de conexion"
]

{ #category : #layout }
PLC_CSL1_LeftAndRightConnectedToVerticalLink >> rightConnectedToVerticalLinkFor: aPLC_GraphicElementMorph [
	"No cambia nada pues ya está en el estado de conexion"
]
