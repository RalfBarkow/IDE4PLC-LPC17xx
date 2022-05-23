"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LadderView is xxxxxxxxx.

Instance Variables
	groups:		<Object>

groups
	- xxxxx

"
Class {
	#name : #'PLC_LadderView',
	#superclass : #'PLC_GraphicProgramView',
	#instVars : [
		'groups'
	],
	#category : #'IDE4PLC-Networks'
}

{ #category : #'commands send to controller' }
PLC_LadderView >> addCoilOnKeyboardFocusElement [
	"Agrega una Bobina sobre el elemento que tenga el foco del teclado."
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
	
	self ladderController addCoilOn: aConnectableBlockOrConnection.
	
]

{ #category : #'commands send to controller' }
PLC_LadderView >> addFunctionBlockOnKeyboardFocusElement [
	"Agrega un Bloque Función sobre el elemento que tenga el foco del teclado."
	
	| funBlkList |
	
	"Obtengo el controlador de la lista de funciones de la biblioteca"
	funBlkList := PLC_Libraries uniqueInstance functionBlockList.
	
	"Le seteo al list que el resultado me lo mande a mi (self = ladderView)"
	funBlkList target: self.
	
	"Le seteo al list que mensaje me tiene que mandar a mi con el resultado como parametro"
	funBlkList targetMessage: #addFunctionBlockOnKeyboardFocusElement:.
	
	
	"Le mando al controlador de la lista de funciones contenido en su
	 biblioteca que muestre su vista de Lista de Funciones"
	funBlkList openAt: self positionInWorld + ( 554 @ 82 negated ). 

]

{ #category : #'commands send to controller' }
PLC_LadderView >> addFunctionBlockOnKeyboardFocusElement: aFunctionBlock [
	"Agrega el Bloque de Función Elegido aFunctionBlock sobre el elemento que tenga el foco del teclado.
	
	addFunctionBlockOnKeyboardFocusElement"
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
		
	self ladderController 
		addFunctionBlockCallWithDeclaration: aFunctionBlock
		on: 	aConnectableBlockOrConnection.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> addFunctionOnKeyboardFocusElement [
	"Agrega una Función sobre el elemento que tenga el foco del teclado."
	
	| funList |
	
	"Obtengo el controlador de la lista de funciones"
	funList := PLC_Libraries uniqueInstance functionList.
	
	"Le seteo al list que el resultado me lo mande a mi (self = ladderView)"
	funList target: self.
	
	"Le seteo al list que mensaje me tiene que mandar a mi con el resultado como parametro"
	funList targetMessage: #addFunctionOnKeyboardFocusElement:.
	
	
	"Le mando al controlador de la lista de funciones contenido en su
	 biblioteca que muestre su vista de Lista de Funciones"
	funList openAt: self positionInWorld + ( 364 @ 82 negated ). 

]

{ #category : #'commands send to controller' }
PLC_LadderView >> addFunctionOnKeyboardFocusElement: aFunction [
	"Agrega la Función Elegida aFunction sobre el elemento que tenga el foco del teclado.
	
	addFunctionBlockOnKeyboardFocusElement"
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
		
	self ladderController 
		addFunctionCallWithDeclaration: aFunction
		on: 	aConnectableBlockOrConnection.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> addNCContactOnKeyboardFocusElement [
	"Agrega un Contacto normal cerrado sobre el elemento que tenga el foco del teclado."
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
	
	self ladderController addNCContactOn: aConnectableBlockOrConnection.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> addNCoilOnKeyboardFocusElement [
	"Agrega una Bobina Negada sobre el elemento que tenga el foco del teclado."
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
	
	self ladderController addNCoilOn: aConnectableBlockOrConnection.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> addNOContactOnKeyboardFocusElement [
	"Agrega un Contacto normal abierto sobre el elemento que tenga el foco del teclado."
	
	| aConnectableBlockOrConnection |
	
	"Busco el Bloque Conectable o conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self elements at: self keyboardFocusElement.
	
	self ladderController addNOContactOn: aConnectableBlockOrConnection.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> closeBranchOnSelectedElements [
	"Cierra una rama entre una conexion o bloque y otra conexion si se puede."
	
	| aPLC_ConnectableBlockOrConnection aPLC_Connection |
	
	aPLC_ConnectableBlockOrConnection := self selectedElements first.
	aPLC_ConnectableBlockOrConnection := self modelElementForGraphicElement: aPLC_ConnectableBlockOrConnection.
	
	aPLC_Connection := self selectedElements last.
	aPLC_Connection := self modelElementForGraphicElement: aPLC_Connection.
	
	self ladderController closeBranchFrom: aPLC_ConnectableBlockOrConnection to: aPLC_Connection.
]

{ #category : #'model accessing' }
PLC_LadderView >> connectableBlocksNetwork [
	"Devuelve la connectableBlocksNetwork de su controlador."

	^ self controller ladderNetwork 
]

{ #category : #'draw elements' }
PLC_LadderView >> drawElementFromBlock: connectableBlock [
	"Dibujo el elemento grafico de connectableBlock."

	| graphicElement |
	
	"Chequeo si ya lo dibuje, si es así no lo vuelvo a dibujar."
	( self wasDrawn: connectableBlock ) 
		ifTrue: [
			^ nil.
			] 
		ifFalse: [
			"Creo el elemento grafico."
			graphicElement := connectableBlock graphicElement.
	
			"Lo agrego de submorph"
			self addMorph: graphicElement.
	
			"Lo agrego al diccionario elementos"
			self elements at: graphicElement put: connectableBlock.
			
			"Le pido al elemento que aguregue sus morphs dependientes al ladderView si tiene.
			Estos pueden ser Actual Arguments o Pines"
			graphicElement addDependentsOnLadderView: self from: connectableBlock.
			
			"Dibujo todas sus salidas"
			self drawOutputsForElement: graphicElement.
			
			"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
			self selectedAndKeyboardFocus: graphicElement.
			
			^ graphicElement.
			].
]

{ #category : #'draw elements' }
PLC_LadderView >> drawElements [
	"Dibuja todos los elementos explorando el modelo. Los agrego al diccionario elements."
	
	| connectableBlock |
	
	"Busco en el modelo el Riel Izquierdo en el modelo"
	connectableBlock := self ladderNetwork leftPowerRailBlock.
	
	"Comienzo a dibujar todo el modelo comenzando por el LeftPowerRail.
	Cuando termina de dibujar el elemento dibuja todos los elementos conectados a sus salidas.
	En consecuencia, dibuja todos los elementos del modelo."
	self drawElementFromBlock: connectableBlock.
]

{ #category : #drawing }
PLC_LadderView >> drawGridOn: aCanvas [
	"Dibujo la grilla."

	(0 to: self gridSize y - 1) do: [ :vIndex |
		(0 to: self gridSize x - 1) do: [ :hIndex |
			aCanvas frameRectangle: ( self gridRectangleIn: (hIndex @ vIndex) )  width: 1 colors: {Color lightGray} dashes: {1}.
			].
		].
]

{ #category : #'drawing groups' }
PLC_LadderView >> drawGroups [
	"Dibuja los grupos de elementos con la misma posición vertical (ciam) del ladderView"
	
	| morph |

	self groups do: [ :group |
		
		"Dibujo el rectangulo del grupo"
		morph := BorderedMorph new.
		morph color: ( Color lightBlue alpha: 0.5 ).
		morph borderColor: Color blue.
		morph extent: group layoutRectangle extent.
		morph position: group layoutRectangle topLeft.
		
		"Añado este rectangulo como submorph"
		self addMorph: morph.
		
		].
]

{ #category : #'draw elements' }
PLC_LadderView >> drawHorizontalLinks [
	"Dibuja todos los Horizontal Links del modelo. Los agrega al diccionario elements."
	
	| leftPowerRailMorph |
	
	"Busco en el modelo el Riel Izquierdo en el modelo"
	leftPowerRailMorph := self graphicElementForModelElement: (self ladderNetwork leftPowerRailBlock).

	"Comienzo a dibujar todos los horizontal links del modelo comenzando por las salidas del LeftPowerRail.
	Cuando termina de dibujar le pide que dibuje a todos los elementos conectados a sus salidas.
	En consecuencia, dibuja todos los horizontal links del modelo."
	leftPowerRailMorph drawHorizontalLinksFrom: self.
]

{ #category : #'draw elements' }
PLC_LadderView >> drawHorizontalLinksFrom: connectableBlock [
	"Dibuja todos los Horizontal Links a las salidas de connectableBlock. 
	Los agrega al diccionario elements. Por último le dice a los elementos
	graficos conectados a sus salidas que dibujen sus horizontal links."

	| graphicElement horizontalLink connection outputConnectableBlock |
	
	graphicElement := self graphicElementForModelElement: connectableBlock.

	"Si no tiene salidas no hace nada!!"
	( 1 to: graphicElement outputPins size ) do: [ :ind |
		
		"Creo el Horizontal Link corespondiente a la salida numero ind."
		horizontalLink := PLC_HorizontalLinkMorph new.
		
		"Lo agrego de submorph"
		self addMorph: horizontalLink.
		
		"Busco la conexion a la salida numero ind de connectableBlock"
		connection := connectableBlock connectedAtOutput: ind.
		
		"Busco el bloque conectable conectado a la salida numero ind"
		outputConnectableBlock := connectableBlock blockConnectedToOutput: ind.
	
		"Lo agrego al diccionario elementos"
		self elements at: horizontalLink put: connection.
			
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		self selectedAndKeyboardFocus: horizontalLink.
		
		"Posiciono el Horizontal Link"
		horizontalLink centeredToTheRight: ( graphicElement outputPins at: ind ).
		
		"Actualizo su tamaño"
		horizontalLink extentChanged.
		
			
		"Dibujo los horizontal links de los elementos conectados a sus salidas"
		self drawHorizontalLinksFrom: outputConnectableBlock.
		
		].
]

{ #category : #drawing }
PLC_LadderView >> drawOn: aCanvas [
	"Dibujo la grilla."

	super drawOn: aCanvas.
	
	self properties drawGrid ifTrue: [
		self drawGridOn: aCanvas.
		].
]

{ #category : #'draw elements' }
PLC_LadderView >> drawOutputsForElement: aGraphicElement [
	"Dibujo todos los morphs conectados a las salidas de aGraphicElement"

	| connectableBlock outputConnectableBlock |
	
	"Obtengo el bloque conectable de aGraphicElement."
	connectableBlock := self modelElementForGraphicElement: aGraphicElement.	
	
	"Si no tiene salidas no hace nada!!"
	( 1 to: aGraphicElement outputPinsSize ) do: [ :ind |
		
		"Busco el bloque conectable conectado a la salida numero ind"
		outputConnectableBlock := connectableBlock blockConnectedToOutput: ind.
		
		"Dibujo el elemento grafico del bloque hallado"
		self drawElementFromBlock: outputConnectableBlock.
		].
]

{ #category : #'model exploration' }
PLC_LadderView >> exploreModel [
	"Explora el modelo"

	| connectableBlockLPR graphicElementLPR |

	"Inicializo las colecciones de los grupos de elementos del modelo."
	self groups: OrderedCollection new.
	
	"Busco en el modelo el Riel Izquierdo en el modelo"
	connectableBlockLPR := self ladderNetwork leftPowerRailBlock.

	"Obtengo el elemento grafico del bloque conectable"
	graphicElementLPR := self graphicElementForModelElement: connectableBlockLPR.
	
	"Comienzo a explorar todo el modelo comenzando por el LeftPowerRail."
	graphicElementLPR exploreModel.
	
	
		
	
]

{ #category : #layout }
PLC_LadderView >> gotAGroupHorizontallyUnderElement: aGraphicElementMorph [
	"Devuelve true si encuentra un Grupo cuyo layoutRectangle pise el layoutRectangle de aGraphicElementMorph.
	Si no encuentra ninguno devuelve false."
	
	( self maxRightGroupUnderElement: aGraphicElementMorph ) 
		ifNil: [
			^ false.
			] 
		ifNotNil: [
			^ true.
			].
]

{ #category : #layout }
PLC_LadderView >> gotAnElementVerticallyUnderGroup: aGroup [
	"Devuelve true si encuentra un Elemento cuyo layoutRectangle pise el layoutRectangle de aGroup.
	Si no encuentra ninguno devuelve false."
	
	( self maxBottomElementUnderGroup: aGroup ) 
		ifNil: [
			^ false.
			] 
		ifNotNil: [
			^ true.
			].
]

{ #category : #'model exploration' }
PLC_LadderView >> graphicElementForModelElement: aModelElement [
	"Devuelve el elemento grafico correspondiente al bloque conectable o conexion."

	^ self elements keyAtValue: aModelElement.
]

{ #category : #grid }
PLC_LadderView >> gridExtent [
	"Devuelve el tamaño en pixeles de una celda de la grilla gris."
	
	^ self properties gridExtent.
]

{ #category : #grid }
PLC_LadderView >> gridOrigin [
	"Devuelve la posicion 0@0 de la grilla"

	^ self position + self properties gridOrigin.
]

{ #category : #grid }
PLC_LadderView >> gridRectangleIn: aPoint [
	"Rectangulo del tamaño de la grilla"
	
	| rectangle |
	
	rectangle := Rectangle origin: ( 0 @ 0 ) corner: self gridExtent.

	^ rectangle translateBy: aPoint * self gridExtent + self gridOrigin.
]

{ #category : #grid }
PLC_LadderView >> gridSize [
	"Devuelve el tamaño de la grilla gris. Es decir, cuantos rectangulos por cuantos tiene la grilla"
	
	^ ( 6 @ 10 ).
]

{ #category : #'model exploration' }
PLC_LadderView >> groupFor: anElementOrGroup [
	"Devuelve el grupo que contiene al elemento o grupo anElementOrGroup."
	
	^ self groups 
		detect: [ :group |
			group includes: anElementOrGroup.
			]
		ifNone: [ ^ nil ].
]

{ #category : #accessing }
PLC_LadderView >> groups [
	
	^ groups
]

{ #category : #accessing }
PLC_LadderView >> groups: anObject [
	
	groups := anObject
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyBPressed [
	"Este mensaje se dispara cuando presionan la tecla B."

	self addCoilOnKeyboardFocusElement.
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyCPressed [
	"Este mensaje se dispara cuando presionan la tecla C."
	
	self addNOContactOnKeyboardFocusElement.
	
"
	Transcript show: ' Key C pressed
'.
"	
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyFPressed [
	"Este mensaje se dispara cuando presionan la tecla F."
	
	self addFunctionOnKeyboardFocusElement.
	
"
	Transcript show: ' Key C pressed
'.
"	
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyGPressed [
	"Este mensaje se dispara cuando presionan la tecla G."
	
	self addFunctionBlockOnKeyboardFocusElement.
	
"
	Transcript show: ' Key C pressed
'.
"	
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyNPressed [
	"Este mensaje se dispara cuando presionan la tecla N."

	self addNCoilOnKeyboardFocusElement.
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyOPressed [
	"Este mensaje se dispara cuando presionan la tecla O."
	
	self openBranchOnKeyboardFocusElement.
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyPPressed [
	"Este mensaje se dispara cuando presionan la tecla P."
	
	self closeBranchOnSelectedElements.
]

{ #category : #'keyboard events' }
PLC_LadderView >> keyVPressed [
	"Este mensaje se dispara cuando presionan la tecla V."

	self addNCContactOnKeyboardFocusElement.
	
"	
	Transcript show: ' Key V pressed
'.	
"
]

{ #category : #accessing }
PLC_LadderView >> ladderController [
	^ self controller
]

{ #category : #accessing }
PLC_LadderView >> ladderController: anObject [
	self controller: anObject.
]

{ #category : #'model accessing' }
PLC_LadderView >> ladderNetwork [
	"Devuelve la ladderNetwork de su controlador."

	^ self controller ladderNetwork 
]

{ #category : #layout }
PLC_LadderView >> layoutElements [
	"Dispone en pantalla todos los elementos dentro del ladderView"

	| connectableBlockLPR graphicElementLPR |
	
	"Busco en el modelo el Riel Izquierdo en el modelo"
	connectableBlockLPR := self ladderNetwork leftPowerRailBlock.

	"Obtengo el elemento grafico del bloque conectable"
	graphicElementLPR := self graphicElementForModelElement: connectableBlockLPR.
	
	"Comienzo a explorar todo el modelo comenzando por el LeftPowerRail."
	graphicElementLPR layoutOn: self.
	
]

{ #category : #layout }
PLC_LadderView >> maxBottomElementUnderGroup: aGroup [ 
	"Devuelve el elemento de mayor layoutRectangle bottom cuyo 
	layoutRectangle pise al layoutRectangle de aGroup."
	
	| elementsUnderGroup maxElement | 
	
	"Selecciono los elementos que estén bajo aGroup"
	elementsUnderGroup := OrderedCollection new.
	self elements keys asOrderedCollection do: [ :each | 
		( each layoutRectangle intersects: aGroup layoutRectangle )
			ifTrue: [ elementsUnderGroup add: each. ].
		].

	"Extraigo de la coleccion los elementos pertenecientes al grupo.
	Porque sino el grupo siempre pisa a los elementos que lo forman."
	aGroup elements do: [ :each |
		( elementsUnderGroup includes: each )
			ifTrue: [ 
				elementsUnderGroup remove:	each.		
				].
		].
	
	"Extraigo los elementos dependientes de los elementos del grupo."
	aGroup elementsDependentsUnderGroupLayoutRectangle do: [ :each |
		( elementsUnderGroup includes: each )
			ifTrue: [ 
				elementsUnderGroup remove:	each.		
				].
		].
	
	"Extraigo los elementos que no estén ya posicionados en X."
	elementsUnderGroup do: [ :each |
		( each xPositioned )
			ifFalse: [ 
				elementsUnderGroup remove:	each.		
				].
		].
	"Extraigo los elementos que no estén ya posicionados en Y."
	elementsUnderGroup do: [ :each |
		( each yPositioned )
			ifFalse: [ 
				elementsUnderGroup remove:	each.		
				].
		].
	
	"Busco el elemento cuyo layoutRectangle bottom sea maximo"
	( elementsUnderGroup size > 0 )
		ifTrue: [
			maxElement := elementsUnderGroup first.
			elementsUnderGroup do: [ :actualElem | 
				( actualElem layoutRectangle bottom >= maxElement  layoutRectangle bottom )
					ifTrue: [ maxElement := actualElem. ]. 
				].
			]
		ifFalse: [ 
			^ nil.
			].

	^ maxElement.
	
]

{ #category : #layout }
PLC_LadderView >> maxRightGroupUnderElement: aGraphicElementMorph [
	"Devuelve true si encuentra un Grupo cuyo layoutRectangle pise el layoutRectangle de aGraphicElementMorph.
	Si no encuentra ninguno devuelve nil."
	
	| groupsUnderElement group maxRightGroup | 
	
	"Obtengo el grupo del elemento"
	group := self groupFor: aGraphicElementMorph.		
	
	"Selecciono los grupos que estén bajo aGraphicElementMorph"
	groupsUnderElement := OrderedCollection new.
	self groups do: [ :each | 
		( each layoutRectangle intersects: aGraphicElementMorph layoutRectangle )
			ifTrue: [ groupsUnderElement add: each. ].
		].

	"Extraigo de la coleccion el grupo perteneciente a aGraphicElementMorph.
	Porque sino el grupo siempre pisa a los elementos que lo forman."
	groupsUnderElement 
		remove: group 
		ifAbsent: [ nil. ].
	
	"Busco el grupo cuyo layoutRectangle right sea maximo"
	( groupsUnderElement size > 0 )
		ifTrue: [
			maxRightGroup := groupsUnderElement first.
			groupsUnderElement do: [ :actualElem | 
				( actualElem layoutRectangle right >= maxRightGroup layoutRectangle right )
					ifTrue: [ maxRightGroup := actualElem. ]. 
				].
			]
		ifFalse: [ 
			^ nil.
			].

	^ maxRightGroup.
	
]

{ #category : #'commands send to controller' }
PLC_LadderView >> openBranchOnConnection: aGraphicConnection [
	"Abre una rama sobre una conexion (==)."
	
	| aConnection |
	
	"Busco la conexion del elemento con el Foco del Teclado."
	aConnection := self elements at: self keyboardFocusElement.
	
	self ladderController openBranchOnConnection: aConnection.
	
]

{ #category : #'commands send to controller' }
PLC_LadderView >> openBranchOnKeyboardFocusElement [
	"Abre una rama sobre la conexion que tenga el foco del teclado."
	
	| aConnectableBlockOrConnection |
	
	"Busco la conexion del elemento con el Foco del Teclado."
	aConnectableBlockOrConnection := self keyboardFocusElement.
	
	"Evio la peticion al elemento grafico"
	aConnectableBlockOrConnection openBranchOnConnectionFrom: self.
]

{ #category : #loop }
PLC_LadderView >> refresh [
	"Refresca la vista la vista"

	super refresh.
	
	self drawElements; 							"Dibuja los elemetos en el origen y los agrega a sus colecciones"
		exploreModel;								"Crea los grupos de elementos"
		updateOutputsConnectonStates;			"Actualiza los estados de conexion de los elementos"
		layoutElements;							"Dispone todos los elementos en pantalla"
		drawHorizontalLinks;						"Dibuja todos los Horizontal Links"
		extentChanged.							"Actualiza el tamaño del ladderView"

	"Restauro la lista de seleccionados y el Foco del teclado"
	"self restoreUIContext." "ANDA MAL"
						
	"Hago que sea visible"
	"self visible: true."
]

{ #category : #'commands send to controller' }
PLC_LadderView >> removeCoil: aContact [
	"Remueve una Bobina."
	
	| aConnectableBlock |
	
	"Busco el Bloque Conectable del elemento grafico."
	aConnectableBlock := self modelElementForGraphicElement: aContact.
	
	"Le envio la peticon al controlador"
	self ladderController removeCoil: aConnectableBlock.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> removeContact: aContact [
	"Remueve un Contacto."
	
	| aConnectableBlock |
	
	"Busco el Bloque Conectable del elemento grafico."
	aConnectableBlock := self modelElementForGraphicElement: aContact.
	
	"Le envio la peticion al controlador"
	self ladderController removeContact: aConnectableBlock.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> removeFunctionCall: aFunctionCallGraphicElementMorph [
	"Remueve un llamado a Función."
	
	| aConnectableBlock |
	
	"Busco el Bloque Conectable del elemento grafico."
	aConnectableBlock := self modelElementForGraphicElement: aFunctionCallGraphicElementMorph.
	
	"Le envio la peticion al controlador"
	self ladderController removeFunctionCall: aConnectableBlock.
]

{ #category : #'commands send to controller' }
PLC_LadderView >> removeRightPowerRail: aRightPowerRail [
	"Remueve un Right Power Rail:."
	
	| aConnectableBlock |
	
	"Busco el Bloque Conectable del elemento grafico."
	aConnectableBlock := self modelElementForGraphicElement: aRightPowerRail.
	
	"Le envio la peticion al controlador"
	self ladderController removeRightPowerRail: aConnectableBlock.
]

{ #category : #loop }
PLC_LadderView >> restoreUIContext [
	"Restauro la lista de seleccionados y el Foco del teclado"
		
	| selectedConnectableBlocks keyboardFocusConnectableBlock |

	uiContext ifNotNil: [ 
		
		"Paso todos los elementos a la lista de deseleccionados"
		self unselectAll.

		"Busco las la lista de bloques conectables seleccionados"
		selectedConnectableBlocks := uiContext at: 1.
	
		"Añado a la lista de seleccionados los elementos restantes"
		selectedConnectableBlocks do: [ :each |
			self addSelectedAndKeyboardFocus: ( self graphicElementForModelElement: each ).
			].
	
		"Busco el bloque conectable con foco del teclado"
		keyboardFocusConnectableBlock := uiContext at: 2.
		
		"Añado el elemento del foco del teclado"
		self addSelectedAndKeyboardFocus: ( self graphicElementForModelElement: keyboardFocusConnectableBlock ).
		
		].
]

{ #category : #loop }
PLC_LadderView >> saveUIContext [
	"Guardo los bloques conectables de los elementos morph seleccionados 
	y del elemento morph con foco del teclado, si existen."
		
	| selectedConnectableBlocks keyboardFocusConnectableBlock |
		
	( self selectedElements = nil and: [ self keyboardFocusElement = nil ] )

		ifFalse: [ 
		
			selectedConnectableBlocks := OrderedCollection new.
			
			self selectedElements ifNotNil: [
				self selectedElements do: [ :each |
					selectedConnectableBlocks add: 
					( self modelElementForGraphicElement: each ).
					].
				].
			self keyboardFocusElement 
				ifNotNil: [  
					keyboardFocusConnectableBlock := 
						( self modelElementForGraphicElement: self keyboardFocusElement ).
					].	
			
			uiContext := {selectedConnectableBlocks. keyboardFocusConnectableBlock. }.
		
			].
		
	

]

{ #category : #'connection states' }
PLC_LadderView >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de todos los elementos dentro del ladderView"

	| connectableBlockLPR graphicElementLPR |
	
	"Busco en el modelo el Riel Izquierdo en el modelo"
	connectableBlockLPR := self ladderNetwork leftPowerRailBlock.

	"Obtengo el elemento grafico del bloque conectable"
	graphicElementLPR := self graphicElementForModelElement: connectableBlockLPR.
	
	"Comienzo a actualizar todos los estados de conexion de los elementos graficos 
	comenzando por el LeftPowerRail."
	graphicElementLPR updateOutputsConnectonStates.
	
]

{ #category : #'draw elements' }
PLC_LadderView >> wasDrawn: connectableBlock [
	"Responde true si el elemento ya fue dibujado antes. Para responder chequea en su diccionario elements."

	^ self elements values includes: connectableBlock.
	
]

{ #category : #'model exploration' }
PLC_LadderView >> wasExplored: aGraphicElement [.
	"Responde true si el elemento ya fue explorado. Para verificarlo lo busca en sus grupos."

	^ self groups anySatisfy: [ :group |
		group includes: aGraphicElement.
		 ].
]
