"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_UISL2_KeyboardFocus is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_UISL2_KeyboardFocus',
	#superclass : #'PLC_GraphicElementState',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #drawing }
PLC_UISL2_KeyboardFocus >> drawOn: aCanvas for: aPLC_GraphicElementMorph [
	"El borde de linea punteada al rededor del elemento que tiene el foco del teclado."
	
	"NOTA: Como siempre tiene como elemento al ultimo que le dieron el foco del teclado
	en su variable interna graphicElementMorph entonces cada vez que creo un elemento
	nuevo solo se va a poder dibujar la linea punteada en este ultimo ya que cambia como
	el estado es único le cambia su variable graphicElementMorph. Graficamente solo 1 
	elemento va a tener el foco del teclado. Aunque en internamente lo pueda tener. Esto
	de que exista un único objeto con el foco del teclado lo maneja la Network."
	
	aCanvas
		frameRectangle: aPLC_GraphicElementMorph backgroundRectangle
		width: PLC_GraphicElementProperties uniqueInstance dashBorderSize
		colors:PLC_GraphicElementProperties uniqueInstance dashColors
		dashes: PLC_GraphicElementProperties uniqueInstance dashLengths.
]
