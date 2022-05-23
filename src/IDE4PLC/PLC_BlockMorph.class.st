"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_BlockMorph is xxxxxxxxx.

Instance Variables
	inputFormalParameters:		<Object>
	instanceVariable:		<Object>
	modelElement:		<Object>
	outputFormalParameters:		<Object>

inputFormalParameters
	- xxxxx

instanceVariable
	- xxxxx

modelElement
	- xxxxx

outputFormalParameters
	- xxxxx

"
Class {
	#name : #'PLC_BlockMorph',
	#superclass : #'PLC_GraphicElementWithPinsMorph',
	#instVars : [
		'modelElement',
		'instanceVariable',
		'inputFormalParameters',
		'outputFormalParameters'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_BlockMorph class >> newFromConnectableBlock: aConnectableBlock [
	"Nueva isntancia a partir de un elemento de un bloque conectable"

	| blockMorph  |

	"Creo el elemento grafico"	
	blockMorph := self new.
	blockMorph modelElement: aConnectableBlock element.
	blockMorph position: 40@40.
	blockMorph build.
	
	"Lo posiciono fuera del ladderView para que no moleste cuando
	hago layout"
	blockMorph position: blockMorph position - blockMorph layoutRectangle extent.
	

	"Busco la variable del modelo y le pido su grafico"
	"graphicVar := ( blockMorph instanceVariableFor: aConnectableBlock ).
	
	graphicVar 
		ifNotNil: [ 
			
			graphicVar := graphicVar graphicElement."	"ARREGLAR, TA FEO QUE SE LLAMEN GRAFIC VAR las 2"
				
			"Asigno al elemento grafico su variable morph"
			"bloqueMorph instanceVariable: graphicVar."

			"Asigno a la variable morph el elemento grafico"
			"graphicVar graphicElement: bloqueMorph."
			
			"Alineo la variable grafica al elemento grafico centrada sobre este"
			"graphicVar alignAbove: bloqueMorph."
			"graphicVar alignCenteredAbove: graphicElem."
		"]."
	
	^ blockMorph.
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> addDependentsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus elementos graficos morphs dependientes al ladder view.
	Estos pueden ser Actual Arguments o Pines. aConnectableBlock es el 
	bloque conectable asociado a este morph."

	"Añado el Actual Argument Morph de variable de instancia si su elemento es llamado a Function Block"
	"self addInstanceOnLadderView: aLadderView from: aConnectableBlock."
	
	"Añado los pines de Entrada."
	self addInputPinsOnLadderView: aLadderView from: aConnectableBlock.
	
	"Añado los Actual Argument Morph conectados a sus Entrada."
	self addInputActualArgumentsOnLadderView: aLadderView from: aConnectableBlock.
	
	"Añado los pines de Salida."
	self addOutputPinsOnLadderView: aLadderView from: aConnectableBlock.
]

{ #category : #pins }
PLC_BlockMorph >> addFirstInputPin [
	"Añade el primer pin de entrada al elemento. Este es submorph."

	| pinMorph |

	pinMorph := PLC_PinBlockMorph new.
	
	"Posiciono el pin"
	pinMorph topLeft: 
		self topLeft + ( pinMorph extent x negated @ self firstPinYDistance ).
	
	"Lo agrego de submorph"	
	self addMorph: pinMorph.

	"Lo agrego a su lista de pines de entrada"
	self inputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #pins }
PLC_BlockMorph >> addFirstOutputPin [
	"Añade el primer pin de salida al elemento. Este es submorph."

	| pinMorph |

	pinMorph := PLC_PinBlockMorph new.
	
	"Posiciono el pin"
	pinMorph topRight: 	self topRight + ( pinMorph extent x @ self firstPinYDistance ).
	
	"Lo agrego de submorph"	
	self addMorph: pinMorph.

	"Lo agrego a su lista de pines de salida"
	self outputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> addInputActualArgumentsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus Actual Arguments de entrada al ladder view. aConnectableBlock es el 
	bloque conectable asociado a este morph."

	| actualArgumentConnectableBlock actualArgumentGraphicElementMorph |

	"Añados sus Actual Arguments de Entrada. Es a partir del 2 pues a la primer 
	entrada siempre tiene otro elemento"
	
	( 2 to: self inputPins size ) do: [ :index |
		
		"Busco el bloque conectable del Actual Argument de entrada"
		actualArgumentConnectableBlock := aConnectableBlock blockConnectedToInput: index.
		
		"Creo el elemento grafico."
		actualArgumentGraphicElementMorph := actualArgumentConnectableBlock graphicElement.
	
		"Lo agrego de submorph"
		aLadderView addMorph: actualArgumentGraphicElementMorph.
	
		"Lo agrego al diccionario elementos"
		aLadderView elements at: actualArgumentGraphicElementMorph put: actualArgumentConnectableBlock.
			
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		aLadderView selectedAndKeyboardFocus: actualArgumentGraphicElementMorph.

		].
	



]

{ #category : #pins }
PLC_BlockMorph >> addInputPin [
	"Añade un pin de entrada al elemento."

	| pinMorph |

	pinMorph := PLC_PinBlockMorph new.
	self inputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> addInputPinsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus pines de entrada dependientes al ladder view. 
	aConnectableBlock es el bloque conectable asociado a este morph."

	| dependenGraficElementMorph dependentConnectableBlockPin |
	
	"Añado los pines de Entrada."
	
	( 1 to: self inputPins size ) do: [ :index |
		
		"Busco el morph dependiente"
		dependenGraficElementMorph := self inputPins at: index.
						
		"Obtengo el pin correspondiente del bloque conectable de dependenGraficElementMorph."
		dependentConnectableBlockPin := aConnectableBlock inputs at: index.
	
		"Agrego el dependenGraficElementMorph de submorph al ladderView"
		aLadderView addMorph: dependenGraficElementMorph.
	
		"Agrego el dependenGraficElementMorph al diccionario elements"
		aLadderView elements at: dependenGraficElementMorph put: dependentConnectableBlockPin.
	
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		aLadderView selectedAndKeyboardFocus: dependenGraficElementMorph.

		].
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> addInstanceOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus elementos graficos morphs dependientes al ladder view.
	Estos pueden ser Actual Arguments o Pines."

	| variableConnectableBlock variableGraficElement |
	
	"Añado el Actual Argument Morph de variable de instancia si su elemento es llamado a Function Block"

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

{ #category : #pins }
PLC_BlockMorph >> addOutputPin [
	"Añade un pin de salida al elemento."

	| pinMorph |

	pinMorph := PLC_PinBlockMorph new.
	self outputPins add: pinMorph.
	
	^ pinMorph.
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> addOutputPinsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus pines de salida dependientes al ladder view. 
	aConnectableBlock es el bloque conectable asociado a este morph."

	| dependenGraficElementMorph dependentConnectableBlockPin |
	
	"Añado los pines de Salida."
	
	( 1 to: self outputPins size ) do: [ :index |
		
		"Busco el morph dependiente"
		dependenGraficElementMorph := self outputPins at: index.
						
		"Obtengo el pin correspondiente del bloque conectable de dependenGraficElementMorph."
		dependentConnectableBlockPin := aConnectableBlock outputs at: index.
	
		"Agrego el dependenGraficElementMorph de submorph al ladderView"
		aLadderView addMorph: dependenGraficElementMorph.
	
		"Agregoel dependenGraficElementMorph al diccionario elements"
		aLadderView elements at: dependenGraficElementMorph put: dependentConnectableBlockPin.
	
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		aLadderView selectedAndKeyboardFocus: dependenGraficElementMorph.

		].
]

{ #category : #'model exploration' }
PLC_BlockMorph >> addToGroup: aGroup [
	"El elemento Bloque se añade al grupo pasado como parámetro.
	Luego le envía este mismo mensaje al elemento conectado a su
	primer salida."

	"Añado el elemento al grupo."
	aGroup add: self.
	
	"Le envío este mismo mensaje al elemento conectado a su 
	primer salida."
	( self blockConnectedToOutput: 1 ) addToGroup: aGroup. 
]

{ #category : #extent }
PLC_BlockMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self totalExtent - ( 0 @ ((self properties scale y) * 12) )
]

{ #category : #position }
PLC_BlockMorph >> backgroundRectanglePosition [
	"Devuelve la posición en pantalla del backgroundRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( 0 @ 0 ).
]

{ #category : #drawing }
PLC_BlockMorph >> blockHeadRectangle [
	"Rectangulo de la cabecera de bloque."

	| width height blockHead |
	
	width := self backgroundRectangle extent x - ( self properties scale x * 2 ).
	height := self headHeight - ( self properties scale y ).
		
	blockHead := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ blockHead align: blockHead topLeft with: self bounds topLeft + self properties scale.
]

{ #category : #building }
PLC_BlockMorph >> bodyExtent [
	"Tamaño calculado a partir de sus submorphs."
	
	^( self extent x ) @
		( (self inputFormalParameters last bottom max: self outputFormalParameters last bottom ) 
			- self inputFormalParameters first top
				+ self headHeight + super defaultExtent y ).

]

{ #category : #building }
PLC_BlockMorph >> bodyTop [
	"Construye la cabecera del bloque."
	
	^ self headHeight + self top.
]

{ #category : #drawing }
PLC_BlockMorph >> bottomHBar [
	"Rectangulo horizontal para tapar el error grafico inferior."

	| width height bottomHBar |
	
	width := self properties scale x * 22.
	height := self properties scale y * 3.
		
	bottomHBar := Rectangle origin: (0@0) corner: ( width @ height ).
	
	bottomHBar align: bottomHBar bottomCenter with: self bounds bottomCenter.
	
	^ bottomHBar centeredBeneath: self backgroundRectangle.
	
	"^ bottomHBar translateBy: (0 @ 2)."
]

{ #category : #building }
PLC_BlockMorph >> build [
	"Construye el bloque."
	
	"self buildInstance."
	self buildHead;
		buildBody.
]

{ #category : #building }
PLC_BlockMorph >> buildBody [
	"Construye el cuerpo del bloque."
		
	"Creo sus Formal Parameters"		
	self buildInputs;
		buildOutputs;
		buildInOuts.
		
	"Posiciono sus Formal Parameters"
	self positionHorizontallyFormalParameters;
	 	positionVerticallyFormalParameters.
		
	"Actualizo su tamaño"
	self extent: self bodyExtent.
]

{ #category : #building }
PLC_BlockMorph >> buildHead [
	"Construye la cabecera del bloque."
	
	self buildName;
		buildOverloaded.
]

{ #category : #building }
PLC_BlockMorph >> buildInOuts [
	"Construye las entrada-salidas del cuerpo del bloque."

	| inputInOutFP outputInOutFP |

	( 1 to: self element buildInOuts size ) do: [ :idx |
		
		"Creo el inOutFP de entrada y le agrego su pin"

		inputInOutFP := PLC_InOutFormalParameterMorph new.

		self addMorph: inputInOutFP.	
		self inputFormalParameters add: inputInOutFP.
		
		inputInOutFP text: ( self element buildInOuts at: idx ) identifier.
		inputInOutFP leftAlign.
				
		self addInputPin.
		

		
		"Creo el inOutFP de salida y le agrego su pin"
		
		outputInOutFP := PLC_InOutFormalParameterMorph new.
		
		self addMorph: outputInOutFP.	
		self outputFormalParameters add: outputInOutFP.
		
		outputInOutFP text: ( self element buildInOuts at: idx ) identifier.
		outputInOutFP rightAlign.	
		
		self addOutputPin.
		
		"Asocio los inOutFP"
		inputInOutFP inOutFPAssociated: outputInOutFP.
		outputInOutFP inOutFPAssociated: inputInOutFP.
		
		
		].
]

{ #category : #building }
PLC_BlockMorph >> buildInputs [
	"Construye las entradas del cuerpo del bloque."
	
	| formalParameter |

	( 1 to: self element buildInputs size ) do: [ :idx |
		
		formalParameter := PLC_FormalParameterMorph new.
		
		self addMorph: formalParameter.
		self inputFormalParameters add: formalParameter.
		
		formalParameter text: ( self element buildInputs at: idx ) identifier.

		formalParameter leftAlign.
				
		self addInputPin.
		].
]

{ #category : #building }
PLC_BlockMorph >> buildName [
	"Construye el Nombre de la cabecera del bloque."
	
	| blockName |
	
	blockName := self nameMorph.
	
	self addMorph: blockName.
	
	^ blockName.
]

{ #category : #building }
PLC_BlockMorph >> buildOutputs [
	"Construye las salidas del cuerpo del bloque."

	| formalParameter |

	( 1 to: self element buildOutputs size ) do: [ :idx |
		
		formalParameter := PLC_FormalParameterMorph new.
		
		self addMorph: formalParameter.
		self outputFormalParameters add: formalParameter.
		
		formalParameter text: ( self element buildOutputs at: idx ) identifier.
		formalParameter rightAlign.			
				
		self addOutputPin.
		
		].
]

{ #category : #building }
PLC_BlockMorph >> buildOverloaded [
	"Construye el tag de Overloaded de la cabecera del bloque."
	
	| overloaded |
	
	self overloadedType
		ifNil:[
			^ nil
			]	
		ifNotNil: [ 
			overloaded := self overloadedMorph.
			self addMorph: overloaded.
			^ overloaded.
			].	
	

]

{ #category : #declaration }
PLC_BlockMorph >> declaration [
	
	^ self element declaration.
]

{ #category : #extent }
PLC_BlockMorph >> defaultExtent [
	"Tamaño por defecto"
	
	^ self elementWidth @ ( self properties scale y * super defaultExtent y * 3 ).
]

{ #category : #'user interaction states' }
PLC_BlockMorph >> draggingAnother [
	"Estado cuando estaba seleccionado y arrastran otro elemento desde fuera de la network."

	self userInteractionStateLayer1: PLC_GraphicElementState draggingAnother.
	self changed.
	
	self submorphsPerform: #draggingAnother.
	
	self inputPins do: [ :each |
		each unselected.
		].
	
	self outputPins do: [ :each |
		each unselected.
		].
	
	self changed.
]

{ #category : #'user interaction states' }
PLC_BlockMorph >> draggingSelf [
	"Estado cuando el elemento esta siendo arrastrado por el mouse."

	self userInteractionStateLayer1: PLC_GraphicElementState draggingSelf.
	self changed.
	
	self submorphsPerform: #draggingSelf.
	
	self inputPins do: [ :each |
		each unselected.
		].
	
	self outputPins do: [ :each |
		each unselected.
		].
	
	self changed.
]

{ #category : #drawing }
PLC_BlockMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	aCanvas 
		fillRectangle: self backgroundRectangle 
		color: self userInteractionStateLayer1 blockBodyColor.
]

{ #category : #drawing }
PLC_BlockMorph >> drawElementOn: aCanvas [
	"Dibujo el cuadro de la cabecera de bloque."

	aCanvas fillRectangle: self blockHeadRectangle color: self userInteractionStateLayer1 blockFootAndHeaderColor.
]

{ #category : #'draw elements' }
PLC_BlockMorph >> drawHorizontalLinksFrom: aLadderView [
	"Dibuja el Horizontal Links de la primer salida del Bloque. 
	Lo agrega al diccionario elements de aLadderView. 
	Por último le dice al elementos graficos conectados 
	a su primer salida que dibuje sus horizontal links."

	| connectableBlock horizontalLink connection outputGraphicElement |
	
	connectableBlock := aLadderView modelElementForGraphicElement: self.
		
	"Creo el Horizontal Link corespondiente a la salida numero 1."
	horizontalLink := PLC_HorizontalLinkMorph new.
		
	"Lo agrego de submorph"
	aLadderView addMorphBack: horizontalLink.
		
	"Busco la conexion a la salida numero 1 de connectableBlock"
	connection := connectableBlock connectedAtOutput: 1.
	
	"Lo agrego al diccionario elementos"
	aLadderView elements at: horizontalLink put: connection.
			
	"Lo selecciono y le doy el foco del teclado"
	aLadderView selectedAndKeyboardFocus: horizontalLink.
		
	"Posiciono el Horizontal Link"
	horizontalLink top: ( self outputPins at: 1 ) top.
	horizontalLink left: self right.
		
	"Actualizo su tamaño"
	horizontalLink extentChanged.
		
		
	"Busco el bloque conectable conectado a la salida numero 1"
	outputGraphicElement := self blockConnectedToOutput: 1.
		
	"Dibujo los horizontal links de los elementos conectados a sus salidas"
	outputGraphicElement drawHorizontalLinksFrom: aLadderView.
]

{ #category : #drawing }
PLC_BlockMorph >> drawPatchOn: aCanvas [
	"Parche cuando esta submorph. Hace un error gráfico que se dibuja fuera del canvas.
	Si no es submorph de nadie nunca se dibuja fuera del canvas"
		
	aCanvas fillRectangle: self topHBar color: self owner color;
		fillRectangle: self bottomHBar color: self owner color.
]

{ #category : #'model exploration' }
PLC_BlockMorph >> element [
	"Devuelve el elemento seteado cuando se crea el Elemento Grafico Morph"

	^ self modelElement.
]

{ #category : #dependents }
PLC_BlockMorph >> elementDependents [
	"Devuelve una OrderedCollection con sus elementos graficos morphs 
	dependientes que agregó al LadderView. Estos pueden ser 
	Actual Arguments o Pines."

	| collection |
	
	collection := OrderedCollection new.
	
	collection addAll: self inputPins; 
		addAll: self outputPins.
		"addAll: self inputActualArguments ."
			
	^ collection.

]

{ #category : #extent }
PLC_BlockMorph >> elementDoubleWidth [
	"Doble ancho del elemento"

	^ self properties scale x * 180.
]

{ #category : #extent }
PLC_BlockMorph >> elementWidth [
	"Ancho estandar del elemento"

	^ self properties scale x * 84.
]

{ #category : #pins }
PLC_BlockMorph >> firstPinYDistance [
	"Devuelve la distancia  en pantalla en Y del primer pin de entrada 
	y salida relativa a la posicion vertical de self .
	Es la distancia vertical entre la parte de arriba del elemento y el primer pin."
	
	"^ self headHeight."
	^ 36
	
"

layoutFirstPinsYDistance
	""Devuelve la distancia minima en pantalla en Y del primer pin de entrada 
	y salida relativa a layoutRectangle top de self .
	Es la distancia vertical entre la parte de arriba del elemento y sus sub elementos y el primer pin."
	
	"^ self layoutRectangleRelativePosition y - self firstPinYDistance.

distanceBetweenPins"
	"Devuelve la distancia en pantalla en Y ente pines del elemento."
	
	"^ self minYDistanceBetweenPins.
	
"
]

{ #category : #'commands recive from formal parameters' }
PLC_BlockMorph >> formalParameterWithDoubleWidth [
	"Mensaje que se ejecuta cuando algún Formal Parameter Morph 
	necesita el doble del ancho de bloque."

	self doubleWidth.
]

{ #category : #building }
PLC_BlockMorph >> headHeight [
	"Construye la cabecera del bloque."
	
	^ 36.
	"^ self nameMorph extent y + self overloadedMorph extent y."
]

{ #category : #declaration }
PLC_BlockMorph >> identifier [
	
	^ self declaration identifier.
]

{ #category : #'initialize-release' }
PLC_BlockMorph >> initialize [
	"Inicializaciones"

	super initialize.

	inputFormalParameters := OrderedCollection new.
	outputFormalParameters := OrderedCollection new.
	
	"self addFirstInputPin;
		addFirstOutputPin."
]

{ #category : #accessing }
PLC_BlockMorph >> inputFormalParameters [
	
	^ inputFormalParameters
]

{ #category : #accessing }
PLC_BlockMorph >> inputFormalParameters: anObject [
	
	inputFormalParameters := anObject
]

{ #category : #'commands recive from formal parameters' }
PLC_BlockMorph >> inputInOutFPVerticallyChanged: inOutFP [
	"Mensaje que se ejecuta cuando algún In Out Formal Parameter Morph 
	cambia su posicion vertical y notifica al bloque."

	| index actualArgumentMorph |

	"Obtengo el indice de inOutFP"
	index := self inputFormalParameters indexOf: inOutFP.
]

{ #category : #accessing }
PLC_BlockMorph >> instanceVariable [
	"Es el morph Acrual Argument sobre el bloque"

	^ instanceVariable
]

{ #category : #accessing }
PLC_BlockMorph >> instanceVariable: anObject [
	instanceVariable := anObject
]

{ #category : #'instance variable' }
PLC_BlockMorph >> instanceVariableFor: aConnectableBlock [
	"Devuelve el bloque conectable de la variable instancia, (si tiene) desde el bloque conectable del elemento."

	self element isFunction
		ifTrue: [ 
			^ nil.
			] 
		ifFalse: [ 
			^ aConnectableBlock blockConnectedToInput: aConnectableBlock inputs size.
			].
]

{ #category : #'model exploration' }
PLC_BlockMorph >> isPLCBlock [
	"Devuelve true si el elemento grafico es un Bloque."

	^ true
]

{ #category : #pins }
PLC_BlockMorph >> layoutHorizontallyInputPins [
	"Posiciona horizontalmente los pines de entrada del bloque."

	self inputPins do: [ :each |
		each left: self left - each extent x.
		].
]

{ #category : #pins }
PLC_BlockMorph >> layoutHorizontallyOutputPins [
	"Posiciona horizontalmente los pines de salida del bloque."

	self outputPins do: [ :each |
		each right: self right + each extent x.
		].
]

{ #category : #pins }
PLC_BlockMorph >> layoutHorizontallyPins [
	"Posiciona horizontalmente todos los pines del bloque."

	self layoutHorizontallyInputPins;
		layoutHorizontallyOutputPins.
]

{ #category : #building }
PLC_BlockMorph >> layoutInput [
	"Construye las entradas del cuerpo del bloque."
	
	| formalParameter formalParameterTop pinMorph |

	formalParameterTop := self bodyTop.

	( 1 to: self element buildInputs size ) do: [ :idx |
		
		formalParameter := PLC_FormalParameterMorph new.
		
		self addMorph: formalParameter.
		self inputFormalParameters add: formalParameter.
		
		formalParameter text: ( self element buildInputs at: idx ) identifier.
		formalParameter top: formalParameterTop. 
		
		formalParameterTop := formalParameter bottom.
		formalParameter left: self left.
		formalParameter leftAlign.
				
		pinMorph := self addInputPin.
		pinMorph bottom: formalParameter bottom.
		
		].
	
	^ formalParameterTop.
]

{ #category : #layout }
PLC_BlockMorph >> layoutInputActualArguments [
	"Posiciono los Actual Arguments conectados a sus entradas.
	Este método es válido para cuando el bloque tiene sólamente 
	Actual arguments conectados a sus entradas a partir de la 
	segunda. No si tiene Contactos o Bobinas."
	
	| inputFormalParameter nextInputFormalParameter inputPin inputActualArgument |
	
	"Alineo los Actual Arguments de salidas a partir de la segunda"
	( 2 to: self inputPins size ) do: [ :index |
		
		"Obtengo el Formal Parameter a su salida numero index"
		inputFormalParameter := self inputFormalParameters at: index.
		
		"Obtengo el Pin a su entrada numero index"
		inputPin := self inputPins at: index.
		
		"Obtengo el Actual Argument conectado a su entrada numero index"
		inputActualArgument := self blockConnectedToInput: index.
			
		"Posiciono en pantalla Horizontal y Verticalmente el Actual Argument obtenido."
		inputActualArgument layoutTop: inputFormalParameter top.
		inputActualArgument layoutLeft: inputPin left - inputActualArgument layoutRectangle extent x.
		
		"Actualizo la posición Vertical del Formal Parameter de dicha entrada. 
		Esto es para cuando el texto del Actual Argument es de más de una línea."
		inputActualArgument bottom: ( inputActualArgument bottom max: inputFormalParameter bottom ).
		inputFormalParameter bottom: inputActualArgument bottom.
		
		"En caso de ser un inOutFP Actualizo su inputInOutFP asociada."
		( inputFormalParameter inOutFPAssociated )
			ifNotNil: [ 
				inputFormalParameter inOutFPAssociated 
					updateOutputInOutFPAssociatedVerticalPosition.
				] .
		
		"Actualizo la posicion Vertical del Formal Parameter siguiente si existe"
		( index < self inputPins size )
			ifTrue: [ 
				nextInputFormalParameter := self inputFormalParameters at: index + 1. 
				nextInputFormalParameter top: inputFormalParameter bottom. 
				].			
		].
]

{ #category : #layout }
PLC_BlockMorph >> layoutOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"El elemento se posiciona dentro del ladderView."

	"Actualizo los estados de alineacion de los elementos conectados a sus entradas y salidas"
	self updateConnectedMorphsAlignStates.
	
	"Alineo Horizontalmente a este elemento gráfico."
	self layoutHorizontallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	"Alineo Horizontalmente sus pines."
	self layoutHorizontallyPins.
		
	"Alineo Verticalmente su grupo."
	self layoutGroupVerticallyOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	"Posiciono sus Actual Arguments de entrada a partir de la segunda"
	self layoutInputActualArguments.
	"Posiciono los Actual Arguments de salidas a partir de la segunda"
	self layoutOutputActualArguments.
	
	"Actualizo el tamaño del bloque"
	self extent: self bodyExtent.
	"Actualizo la posicion Vertical de los pines"
	self layoutVerticallyPins.
		
	"Posiciono el elemento conectado a su primer salida."
	self layoutOutputsOn: aLadderView from: aGraphicElement output: anOutputNumber.
	
	
]

{ #category : #layout }
PLC_BlockMorph >> layoutOutputActualArguments [
	"Posiciono los Actual Arguments conectados a sus salidas."
	
	| outputFormalParameter nextOutputFormalParameter outputPin outputActualArgument |
	
	"Alineo los Actual Arguments de salidas a partir de la segunda"
	( 2 to: self outputPins size ) do: [ :index |
		
		"Obtengo el Formal Parameter a su salida numero index"
		outputFormalParameter := self outputFormalParameters at: index.
		
		"Obtengo el Pin a su salida numero index"
		outputPin := self outputPins at: index.
		
		"Obtengo el Actual Argument conectado a su salida numero index"
		outputActualArgument := self blockConnectedToOutput: index.
			
		"Posiciono en pantalla Horizontal y Verticalmente el Actual Argument obtenido."
		outputActualArgument layoutTop: outputFormalParameter top.
		outputActualArgument layoutLeft: outputPin right.
		
		"Actualizo la posición Vertical del Formal Parameter de dicha salida. 
		Esto es para cuando el texto del Actual Argument es de más de una línea."
		outputActualArgument bottom: ( outputActualArgument bottom max: outputFormalParameter bottom ).
		outputFormalParameter bottom: outputActualArgument bottom.
		
		"En caso de ser un inOutFP Actualizo su inputInOutFP asociada."
		( outputFormalParameter inOutFPAssociated )
			ifNotNil: [ 
				outputFormalParameter inOutFPAssociated 
					updateInputInOutFPAssociatedVerticalPosition.
				] .
		
		"Actualizo la posicion Vertical del Formal Parameter siguiente si existe"
		( index < self outputPins size )
			ifTrue: [ 
				nextOutputFormalParameter := self outputFormalParameters at: index + 1. 
				nextOutputFormalParameter top: outputFormalParameter bottom. 
				].
			
		].
]

{ #category : #layout }
PLC_BlockMorph >> layoutOutputsOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"Posiciono el elemento conectado a su primer salida."
	
	"Posiciono el elemento conectado a la primer salida"
	super layoutOutputsOn: aLadderView from: aGraphicElement output: anOutputNumber.

]

{ #category : #layout }
PLC_BlockMorph >> layoutRectangle [
	"Devuelve el rectángulo para acomodar en pantalla los elementos entre si."

	| blockLayoutRectangle variableLayoutRectangle |
	
	blockLayoutRectangle := Rectangle 
		origin: ( 0 @ 0 )
		corner: self layoutRectangleExtent.
		
	blockLayoutRectangle := blockLayoutRectangle translateBy: self position + self layoutRectanglePosition.
	
	self instanceVariable
		ifNil: [ 
			^ blockLayoutRectangle.
			]
		ifNotNil: [ 
			variableLayoutRectangle := self instanceVariable layoutRectangle.
			^ blockLayoutRectangle merge: variableLayoutRectangle.
			].
		
	
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> layoutRectangleExtentConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self voidLayoutRectangleExtent.
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> layoutRectangleExtentNotConnectedToLeftPowerRailOutput1 [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self voidLayoutRectangleExtent.
]

{ #category : #layout }
PLC_BlockMorph >> layoutRectangleForGroup [
	"Devuelve el rectángulo para acomodar en pantalla los elementos 
	entre si que usan los grupos azules."

	^ Rectangle origin: self layoutRectangle topLeft 
			corner: ( self layoutRectangle right @ ( self headHeight + self gridExtent y ) ).
			
		"ARREGLARRRRRRRRRRRRRRRRRRRRRRRRRRR"
]

{ #category : #layout }
PLC_BlockMorph >> layoutVerticallyInputPins [
	"Posiciona verticalmente los Pines de entrada."
	
	| formalParameter inputPin |

	( 1 to: self inputPins size ) do: [ :idx |
		
		"Obtengo el inputFormalParameter"
		formalParameter := self inputFormalParameters at: idx.
		
		"Obtengo el inputPin"
		inputPin := self inputPins at: idx.
		
		"Establezco su posicion Vertical"
		inputPin bottom: formalParameter bottom. 
		
		].
]

{ #category : #layout }
PLC_BlockMorph >> layoutVerticallyOutputPins [
	"Posiciona verticalmente los Pines de salida."
	
	| formalParameter outputPin |

	( 1 to: self outputPins size ) do: [ :idx |
		
		"Obtengo el inputFormalParameter"
		formalParameter := self outputFormalParameters at: idx.
		
		"Obtengo el outputPin"
		outputPin := self outputPins at: idx.
		
		"Establezco su posicion Vertical"
		outputPin bottom: formalParameter bottom. 
		
		].
]

{ #category : #layout }
PLC_BlockMorph >> layoutVerticallyPins [
	"Posiciona verticalmente los Pines."
	
	self layoutVerticallyInputPins;
		layoutVerticallyOutputPins.
]

{ #category : #'connection states layer 1' }
PLC_BlockMorph >> leftAndRightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1: PLC_GraphicElementState leftAndRightConnectedToVerticalLink.
	self changed.
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> leftAndRightConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent + (self properties scale * ( 196 @ 0 ) ). " 196 = (self gridExtent x * 2) + 4 "
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> leftAndRightConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -98 @ 0 ). " -98 = -self gridExtent x - 2 "
]

{ #category : #'connection states layer 1' }
PLC_BlockMorph >> leftConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1 leftConnectedToVerticalLinkFor: self.
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> leftConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent + (self properties scale * ( 200 @ 0 ) ). " 200 = (self gridExtent x * 2) + 8 "
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> leftConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."

	^ self properties scale * ( -98 @ 0 ). " -98 = -self gridExtent x - 2 "
]

{ #category : #accessing }
PLC_BlockMorph >> modelElement [
	
	^ modelElement
]

{ #category : #accessing }
PLC_BlockMorph >> modelElement: anObject [
	
	modelElement := anObject
]

{ #category : #building }
PLC_BlockMorph >> nameExtent [
	"Tamaño del nombre."
	
	^ self nameMorph extent.
]

{ #category : #building }
PLC_BlockMorph >> nameMorph [
	"Construye el Nombre de la cabecera del bloque."
	
	| blockName |
	
	blockName := PLC_BlockNameMorph new.

	blockName text: self identifier.
	"blockName useMaxWidth ifTrue: [ self useMaxWidth: true. ]. "
	blockName center: self center.
	blockName top: self top.
	
	^ blockName.
]

{ #category : #accessing }
PLC_BlockMorph >> outputFormalParameters [
	
	^ outputFormalParameters
]

{ #category : #accessing }
PLC_BlockMorph >> outputFormalParameters: anObject [
	
	outputFormalParameters := anObject
]

{ #category : #'commands recive from formal parameters' }
PLC_BlockMorph >> outputInOutFPVerticallyChanged: inOutFP [
	"Mensaje que se ejecuta cuando algún In Out Formal Parameter Morph 
	cambia su posicion vertical y notifica al bloque."

	| index actualArgumentMorph |

	"Obtengo el indice de inOutFP"
	index := self outputFormalParameters indexOf: inOutFP.
	
	"Obtengo el Actual Argument conectado a la salida numero index"
	"actualArgumentMorph := self blockConnectedToOutput: index."
	
	"Posiciono verticalmente el Actual Argument"
	
	"HACERRRRRRRRRRRRRRRRRRRRRR"
	
]

{ #category : #building }
PLC_BlockMorph >> overloadedExtent [
	"Tamaño del overloaded tag."
	
	self overloadedMorph 
		ifNil: [
			^ 0@0
			]
		ifNotNil: [
			^ self overloadedMorph extent.
			]
]

{ #category : #building }
PLC_BlockMorph >> overloadedMorph [
	"Construye el tag de Overloaded de la cabecera del bloque."
	
	| overloaded |
	
	self overloadedType
		ifNil: [ 
			^ nil.
			]
		ifNotNil: [ 
			overloaded := PLC_OverloadedMorph new.	
			overloaded text: self overloadedType.
			"overloaded useMaxWidth ifTrue: [ self useMaxWidth: true. ]. "
			overloaded center: self center.
			overloaded top: self top +18.
			"overloaded centeredBeneath: self nameMorph."
	
			^ overloaded.
			].	
	

]

{ #category : #declaration }
PLC_BlockMorph >> overloadedType [
	
	self declaration dataType 
		ifNil: [ 
			^ nil.
			] 
		ifNotNil: [ 
			^ self declaration dataType ilCompile.
			]		
]

{ #category : #position }
PLC_BlockMorph >> position: aPoint [
	"Establece la posicion en pantalla del elemento. 
	En el caso de los contactos y bobinas además reacomoda su variable asociada."
	
	super position: aPoint.
	
	
	"Actualizo la posicion en pantalla de sus dependientes"
	
	self instanceVariable
		ifNotNil: [
			self instanceVariable alignCenteredAbove: self.
			].
]

{ #category : #building }
PLC_BlockMorph >> positionHorizontallyFormalParameters [
	"Posiciona horizontalmente los Formal Parameters del bloque."

	"Posiciono horizontalmente los Formal Parameter de entradas"

	self inputFormalParameters do: [ :formalParameter |
		formalParameter left: self left.
		].

	"Posiciono horizontalmente los Formal Parameter de salidas"
	
	self outputFormalParameters do: [ :formalParameter |
		formalParameter right: self right.
		].
]

{ #category : #building }
PLC_BlockMorph >> positionVerticallyFormalParameters [
	"Posiciona verticalmente los Formal Parameters. 
	Es la posición inicial cuando se crea el bloque."
	
	| formalParameter formalParameterTop |
	
	"Posiciono verticalmente los Formal Parameter de entradas"
	
	formalParameterTop := self bodyTop.

	( 1 to: self inputFormalParameters size ) do: [ :idx |
		
		"Obtengo el inputFormalParameter"
		formalParameter := self inputFormalParameters at: idx.
		
		"Establezco su posicion Vertical"
		formalParameter top: formalParameterTop. 
		
		"Guardo la próxima posicion Vertical"
		formalParameterTop := formalParameter bottom.
		
		].
	
	"Posiciono verticalmente los Formal Parameter de salidas"
	
	formalParameterTop := self bodyTop.

	( 1 to: self outputFormalParameters size ) do: [ :idx |
		
		"Obtengo el inputFormalParameter"
		formalParameter := self outputFormalParameters at: idx.
		
		"Establezco su posicion Vertical"
		formalParameter top: formalParameterTop. 
		
		( formalParameter inOutFPAssociated )
			ifNotNil: [ 
				formalParameter inOutFPAssociated updateInputInOutFPAssociatedVerticalPosition.
				] .
		
		"Guardo la próxima posicion Vertical"
		formalParameterTop := formalParameter bottom.
		
		].
]

{ #category : #'commands recive from ladder view' }
PLC_BlockMorph >> removeElementFrom: aLadderView [
	"Remueve el elemento pidiendoselo a su ladder view. Hace un double dispatching con este"
	
	aLadderView removeFunctionCall: self.
]

{ #category : #'connection states layer 1' }
PLC_BlockMorph >> rightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"

	self connectionStateLayer1 rightConnectedToVerticalLinkFor: self.
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> rightConnectedToVerticalLinkLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent + (self properties scale * ( 200 @ 0 ) ). " 200 = (self gridExtent x * 2) + 8 "
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> rightConnectedToVerticalLinkLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."

	^ self properties scale * ( -102 @ 0 ). " -102 = -self gridExtent x - 6 "
]

{ #category : #'user interaction states' }
PLC_BlockMorph >> selected [
	"Estado seleccionado."

	self userInteractionStateLayer1: PLC_GraphicElementState selected.
	
	self submorphsPerform: #selected.
	
	self inputPins do: [ :each |
		each unselected.
		].
	
	self outputPins do: [ :each |
		each unselected.
		].
	
	self changed.
]

{ #category : #extent }
PLC_BlockMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self extent.
]

{ #category : #layout }
PLC_BlockMorph >> updateConnectedMorphsAlignStates [
	"Actualiza los estados de alineación de sus Actual Arguments."
	
	| inputGraphicElement outputGraphicElement |
	
	( 2 to: self inputPins size ) do: [ :index | 
		
		"Busco el elemento conectado a la entrada número index"		
		inputGraphicElement := self blockConnectedToInput: index.
		
		"Cambio su estado a alineado a derecha"
		inputGraphicElement rightAlign.
		
		].
	
	( 2 to: self outputPins size ) do: [ :index | 
		
		"Busco el elemento conectado a la entrada número index"		
		outputGraphicElement := self blockConnectedToOutput: index.
		
		"Cambio su estado a alineado a izquierda"
		outputGraphicElement leftAlign.
		
		].
]

{ #category : #'connection states' }
PLC_BlockMorph >> updateOutputsConnectonStates [
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	
	| outputGraphicElement |
		
	"Busco el elemento grafico conectado a la salida numero 1"
	outputGraphicElement := self blockConnectedToOutput: 1.
	
	"Cambio el estado de conexion de capa 2 al que traiga el elemento actual"
	outputGraphicElement connectionStateLayer2: self connectionStateLayer2.
	outputGraphicElement changed.
		
	"El estado de conexion de capa 1 es conectado a self"
	outputGraphicElement connectedToBlock.
	
	"Actualiza las capas de estado de conexion de los elementos conectados a sus salidas."
	outputGraphicElement updateOutputsConnectonStates.
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> voidLayoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent + (self properties scale * ( 204 @ 0 ) ). " 204 = (self gridExtent x * 2) + 12 "
]

{ #category : #'commands recive from connection states' }
PLC_BlockMorph >> voidLayoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -102 @ 0 ). " -102 = -self gridExtent x - 6 "
]
