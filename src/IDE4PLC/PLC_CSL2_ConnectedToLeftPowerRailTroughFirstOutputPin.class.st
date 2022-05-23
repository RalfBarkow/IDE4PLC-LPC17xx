"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin >> drawElementOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que dibuje este estado de connection drawin layer."
	
	aPLC_GraphicElementMorph connectedToLeftPowerRailTroughFirstOutputPinDrawElementOn: aCanvas.
]

{ #category : #layout }
PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin >> layoutHorizontallyLeft: aDistanceX for: aGraphicElement [.
	"aGraphicElement se posiciona  de alguna manera con respecto a aDistanceX. 
	aGraphicElement solo se mueve horizontalmente."
	
	"Alineo el elemento a aDistanceX"
	aGraphicElement layoutLeft: aDistanceX.
	
	"Si esta posicion en X es menor que estar a la derecha de 5 anchos de grilla entonces la fuerzo a ese valor"
	( aGraphicElement layoutRectangle left < ( (aGraphicElement gridExtent x * 5) + aGraphicElement gridOrigin x ) )
		ifTrue: [ 
			aGraphicElement layoutLeft: ( (aGraphicElement gridExtent x * 5) + aGraphicElement gridOrigin x). 
			].
]

{ #category : #extent }
PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin >> layoutRectangleExtentFor: aPLC_RightRailMorph [
	"Tamaño del LayoutRectangle en este estado"
	
	^ aPLC_RightRailMorph layoutRectangleExtentConnectedToLeftPowerRailOutput1.
]

{ #category : #position }
PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin >> layoutRectanglePositionFor: aPLC_RightRailMorph [
	"Posicion del LayoutRectangle en este estado."
	
	^ aPLC_RightRailMorph layoutRectanglePositionConnectedToLeftPowerRailOutput1.
]
