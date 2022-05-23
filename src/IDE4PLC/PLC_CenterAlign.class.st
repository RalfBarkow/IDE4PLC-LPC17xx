"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CenterAlign is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CenterAlign',
	#superclass : #'PLC_Aligns',
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #style }
PLC_CenterAlign >> inOutLineFor: aPLC_GraphicElementMorph [
	"Morph que representa la linea que continua el pin del tag in out."
	
	^ aPLC_GraphicElementMorph leftInOutLine.
]

{ #category : #extent }
PLC_CenterAlign >> layoutRectangleExtentFor: aPLC_GraphicElementMorph [
	"Devuelve el tamaño en pixeles del layoutRectangle
	cuado tiene alineación centrada."
	
	^ aPLC_GraphicElementMorph centerLayoutRectangleExtent.

]

{ #category : #position }
PLC_CenterAlign >> layoutRectanglePositionFor: aPLC_GraphicElementMorph [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]
	cuado tiene alineación centrada."
	
	^ aPLC_GraphicElementMorph centerLayoutRectanglePosition.

]

{ #category : #position }
PLC_CenterAlign >> txtPositionXFor: aString in: aMorph [.
	"Devuelve la posicion horizontal (en x) de donde tiene que estar 
	el string segun el tipo de alineacion"
	
	^ ((aMorph extent x - aString asMorph extent x) / 2.0) rounded + aMorph position x.

]

{ #category : #style }
PLC_CenterAlign >> underlineStyleWithColor: aColor andOrigin: anOrigin andDirection: aDirection [
	"Estilo del Morph subrrayado de la etiqueta. Tiene un color degradado."
	
	^ PLC_GraphicElementProperties uniqueInstance 
		centerUnderlineStyleWithColor: aColor 
		andOrigin: anOrigin 
		andDirection: aDirection.
]
