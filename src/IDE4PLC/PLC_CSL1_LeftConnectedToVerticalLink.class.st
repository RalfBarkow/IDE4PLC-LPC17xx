"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CSL1_LeftConnectedToVerticalLink is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CSL1_LeftConnectedToVerticalLink',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_CSL1_LeftConnectedToVerticalLink >> drawElementOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que dibuje este estado de connection drawin layer."
	
	aPLC_GraphicElementMorph drawDoubleArrowOn: aCanvas.
]

{ #category : #layout }
PLC_CSL1_LeftConnectedToVerticalLink >> layoutHorizontallyLeft: aDistanceX for: aPLC_GraphicElementMorph [.
	"Como NO esta conectado a un RPR solo alineo el elemento a aDistanceX como si fuese un contacto."
	
	aPLC_GraphicElementMorph layoutLeft: aDistanceX.
]

{ #category : #extent }
PLC_CSL1_LeftConnectedToVerticalLink >> layoutRectangleExtentFor: aPLC_GraphicElementMorph [
	"Tamaño del LayoutRectangle en este estado"
	
	^ aPLC_GraphicElementMorph leftConnectedToVerticalLinkLayoutRectangleExtent.
]

{ #category : #layout }
PLC_CSL1_LeftConnectedToVerticalLink >> layoutRectangleFor: aPLC_GraphicElementMorph [
	"Devuelve el layout Rectangle del elemento en este estado. Se usa para cambiar el 
	layoutRecgatngle de la bobina segun a que esta conectada, si a RPR u otra cosa"
	
	^ aPLC_GraphicElementMorph defaultLayoutRectangle.
]

{ #category : #position }
PLC_CSL1_LeftConnectedToVerticalLink >> layoutRectanglePositionFor: aPLC_GraphicElementMorph [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px] en este estado."
	
	^ aPLC_GraphicElementMorph leftConnectedToVerticalLinkLayoutRectanglePosition.
]

{ #category : #layout }
PLC_CSL1_LeftConnectedToVerticalLink >> leftConnectedToVerticalLinkFor: aPLC_GraphicElementMorph [
	"No cambia nada pues ya está en el estado de conexion"
	

]

{ #category : #layout }
PLC_CSL1_LeftConnectedToVerticalLink >> rightConnectedToVerticalLinkFor: aPLC_GraphicElementMorph [
	"Cambia el estado de conexion"

	aPLC_GraphicElementMorph leftAndRightConnectedToVerticalLink.
]
