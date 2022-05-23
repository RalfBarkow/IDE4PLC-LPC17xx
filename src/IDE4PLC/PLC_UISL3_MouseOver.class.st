"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL3_MouseOver is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL3_MouseOver',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL3_MouseOver >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"Dibujo el color celeste con transparencia para indicar que el mouse esta sobre el elemento."
	
	aCanvas 
		fillRectangle: aPLC_GraphicElementMorph backgroundRectangle 
		color: (Color r: 0.75 g: 0.75 b: 1.0 alpha: 0.4).
]
