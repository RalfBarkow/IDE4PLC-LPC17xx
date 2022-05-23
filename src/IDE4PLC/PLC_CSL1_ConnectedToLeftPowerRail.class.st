"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CSL1_ConnectedToLeftPowerRail is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CSL1_ConnectedToLeftPowerRail',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_CSL1_ConnectedToLeftPowerRail >> drawElementOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al estado de conexion 2 que le pida al elemento gráfico que dibuje este estado de connection drawin layer.
	Esto es para que cambie segun si esta en el primer pin o a partir del segundo. Ya que el segundo estado conoce por
	cual numero de pin esta conectado"
	
	aPLC_GraphicElementMorph connectionStateLayer2 drawElementOn: aCanvas for: aPLC_GraphicElementMorph.
]

{ #category : #extent }
PLC_CSL1_ConnectedToLeftPowerRail >> layoutRectangleExtentFor: aPLC_GraphicElementMorph [
	"Tamaño del LayoutRectangle en este estado"
	
	^ aPLC_GraphicElementMorph connectionStateLayer2 layoutRectangleExtentFor: aPLC_GraphicElementMorph.
]

{ #category : #position }
PLC_CSL1_ConnectedToLeftPowerRail >> layoutRectanglePositionFor: aPLC_GraphicElementMorph [
	"Posicion del LayoutRectangle en este estado."

	^ aPLC_GraphicElementMorph connectionStateLayer2 layoutRectanglePositionFor: aPLC_GraphicElementMorph.
]
