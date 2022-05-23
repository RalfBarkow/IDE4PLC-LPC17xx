"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_RightPowerRailMorph is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_RightPowerRailMorph',
	#superclass : #'PLC_GraphicElementWithPinsMorph',
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'model exploration' }
PLC_RightPowerRailMorph >> addToGroup: aGroup [
	"El elemento RPR se añade al grupo pasado como parámetro.
	Aquí se corta la cadena de añadir al grupo."
	
	aGroup add: self.
]

{ #category : #extent }
PLC_RightPowerRailMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self defaultExtent x @ ( self properties scale y * 14 ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> backgroundRectanglePosition [
	"Devuelve la posición en pantalla del backgroundRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( 0 @ 2 ).
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> connectedToBlock [ 
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Bloque.
	Define Tipo de dibujo ( -->> o --| ) y layoutRectanglePosition "

	self connectionStateLayer1: PLC_GraphicElementState connectedToBlock .
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> connectedToBlockDrawElementOn: aCanvas [
	"Dibuja el elemento gráfico en este este estado de conexion."
	
	self drawVBarOn: aCanvas.
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> connectedToCoil [ 
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Bobina.
	Define Tipo de dibujo ( -->> o --| ) y layoutRectanglePosition "

	self connectionStateLayer1: PLC_GraphicElementState connectedToCoil.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> connectedToCoilDrawElementOn: aCanvas [
	"Dibuja el elemento gráfico en este este estado de conexion."
	
	self drawVBarOn: aCanvas.
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> connectedToContact [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Contacto.
	Define Tipo de dibujo ( -->> o --| ) y layoutRectanglePosition "

	self connectionStateLayer1: PLC_GraphicElementState connectedToContact.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> connectedToContactDrawElementOn: aCanvas [
	"Dibuja el elemento gráfico en este este estado de conexion."
	
	self drawDoubleArrowOn: aCanvas.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> connectedToContactLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self properties scale * ( ( self gridExtent x - 4 ) @ ( self gridExtent y * 2 ) ).
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> connectedToLeftPowerRail [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Barra Izquierda.
	Define Tipo de dibujo ( -->> o --| ) y layoutRectanglePosition "

	self connectionStateLayer1: PLC_GraphicElementState connectedToLeftPowerRail.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> connectedToLeftPowerRailTroughFirstOutputPinDrawElementOn: aCanvas [
	"Dibuja el elemento gráfico en este este estado de conexion."
	
	self drawVBarOn: aCanvas.
]

{ #category : #extent }
PLC_RightPowerRailMorph >> defaultExtent [
	"Tamaño por defecto del elemento."
	
	^ self properties scale * ( 15 @ self gridExtent y ).

]

{ #category : #drawing }
PLC_RightPowerRailMorph >> drawElementOn: aCanvas [
	"Dibujo el rectangulo negro que representa al horizonta link."

	aCanvas fillRectangle: self hBar color: self userInteractionStateLayer1 elementColor.
	
	self connectionStateLayer1 drawElementOn: aCanvas for: self.
]

{ #category : #drawing }
PLC_RightPowerRailMorph >> drawVBarOn: aCanvas [.
	"Dibuja la barra vertical del Riel Derecho conectado a contacto."
	
	aCanvas fillRectangle: self vBar color: self userInteractionStateLayer1 elementColor.
]

{ #category : #drawing }
PLC_RightPowerRailMorph >> hBar [
	"Barra horizontal que representa el cable de conexión con el right rail."

	| width height hBar |

	width := self properties scale x * self extent x.
	height := self properties scale y * 2.
	
	hBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ hBar align: hBar center with: self bounds center.
]

{ #category : #'initialize-release' }
PLC_RightPowerRailMorph >> initialize [
	"Inicializaciones del right rail."

	super initialize.
	
	"Agrego el pin de entrada"
	self addInputPin.
	"Lo hago invisible"
	self submorphs do: [ :morph |
		morph visible: false.
		].
	
	"Lo posiciono fuera del ladderView para que no moleste cuando
	hago layout"
	self position: self position - self layoutRectangle extent.	
]

{ #category : #'model exploration' }
PLC_RightPowerRailMorph >> isRightPowerRail [
	"Devuelve true si el elemento grafico es un Right Power Rail."

	^ true.
]

{ #category : #layout }
PLC_RightPowerRailMorph >> layoutHorizontallyLeft: aDistanceX [
	"self se posiciona  de alguna manera con respecto a aDistanceX. 
	self solo se mueve horizontalmente. Para lograrlo se lo pide a su
	estado de conexion 2."
	
	self connectionStateLayer2 layoutHorizontallyLeft: aDistanceX for: self.
]

{ #category : #layout }
PLC_RightPowerRailMorph >> layoutOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"El elemento se posiciona dentro del ladderView."

	"Alineo Horizontalmente a este elemento gráfico."
	self layoutHorizontallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	"Alineo Verticalmnete su grupo."
	self layoutGroupVerticallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> layoutRectangleExtentConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self properties scale * ( ( self gridExtent x - 4 ) @ ( self gridExtent y * 3 ) ).
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> layoutRectangleExtentNotConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self voidLayoutRectangleExtent.
]

{ #category : #position }
PLC_RightPowerRailMorph >> layoutRectanglePositionConnectedToBlock [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px].
	Cuando está conectado a Barra izquierda, Enlace Vertical o Bloque (F o FB)"
	
	^ self properties scale * ( -32 @ 0 ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> layoutRectanglePositionConnectedToContactOrCoil [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px].
	Cuando está conectado a cotacto o Bobina"
	
	^ self properties scale * ( 4 @ 0 ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> layoutRectanglePositionConnectedToLeftPowerRail [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px].
	Cuando está conectado a Barra izquierda, Enlace Vertical o Bloque (F o FB)"
	
	^ self properties scale * ( -32 @ 0 ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> layoutRectanglePositionConnectedToLeftPowerRailOutput1 [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px].
	Cuando está conectado a Barra izquierda, Enlace Vertical o Bloque (F o FB)"
	
	^ self properties scale * ( -4 @ self gridExtent y ) negated.
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> leftConnectedToVerticalLink [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Barra Izquierda.
	Define Tipo de dibujo ( -->> o --| ) y layoutRectanglePosition "

	self connectionStateLayer1: PLC_GraphicElementState leftConnectedToVerticalLink.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> leftConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self properties scale * ( ( self gridExtent x - 8 ) @ ( self gridExtent y * 2 ) ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> leftConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -28 @ 0 ).
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> notConnectedToLeftPowerRailTroughFirstOutputPinDrawElementOn: aCanvas [
	"Dibuja el elemento gráfico en este este estado de conexion."
	
	self drawDoubleArrowOn: aCanvas.
]

{ #category : #'commands recive from ladder view' }
PLC_RightPowerRailMorph >> removeElementFrom: aLadderView [
	"Remueve el elemento pidiendoselo a su ladder view. Hace un double dispatching con este"
	
	aLadderView removeRightPowerRail: self.
]

{ #category : #extent }
PLC_RightPowerRailMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self defaultExtent.
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> updateInputConnectonStates [
	"Actualiza las capas de estado de conexion del elemento conectados a su entrada."
	
	| inputGraphicElement |
		
	"Busco el elemento grafico conectado a la entrada numero 1"
	inputGraphicElement := self blockConnectedToInput: 1.
		
	"El estado de conexion de capa 1 es conectado a self"
	inputGraphicElement connectedToRightPowerRail.
]

{ #category : #'connection states' }
PLC_RightPowerRailMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion del elemento conectados a su salida."
	
	"Actualiza las capas de estado de conexion de los elementos conectados a sus entradas."
	self updateInputConnectonStates.
]

{ #category : #drawing }
PLC_RightPowerRailMorph >> vBar [
	"Barra vertical que representa el right rail."

	| width height vBar |

	width := self properties scale x * 2.
	height := self properties scale y * 6.
	
	vBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ vBar align: vBar rightCenter with: self bounds rightCenter.
]

{ #category : #'commands recive from connection states' }
PLC_RightPowerRailMorph >> voidLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self properties scale * ( ( self gridExtent x - 4 ) @ ( self gridExtent y * 2 ) ).
]

{ #category : #position }
PLC_RightPowerRailMorph >> voidLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -32 @ 0 ).
]
