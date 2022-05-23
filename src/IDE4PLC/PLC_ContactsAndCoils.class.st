"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ContactsAndCoils is xxxxxxxxx.

Instance Variables
	instanceVariable:		<Object>

instanceVariable
	- xxxxx

"
Class {
	#name : #'PLC_ContactsAndCoils',
	#superclass : #'PLC_GraphicElementWithPinsMorph',
	#instVars : [
		'instanceVariable'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_ContactsAndCoils class >> newFromConnectableBlock: aConnectableBlock [
	"Nueva isntancia a partir de un elemento de un bloque conectable"

	| graphicElem graphicVar |

	"Creo el elemento grafico"	
	graphicElem := self new.

	"Busco la variable del modelo y le pido su grafico"
	graphicVar := ( graphicElem instanceVariableFor: aConnectableBlock ) graphicElement.
	
	"Asigno al elemento grafico su variable morph"
	graphicElem instanceVariable: graphicVar.

	"Asigno a la variable morph el elemento grafico"
	graphicVar graphicElement: graphicElem.
	
	"Alineo la variable grafica al elemento grafico centrada sobre este"
	graphicVar alignAbove: graphicElem.
	"graphicVar alignCenteredAbove: graphicElem."
	
	"Lo posiciono fuera del ladderView para que no moleste cuando
	hago layout"
	graphicElem position: graphicElem position - graphicElem layoutRectangle extent.
	
	^ graphicElem.
]

{ #category : #'commands recive from ladder view' }
PLC_ContactsAndCoils >> addDependentsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus elementos graficos morphs dependientes al ladder view.
	Estos pueden ser Actual Arguments o Pines."

	| variableConnectableBlock variableGraficElement |

	"Busco la variable del modelo"
	variableConnectableBlock := aConnectableBlock element connectableBlockActualArgumentFor: aConnectableBlock.
	
	"Busco la variable grafica del elemento"
	variableGraficElement := self instanceVariable.
	
	"La agrego de submorph al ladderView"
	aLadderView addMorph: variableGraficElement.
	
	"Agrego la variable al diccionario elements"
	aLadderView elements at: variableGraficElement put: variableConnectableBlock.
	
	"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
	aLadderView selectedAndKeyboardFocus: variableGraficElement.
	
]

{ #category : #'model exploration' }
PLC_ContactsAndCoils >> addToGroup: aGroup [
	"El elemento Contacto o Bobina se añade al grupo pasado como parámetro.
	Luego le envía este mismo mensaje al elemento conectado a su salida."

	"Añado el elemento al grupo."
	aGroup add: self.
	
	"Le envío este mismo mensaje al elemento conectado a su salida."
	( self blockConnectedToOutput: 1 ) addToGroup: aGroup. 
]

{ #category : #extent }
PLC_ContactsAndCoils >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self properties scale * ( 72 @ 14 ).
]

{ #category : #drawing }
PLC_ContactsAndCoils >> bottomHBar [
	"Rectangulo horizontal para tapar el error grafico inferior."

	| width height bottomHBar |
	
	width := self properties scale x * 22.
	height := self properties scale y * 3.
		
	bottomHBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	bottomHBar align: bottomHBar bottomCenter with: self bounds bottomCenter.
	
	^ bottomHBar centeredBeneath: self backgroundRectangle.
	
	"^ bottomHBar translateBy: (0 @ 2)."
]

{ #category : #extent }
PLC_ContactsAndCoils >> defaultExtent [
	"Tamaño por defecto"
	
	^ self properties scale * ( 72 @ super defaultExtent y ).
]

{ #category : #drawing }
PLC_ContactsAndCoils >> drawPatchOn: aCanvas [
	"Parche cuando esta submorph. Hace un error gráfico que se dibuja fuera del canvas.
	Si no es submorph de nadie nunca se dibuja fuera del canvas"
		
	aCanvas fillRectangle: self topHBar color: self owner color;
		fillRectangle: self bottomHBar color: self owner color.
]

{ #category : #dependents }
PLC_ContactsAndCoils >> elementDependents [
	"Devuelve una OrderedCollection con sus elementos graficos morphs 
	dependientes que agregó al LadderView. En Contactos y Bobinas es
	su Actual Argument de instancia."

	| collection |
	
	collection := OrderedCollection new.
	
	collection add: self instanceVariable.
			
	^ collection.
]

{ #category : #'initialize-release' }
PLC_ContactsAndCoils >> initialize [
	"Inicializo el elemento grafico"

	super initialize.
	
	self extentChanged.

	"Añado los pines"
	self addInputPin;
		addOutputPin.
		
	"Los hago invisibles"
	self submorphs do: [ :morph |
		morph visible: false.
		].
]

{ #category : #accessing }
PLC_ContactsAndCoils >> instanceVariable [
	^ instanceVariable
]

{ #category : #accessing }
PLC_ContactsAndCoils >> instanceVariable: anObject [
	instanceVariable := anObject
]

{ #category : #layout }
PLC_ContactsAndCoils >> layoutOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"El elemento se posiciona dentro del ladderView."

	"Alineo Horizontalmente a este elemento gráfico."
	self layoutHorizontallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	"Alineo Verticalmnete su grupo."
	self layoutGroupVerticallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	"Posiciono el elemento conectado a la su salida."
	self layoutOutputsOn: aLadderView from: aGraphicElement output: anOutputNumber.
]

{ #category : #layout }
PLC_ContactsAndCoils >> layoutRectangle [
	"Devuelve el rectángulo para acomodar en pantalla los elementos entre si."

	| contactLayoutRectangle variableLayoutRectangle |
	
	contactLayoutRectangle := Rectangle 
		origin: ( 0 @ 0 )
		corner: self layoutRectangleExtent.
		
	contactLayoutRectangle := contactLayoutRectangle translateBy: self position + self layoutRectanglePosition.
	
	self instanceVariable 
		ifNil: [
			variableLayoutRectangle := self instanceVariable layoutRectangle.
			^ contactLayoutRectangle.
			]
		ifNotNil: [
			variableLayoutRectangle := self instanceVariable layoutRectangle.
			^ contactLayoutRectangle merge: variableLayoutRectangle.
			].
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> layoutRectangleExtentConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self voidLayoutRectangleExtent.
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> layoutRectangleExtentNotConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self voidLayoutRectangleExtent.
]

{ #category : #'connection states layer 1' }
PLC_ContactsAndCoils >> leftAndRightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1: PLC_GraphicElementState leftAndRightConnectedToVerticalLink.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> leftAndRightConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ ( super defaultExtent x - ( self properties scale x * 8 ) ) @ ( self defaultExtent y * 2 ).
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> leftAndRightConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -8 @ 0 ).
]

{ #category : #'connection states layer 1' }
PLC_ContactsAndCoils >> leftConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1 leftConnectedToVerticalLinkFor: self.
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> leftConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ ( super defaultExtent x - ( self properties scale x * 4 ) ) @ ( self defaultExtent y * 2 ).
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> leftConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -8 @ 0 ).
]

{ #category : #drawing }
PLC_ContactsAndCoils >> leftHBar [
	"Cable izquierdo del elemento."

	^ self hBar align: self hBar leftCenter with: self bounds leftCenter.
]

{ #category : #position }
PLC_ContactsAndCoils >> position: aPoint [
	"Establece la posicion en pantalla del elemento. 
	En el caso de los contactos y bobinas además reacomoda su variable asociada."
	
	super position: aPoint.
	
	self instanceVariable 
		ifNotNil: [
			self instanceVariable alignCenteredAbove: self
			].
]

{ #category : #'connection states layer 1' }
PLC_ContactsAndCoils >> rightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1 rightConnectedToVerticalLinkFor: self.
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> rightConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ ( super defaultExtent x - ( self properties scale x * 4 ) ) @ ( self defaultExtent y * 2 ).
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> rightConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -12 @ 0 ).
]

{ #category : #drawing }
PLC_ContactsAndCoils >> rightHBar [
	"Cable derecho del elemento."

	^ self hBar align: self hBar rightCenter with: self bounds rightCenter.

]

{ #category : #drawing }
PLC_ContactsAndCoils >> topHBar [
	"Rectangulo horizontal para tapar el error grafico superior."

	| width height topHBar |
	
	width := self properties scale x * 22.
	height := self properties scale y * 3.
		
	topHBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ topHBar align: topHBar topCenter with: self bounds topCenter - ( 0 @ 1).
	
	"^ topHBar translateBy: (0 @ 2)."
]

{ #category : #extent }
PLC_ContactsAndCoils >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self defaultExtent.
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> voidLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ super defaultExtent x @ ( self defaultExtent y * 2 ).
]

{ #category : #'commands recive from connection states' }
PLC_ContactsAndCoils >> voidLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -12 @ 0 ).
]
