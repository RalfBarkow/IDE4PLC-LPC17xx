"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VerticalLinkMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_VerticalLinkMorph',
	#superclass : #'PLC_GraphicElementWithPinsMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_VerticalLinkMorph class >> newFromElement: anElement [
	"Nueva isntancia a partir de un elemento de un bloque conectable"

	| graphicElem num |

	graphicElem := self new.
		
	num := anElement connectableBlockInputs.
	num timesRepeat: [ graphicElem addInputPin. ].
	
	num := anElement connectableBlockOutputs.
	num timesRepeat: [ graphicElem addOutputPin. ].
	
	"Lo posiciono fuera del ladderView para que no moleste cuando
	hago layout"
	graphicElem position: graphicElem position - graphicElem layoutRectangle extent.
	
	^ graphicElem.
]

{ #category : #'model exploration' }
PLC_VerticalLinkMorph >> addToGroup: aGroup [
	"Chequea si fue explorado, si es así no hace nada.
	Si nunca fue explorado explora todas sus salidas."

	| newGroup |	
	
	( self owner wasExplored: self )
		ifFalse: [	
	
			"Se añade al grupo pasado como parámetro."
			aGroup add: self.

			"Añado al nuevo grupo todos los elementos de la rama serie a la 
			primer salida del VL."
			( self blockConnectedToOutput: 1 ) addToGroup: aGroup.
			
			"Si tiene más de una salida debo crear un Nuevo Grupo por cada una."	
			( 2 to: self outputPins size ) 
				do: [ :ind |
				
					"Creo un nuevo grupo."
					newGroup := PLC_GraphicElementGroup new.
	
					"Lo añado a la colección groups del PLC_LadderView."
					self owner groups add: newGroup.
					
					"Agrego todos los elementos de salida correspondientes a ese grupo."
					( self blockConnectedToOutput: ind ) addToGroup: newGroup.
					].

			].
]

{ #category : #extent }
PLC_VerticalLinkMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self totalExtent x @ ( self totalExtent y - 4 ).
]

{ #category : #extent }
PLC_VerticalLinkMorph >> defaultExtent [
	"Tamaño por defecto del elemento."
	
	^ self properties scale * ( 8 @ ( self gridExtent y * 3 ) ).

]

{ #category : #drawing }
PLC_VerticalLinkMorph >> drawElementOn: aCanvas [
	"Dibujo el rectangulo negro que representa al horizonta link."

	aCanvas fillRectangle: self vBar color: self userInteractionStateLayer1 elementColor.
]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutHorizontallyLeft: aDistanceX [
	"self se posiciona  de alguna manera con respecto a aDistanceX. 
	self solo se mueve horizontalmente."
	
	"Como el VL arranca en (0@0) y nunca va a volver hacia la izquierda puedo siempre 
	volver a alinearlo pero tengo que chequear que la nueva posicion en X sea mayor 
	que la anterior así no piso a nadie."

	| oldLeft |

	oldLeft := self left.
	
	"Alineo el elemento a aDistanceX."
	self layoutLeft: aDistanceX.

	"Si la nueva posicion horizontal es menor a la que tenia entonces lo vuelvo a correr."
	self left < oldLeft
		ifTrue: [
			self left: oldLeft.
			].
]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutHorizontallyOn: aLadderView from: aGraphicElement [
	"Posiciono Horizontalmente el VL."
	
	| oldPosition maxRightGroup |
		
	"Guardo la vieja posicion del enlace Vertical"
	oldPosition := self position.	
		
	"Posiciono el VL Horizontalmente a la derecha del layoutRectangle del elemento 
	que le envio este mensaje".
	self layoutHorizontallyLeft: aGraphicElement layoutRectangle right.
		
	"Posiciono Verticalemente los pines de entrada del VL y lo estiro al mayor tamaño 
	según todos los elementos conectados a sus entradas.
	Esto lo necesito para saber si pisa a algun grupo luego de posicionar horizontalmente."
	self layoutVerticallyInputPins.
	
	"Chequeo si el VL no pisa a algun grupo que no sea su propio grupo horizontalmente. 
	Si pisa lo muevo otra vez. Así en un loop hasta que no pise a nadie."
	( aLadderView gotAGroupHorizontallyUnderElement: self )
		ifTrue: [
			"Busco el grupo con mayor layoutRectangle right pisado por el VL"
			maxRightGroup :=  aLadderView maxRightGroupUnderElement: self.		
			"Posiciono el VL Horizontalmente a la derecha del layoutRectangle del 
			grupo hallado".
			maxRightGroup ifNotNil: [
				self layoutHorizontallyLeft: maxRightGroup layoutRectangle right.
				].
			].	
	
	"Si cambio su posicion horizontal entonces debo reposicionar Horizontalmente los 
	elementos conectados a sus salida. Para esto, borro los flags de las ramas serie a
	partir de sus salidas. Esto causa que se posicionen horizontalmente cuando les 
	llegue el turno de posicionarse."
	"( oldPosition >= self position )
		ifFalse: ["
			self xPositionedCascade: false.
			"]."		
]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"El elemento se posiciona dentro del ladderView."
	"En este caso solo se corre horizontalmente a la derecha
	de los elementos anteriores. Luego posiciona todas sus salidas."
	
	"Posiciono Horizontalmente el VL."
	self layoutHorizontallyOn: aLadderView from: aGraphicElement.

	"Posiciono todos los elementos conectados a sus salidas si ya 
	están posicionadas todas sus entradas."
	self layoutOutputsOn: aLadderView.
]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutOutputsOn: aLadderView [
	"Posiciono todos los elementos conectados a sus salidas si ya están posicionados 
	todos los elementos conectados a sus entradas."
	
	| xPositionedInputs inputGraphicElement outputGraphicElement |

	"Chequeo que se hayan posicionado todos los elementos conectados a sus entradas.
	Si esto no ocurre entonces no puedo posicionar los elementos conectados a sus salidas."
	xPositionedInputs := true.
	( 1 to: self inputPins size ) do: [ :ind |
		"Busco el elemento grafico conectado a la entrada numero ind"
		inputGraphicElement := self blockConnectedToInput: ind.
		"Chequeo el xPositioned del elemento hallado"
		xPositionedInputs := inputGraphicElement xPositioned and: [ xPositionedInputs ].
		].
	
	"Si ya posicionó todos los elementos conectados a sus entradas, 
	entonces posiciona todos los elementos conectados a sus salidas."
	xPositionedInputs ifTrue: [
					
		"Posiciono todos los elementos conectados a sus salidas."
		( 1 to: self outputPins size ) do: [ :ind |
		
			"Busco el elemento grafico conectado a la salida numero ind"
			outputGraphicElement := self blockConnectedToOutput: ind.
		
			"Posiciono el elemento grafico hallado"
			outputGraphicElement layoutOn: aLadderView from: self output: ind.
		
			"Acomodo su pin de salida segun el elemento que acabo de posicionar."
			self setPositionForOutputPin: ind to: ( self getFirstOutputPinPosition x @ outputGraphicElement getFirstInputPinPosition y ).
			].
	
		"Estiro el VL al mayor tamaño según todos los elementos conectados a sus entradas y salidas."
		self extent: ( self extent x @ ( ( self inputPins last bottom max: self outputPins last bottom ) - self position y ) ).	
			
		].
]

{ #category : #extent }
PLC_VerticalLinkMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	"En caso del Enlace Vertical el tamaño vertical del layoutRectangle debe ser del tamaño vertical 
	de la grilla  para que no moleste cuando esté dentro un grupo de primer pin y le pida 
	el layoutArea a dicho grupo. Molesta ya que me agranda el layoutRtangle del grupo 
	verticalmente dificultando el posicionamiento."

	^ self extent.
]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutRectangleForGroup [
	"Devuelve el rectángulo para acomodar en pantalla los elementos 
	entre si que usan los grupos azules."

	| origin corner |
	
	origin := self layoutRectangle topLeft.
	corner := origin + ( self defaultExtent x @ ( self properties scale y * self gridExtent y ) ).
	
	^ Rectangle origin: origin corner: corner.
]

{ #category : #position }
PLC_VerticalLinkMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ 0 @ 0.

]

{ #category : #layout }
PLC_VerticalLinkMorph >> layoutVerticallyInputPins [
	"Posiciono Verticalmente los pines de entrada del VL."
	
	| inputGraphicElement |
	
	
	"Posiciono todos los pines de entrada Verticalmente.
	Esto lo necesito para saber si pisa a algun grupo luego de posicionar horizontalmente ademas 
	de para acomodar los pines.."
	( 1 to: self inputPins size ) do: [ :ind |
		
		"Busco el elemento grafico conectado a la entrada numero ind"
		inputGraphicElement := self blockConnectedToInput: ind.
			
		"Acomodo su pin de entrada segun el elemento que acabo de hallar."
		self setPositionForInputPin: ind to: ( self getFirstInputPinPosition x @ inputGraphicElement getFirstOutputPinPosition y ).
		].	
	
	"Estiro el VL al mayor tamaño según todos los elementos conectados a sus entradas.
	Esto lo necesito para saber si pisa a algun grupo luego de posicionar horizontalmente."
	self extent: ( self extent x @ ( self inputPins last bottom - self position y ) ).	

]

{ #category : #extent }
PLC_VerticalLinkMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self extent.
	

]

{ #category : #'connection states' }
PLC_VerticalLinkMorph >> updateInputConnectonStates [
	"Actualiza las capas de estado de conexion del elemento conectados a su entrada."
	
	| inputGraphicElement |
			
	"Cambio los estados de conexion de capa 1 de todas sus entradas a conectado a self"
	( 1 to: self inputPins size ) do: [ :ind |
		
		"Busco el elemento grafico conectado a la salida numero ind"
		inputGraphicElement := self blockConnectedToInput: ind.
		
		"El estado de conexion de capa 1 es conectado a self en ambos casos"
		inputGraphicElement rightConnectedToVerticalLink.
		].
]

{ #category : #'connection states' }
PLC_VerticalLinkMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	
	| outputGraphicElement |
	
	"Actualiza las capas de estado de conexion de los elementos conectados a sus entradas."
	self updateInputConnectonStates.
		
	"Busco el elemento grafico conectado a la salida numero 1"
	outputGraphicElement := self blockConnectedToOutput: 1.
	
	"Cambio el estado de conexion de capa 2 al que traiga el elemento actual"
	outputGraphicElement connectionStateLayer2: self connectionStateLayer2.
	outputGraphicElement changed.
		
	"Cambio los estados de conexion de capa 1 de todas sus salidas a conectado a self"
	( 1 to: self outputPins size ) do: [ :ind |
		
		"Busco el elemento grafico conectado a la salida numero ind"
		outputGraphicElement := self blockConnectedToOutput: ind.
		
		"El estado de conexion de capa 1 es conectado a self en ambos casos"
		outputGraphicElement leftConnectedToVerticalLink.
	
		"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
		outputGraphicElement updateOutputsConnectonStates.
		].
]

{ #category : #drawing }
PLC_VerticalLinkMorph >> vBar [
	"Barra vertical que representa el right rail."

	| width height vBar |

	width := self properties scale y * 2.
	height := self properties scale y * ( self bounds height - 16 ).
	
	vBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ vBar align: vBar center with: self bounds center.
]
