"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LeftPowerRailMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LeftPowerRailMorph',
	#superclass : #'PLC_GraphicElementWithPinsMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_LeftPowerRailMorph class >> newFromElement: anElement [
	"Nueva isntancia a partir de un elemento de un bloque conectable"

	| element num |
	
	element := self new.
	
	num := anElement connectableBlockOutputs.
	num timesRepeat: [ element addOutputPin. ].
	
	^ element.
]

{ #category : #drawing }
PLC_LeftPowerRailMorph >> addInsertionPoint [
	"Añade un Punto de Insercion."

	| insertionPoint penultimatePosition lastPosition  penultimate insertionPointCenter |

	lastPosition := self outputPins last position + (0 @ 1).
	
	self outputPins size - 1 >= 1 
		ifTrue: [
			penultimate := self outputPins at: self outputPins size - 1.
			penultimatePosition := penultimate position + (0 @ penultimate extent y).
			]
		ifFalse: [
			penultimatePosition := self position + (0 @ self extent y).
			].
	
	insertionPointCenter := (penultimatePosition - lastPosition) / 2.
			
	insertionPoint := PLC_InsertionPointMorph new.
	insertionPoint center: self center + insertionPointCenter.
	self addMorph: insertionPoint.
]

{ #category : #extent }
PLC_LeftPowerRailMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self totalExtent.
]

{ #category : #position }
PLC_LeftPowerRailMorph >> backgroundRectanglePosition [
	"Devuelve la posición en pantalla del backgroundRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( 0 @ 0 ).
]

{ #category : #extent }
PLC_LeftPowerRailMorph >> defaultExtent [
	"Tamaño por defecto del elemento."
	
	^ self properties scale * ( 8 @ ( self gridExtent y * 3 ) ).

]

{ #category : #drawing }
PLC_LeftPowerRailMorph >> drawElementOn: aCanvas [
	"Dibujo el rectangulo negro que representa al horizonta link."

	aCanvas fillRectangle: self vBar color: self userInteractionStateLayer1 elementColor.
]

{ #category : #'model exploration' }
PLC_LeftPowerRailMorph >> exploreModel [
	"Explora todas sus salidas."

	| newGroup |	
	
	"Por cada salida debo crear un Nuevo Grupo."	
	( 1 to: self outputPins size ) 
		do: [ :ind |
		
			"Creo un nuevo grupo misma altura de primer pin."
			newGroup := PLC_GraphicElementGroup new.
	
			"Lo añado a la colección groups del PLC_LadderView. Es una 
			colección de gupos de primer pin."
			self owner groups add: newGroup.
	
			"Agrego todos los elementos serie de la rama conectada a la 
			salida numero ind del LPR."
			( self blockConnectedToOutput: ind ) addToGroup: newGroup.
			
			].

]

{ #category : #pins }
PLC_LeftPowerRailMorph >> firstPinYDistance [
	"Devuelve la distancia en pantalla en Y del primer pin de entrada 
	y salida relativa a la posicion vertical de self .
	Es la distancia vertical entre la parte de arriba del elemento y el primer pin."
	
	^ self gridExtent y.
]

{ #category : #'model exploration' }
PLC_LeftPowerRailMorph >> isLeftPowerRail [
	"Devuelve true si el elemento grafico es una Barra derecha."

	^ true.
]

{ #category : #layout }
PLC_LeftPowerRailMorph >> layoutHorizontallyLeft: aDistanceX [
	"self se posiciona  de alguna manera con respecto a aDistanceX. 
	self solo se mueve horizontalmente."
	
	"Alineo el elemento al origen de la grilla."
	self position: self gridOrigin - ( self layoutRectangle extent x @ 0).
]

{ #category : #layout }
PLC_LeftPowerRailMorph >> layoutOn: aLadderView [
	"El elemento se posiciona dentro del ladderView."
	"En este caso poriciona su layout area en el origen de la grilla. Luego posiciona todas sus salidas."
	
	| outputGraphicElement |
	
	"Posiciono el elemento con su layoutRectangle topRight en el origen de la grilla."
	self position: self gridOrigin - ( self layoutRectangle extent x @ 0).
	
	"Seteo los flags que indican que el elemento ya fue posicionado."
	self xPositioned: true.
	self yPositioned: true.
	
	"Posiciono todos los elementos conectados a las salidas"
	( 1 to: self outputPins size ) do: [ :ind |
		
		"Busco el elemento grafico conectado a la salida numero ind"
		outputGraphicElement := self blockConnectedToOutput: ind.
		
		"Posiciono el elemento grafico hallado"
		outputGraphicElement layoutOn: aLadderView from: self output: ind.
		
		"Acomodo su pin de salida segun el elemento que acabo de posicionar."
		self setPositionForOutputPin: ind to: ( self getFirstOutputPinPosition x @ outputGraphicElement getFirstInputPinPosition y ).
		].
	
	"Estiro el LPR al mayor tamaño según todos los elementos en el ladderView"
	self extent: ( self extent x @ ( aLadderView bottomOfGraphicElementBelowOfAll - self gridOrigin y ) ).
]

{ #category : #extent }
PLC_LeftPowerRailMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	"En caso del LPR el tamaño vertical del layoutRectangle debe ser del tamaño vertical 
	de la grilla  para que no moleste cuando esté dentro un grupo de primer pin y le pida 
	el layoutArea a dicho grupo. Molesta ya que me agranda el layoutRtangle del grupo 
	verticalmente dificultando el posicionamiento."
	
	^ ( self properties scale x * 4 ) @ self gridExtent y.
]

{ #category : #position }
PLC_LeftPowerRailMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( 0 @ 0 ).
]

{ #category : #position }
PLC_LeftPowerRailMorph >> top: yPosition [
	"Establece la posición vertical en pantalla del primer pin de entrada y salida a yPosition.
	Antes: setFirstPinsVerticalPositionTo: yPosition"
	
	"En el caso particular de la Barra Izquierda solo muevo el pin"
	self setPositionForOutputPin: 1 to: ( self outputPins first position x @ yPosition).
]

{ #category : #extent }
PLC_LeftPowerRailMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self extent.
]

{ #category : #'connection states' }
PLC_LeftPowerRailMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	
	| outputGraphicElement |
		
	"La primer salida va con el estado de conexion de capa 2 connectedToLeftPowerRailTroughFirstOutputPin"
	
		"Busco el elemento grafico conectado a la salida numero 1"
		outputGraphicElement := self blockConnectedToOutput: 1.
		
		"Cambio el estado de conexion de capa 2 a connectedToLeftPowerRailTroughFirstOutputPin"
		outputGraphicElement connectedToLeftPowerRailTroughFirstOutputPin.
		
		"El estado de conexion de capa 1 es conectado a self en ambos casos"
		outputGraphicElement connectedToLeftPowerRail.
		
		"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
		outputGraphicElement updateOutputsConnectonStates.		
			
	"A partir de la segunda salida va con el estado de capa 2 notConnectedToLeftPowerRailTroughFirstOutputPinOrCoil"
	( 2 to: self outputPins size ) do: [ :ind |
		
		"Busco el elemento grafico conectado a la salida numero ind"
		outputGraphicElement := self blockConnectedToOutput: ind.
		
		"Cambio el estado de conexion de capa 2 a notConnectedToLeftPowerRailTroughFirstOutputPin"
		outputGraphicElement notConnectedToLeftPowerRailTroughFirstOutputPin.
		
		"El estado de conexion de capa 1 es conectado a self en ambos casos"
		outputGraphicElement connectedToLeftPowerRail.
		
		"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
		outputGraphicElement updateOutputsConnectonStates.
		].
	
]

{ #category : #drawing }
PLC_LeftPowerRailMorph >> vBar [
	"Barra vertical que representa el right rail."

	| width height vBar |

	width := self properties scale y * 2.
	height := self properties scale y * self bounds height.
	
	vBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ vBar align: vBar center with: self bounds center.
]
