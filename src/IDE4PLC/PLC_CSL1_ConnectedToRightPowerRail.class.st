"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CSL1_ConnectedToRightPowerRail is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CSL1_ConnectedToRightPowerRail',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #layout }
PLC_CSL1_ConnectedToRightPowerRail >> layoutHorizontallyLeft: aDistanceX for: aPLC_GraphicElementMorph [.
	"Como esta conectado a un RPR lo alineo a izquierda de este"

	aPLC_GraphicElementMorph connectedToRightPowerRailLayoutHorizontallyLeft: aDistanceX.
]

{ #category : #extent }
PLC_CSL1_ConnectedToRightPowerRail >> layoutRectangleExtentFor: aPLC_GraphicElementMorph [
	"Tamaño del LayoutRectangle en este estado"
	
	^ aPLC_GraphicElementMorph layoutRectangleExtentNotConnectedToLeftPowerRailOutput1.
]

{ #category : #layout }
PLC_CSL1_ConnectedToRightPowerRail >> layoutRectangleFor: aGraphicElement [
	"Devuelve el layout Rectangle del elemento en este estado. Se usa para cambiar el 
	layoutRecgatngle de la bobina segun a que esta conectada, si a RPR u otra cosa"
	
	^ aGraphicElement connectedToRightPowerRailLayoutRectangle.
]

{ #category : #position }
PLC_CSL1_ConnectedToRightPowerRail >> layoutRectanglePositionFor: aPLC_GraphicElementMorph [
	"Posicion del LayoutRectangle en este estado."
	
	^ aPLC_GraphicElementMorph layoutRectanglePositionConnectedToContactOrCoil.
]
