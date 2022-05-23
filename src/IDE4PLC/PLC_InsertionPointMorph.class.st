"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_InsertionPointMorph is xxxxxxxxx.

Instance Variables
	drawingLayer:		<Object>
	properties:		<Object>

drawingLayer
	- xxxxx

properties
	- xxxxx

"
Class {
	#name : #'PLC_InsertionPointMorph',
	#superclass : #Morph,
	#instVars : [
		'drawingLayer',
		'properties'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_InsertionPointMorph >> defaultExtent [
	"Tamaño del area de drop del insertion point."

	(self owner isKindOf: PLC_GraphicElementMorph )
		ifTrue: [
			^ self owner insertionPointDropAreaExtent.
			] 
		ifFalse: [
			^ 96 @ 24.
			].
		 
]

{ #category : #states }
PLC_InsertionPointMorph >> draggingAnother [
	"Implementado solo por compatibilidad para polimorfismo."

]

{ #category : #states }
PLC_InsertionPointMorph >> draggingSelf [ 
	"Implementado solo por compatibilidad para polimorfismo."

]

{ #category : #drawing }
PLC_InsertionPointMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	aCanvas fillRectangle: self bounds color: self drawingLayer insertionPointBackgroundColor.
		

]

{ #category : #drawing }
PLC_InsertionPointMorph >> drawElementOn: aCanvas [
	"Dibuja el elemento"
	
	aCanvas 
		frameAndFillRectangle: self insertionPointRectangle
		fillColor: self drawingLayer insertionPointColor
		borderWidth: self properties scale x 
		borderColor: self drawingLayer insertionPointBorderColor.
]

{ #category : #drawing }
PLC_InsertionPointMorph >> drawOn: aCanvas [
	"Dibujo el elemento grafico"
	
	self drawingLayer drawOn: aCanvas for: self.
]

{ #category : #accessing }
PLC_InsertionPointMorph >> drawingLayer [
	^ drawingLayer
]

{ #category : #accessing }
PLC_InsertionPointMorph >> drawingLayer: anObject [
	drawingLayer := anObject
]

{ #category : #drawing }
PLC_InsertionPointMorph >> dropAreaDefaultHeight [
	"Altura por defecto. Todos los Insertion Point tienen esta altura de su fondo o area de drop"

	^ 24.
]

{ #category : #'initialize-release' }
PLC_InsertionPointMorph >> initialize [
	"Inicializo el elemento grafico"

	super initialize.
	
	self properties: PLC_GraphicElementProperties uniqueInstance.	
	
	PLC_GraphicElementState initialize.
	self notDragging.			"drawingLayer"

	self openInWorld. 

	self extent: self defaultExtent.

	

]

{ #category : #drawing }
PLC_InsertionPointMorph >> insertionPointCenter [
	"Devuelve el punto del centro del rectangulo del punto de inserción 
	que no coincide siempre con el centro del area de drop."

	^ self owner insertionPointCenter.
]

{ #category : #drawing }
PLC_InsertionPointMorph >> insertionPointRectangle [
	"Rectangulito que representa el punto de inserción"	

	| width height origin corner|

	width := self properties scale x * 6.
	height := self properties scale y * 8.
	
	origin := self center - ((width /2.0) rounded @ (height /2.0) rounded).
	corner := origin + (width @ height).

	^ Rectangle origin: origin corner: corner.
]

{ #category : #states }
PLC_InsertionPointMorph >> mouseOut [
	"Implementado solo por compatibilidad para polimorfismo."

]

{ #category : #states }
PLC_InsertionPointMorph >> mouseOver [
	"Implementado solo por compatibilidad para polimorfismo."

]

{ #category : #states }
PLC_InsertionPointMorph >> notDragging [
	"Estado Not Dragiing."	

	self visible: false.
	self drawingLayer: PLC_GraphicElementState voidState.
	self changed.
]

{ #category : #states }
PLC_InsertionPointMorph >> overDropArea [
	"Estado Over Drop Area."	

	self visible: true.
	self drawingLayer: PLC_GraphicElementState overDropArea.
	self changed.
]

{ #category : #accessing }
PLC_InsertionPointMorph >> properties [
	^ properties
]

{ #category : #accessing }
PLC_InsertionPointMorph >> properties: anObject [
	properties := anObject
]

{ #category : #states }
PLC_InsertionPointMorph >> selected [
	"Implementado solo por compatibilidad para polimorfismo."

]

{ #category : #states }
PLC_InsertionPointMorph >> underDragArea [
	"Estado Under Drag Area."	

	self visible: true.
	self drawingLayer: PLC_GraphicElementState underDragArea.
	self changed.
]

{ #category : #states }
PLC_InsertionPointMorph >> unselected [
	"Implementado solo por compatibilidad para polimorfismo."

]
