"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_PinBlockMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_PinBlockMorph',
	#superclass : #'PLC_GraphicElementMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #extent }
PLC_PinBlockMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ ( self totalExtent x @ (self properties scale y * 14) ).
]

{ #category : #drawing }
PLC_PinBlockMorph >> drawElementOn: aCanvas [
	"Dibuja el palito horizontal del pin"

	aCanvas fillRectangle: self hBar color: self userInteractionStateLayer1 elementColor.

]

{ #category : #drawing }
PLC_PinBlockMorph >> hBar [
	"Barra horizontal que representa el cable de conexión del pin."

	| width height hBar |

	width := self properties scale x * self extent x.
	height := self properties scale y * 2.
	
	hBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ hBar align: hBar center with: self bounds center.
]

{ #category : #'initialize-release' }
PLC_PinBlockMorph >> initialize [
	"comment stating purpose of message"

	super initialize.
	
	self extentChanged;
		openInWorld.
	
]

{ #category : #extent }
PLC_PinBlockMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self totalExtent.
]

{ #category : #position }
PLC_PinBlockMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ 0 @ 0.
]

{ #category : #'connection states layer 2' }
PLC_PinBlockMorph >> pinFallingEdge [
	"Cambia su estado de conexion de capa 2"
	
	self connectionStateLayer2: PLC_GraphicElementState pinFallingEdge.
	self changed.

]

{ #category : #'connection states layer 1' }
PLC_PinBlockMorph >> pinFromBooleanFormalParameter [
	"Cambia su estado de conexion de capa 1 al estado conectado a a variable booleana. 
	Se pone negro"	
	
	self connectionStateLayer1: PLC_GraphicElementState pinFromBooleanFormalParameter.
	self changed.

]

{ #category : #'connection states layer 1' }
PLC_PinBlockMorph >> pinFromNotBooleanFormalParameter [
	"Cambia su estado de conexion de capa 1 al estado conectado a a variable no booleana. 
	Se pone dorado"
	
	self connectionStateLayer1: PLC_GraphicElementState pinFromNotBooleanFormalParameter.
	self changed.
]

{ #category : #'connection states layer 2' }
PLC_PinBlockMorph >> pinNegated [
	"Cambia su estado de conexion de capa 2"
	
	self connectionStateLayer2: PLC_GraphicElementState pinNegated.
	self changed.

]

{ #category : #'connection states layer 2' }
PLC_PinBlockMorph >> pinNormal [
	"Cambia su estado de conexion de capa 2"
	
	self connectionStateLayer2: PLC_GraphicElementState pinNormal.
	self changed.

]

{ #category : #'connection states layer 2' }
PLC_PinBlockMorph >> pinRisingEdge [
	"Cambia su estado de conexion de capa 2"
	
	self connectionStateLayer2: PLC_GraphicElementState pinRisingEdge.
	self changed.

]

{ #category : #extent }
PLC_PinBlockMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self properties scale * ( 6 @ self defaultExtent y ).
]
