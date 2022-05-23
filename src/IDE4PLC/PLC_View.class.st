"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_View is xxxxxxxxx.

Instance Variables
	controller:		<Object>
	editor:		<Object>
	elements:		<Object>
	keyboardFocusElement:		<Object>
	selectedElements:		<Object>
	uiContext:		<Object>
	unselectedElements:		<Object>

controller
	- xxxxx

editor
	- xxxxx

elements
	- xxxxx

keyboardFocusElement
	- xxxxx

selectedElements
	- xxxxx

uiContext
	- xxxxx

unselectedElements
	- xxxxx

"
Class {
	#name : #'PLC_View',
	#superclass : #BorderedMorph,
	#instVars : [
		'controller',
		'elements',
		'selectedElements',
		'unselectedElements',
		'keyboardFocusElement',
		'uiContext',
		'editor'
	],
	#category : #'IDE4PLC-Networks'
}

{ #category : #'event handling' }
PLC_View >> aboutToBeGrabbedBy: aHand [ 
	"Este mensaje llega cuando está a punto de ser agarrado por el puntero del mouse (HandMorph)."
	
	super aboutToBeGrabbedBy: aHand.
	self stopStepping.	

]

{ #category : #'elements in screen directions' }
PLC_View >> aboveMorphFor: aPLC_GraphicElementMorph [
	"Devuelve el Morph de arriba del morph pasado como parámetro"

	| startPoint stopPoint result distance |
	
	result := nil.
	
	startPoint := aPLC_GraphicElementMorph topCenter.
	stopPoint := startPoint x @  self top.
	
	distance := startPoint y - stopPoint y.
	
"	Transcript show: startPoint asString , ' ' ,  stopPoint asString ,  ' ' , distance asString , '
	
	'."
	
	1 to: distance do: [ :index | | col |
"		Transcript show: ( startPoint - ( 0 @ index ) ) asString , '
		'."
		col := (self submorphs select: [ :each | each containsPoint: startPoint - ( 0 @ index ) ]).
"		Transcript show: col."
		col ifNotEmpty:	[ ^ col first].
		].
	
	result ifNil: [^ aPLC_GraphicElementMorph ].
	
	

]

{ #category : #'commands send to self' }
PLC_View >> addSelectedAndKeyboardFocus: aPLC_GraphicElementMorph [
	"Añade el elemento a la lista de seleccionados y le da el foco del teclado."
	
	(self unselectedElements includes: aPLC_GraphicElementMorph)
		ifTrue: [
			self unselectedElements remove: aPLC_GraphicElementMorph.	
			].	
	
	(self selectedElements includes: aPLC_GraphicElementMorph)
		ifFalse: [
			self selectedElements add: aPLC_GraphicElementMorph.	
			].

	self selectedElements do: [ :each |
		each selected;
			notKeyboardFocus.
		].
	
	self keyboardFocusElement: aPLC_GraphicElementMorph.
	aPLC_GraphicElementMorph keyboardFocus.
]

{ #category : #'elements in screen directions' }
PLC_View >> beneathMorphFor: aPLC_GraphicElementMorph [
	"Devuelve el Morph de abajo del morph pasado como parámetro"

	| startPoint stopPoint result distance |
	
	result := nil.
	
	startPoint := aPLC_GraphicElementMorph bottomCenter.
	stopPoint := startPoint x @  self bottom.
	
	distance := stopPoint y - startPoint y.
	
	"Transcript show: startPoint asString , ' ' ,  stopPoint asString ,  ' ' , distance asString , '
	
	'."
	
	1 to: distance do: [ :index | | col |
"		Transcript show: ( startPoint + ( 0 @ index ) ) asString , '
		'."
		col := (self submorphs select: [ :each | each containsPoint: startPoint + ( 0 @ index ) ]).
		"Transcript show: col."
		col ifNotEmpty:	[ ^ col first].
		].
	
	result ifNil: [^ aPLC_GraphicElementMorph ].
	
	

]

{ #category : #extent }
PLC_View >> bottomOfGraphicElementBelowOfAll [
	"Devuelve el bottom del layoutRectangle del elemento mas abajo en pantalla dentro del ladderView"

	^ self elements keys 
		inject: 0
		into: [:resParcial :elem | 
			resParcial max: elem layoutRectangle bottom].
]

{ #category : #'commands send to controller' }
PLC_View >> commandCopy [
	"Este mensaje se dispara cuando presionan las teclas Ctrl + C."
		
	Transcript show: 'COPY
'.
	
]

{ #category : #'commands send to controller' }
PLC_View >> commandPaste [
	"Este mensaje se dispara cuando presionan las teclas Ctrl + C."
		
	Transcript show: 'PASTE
'.
	
]

{ #category : #accessing }
PLC_View >> controller [
	
	^ controller
]

{ #category : #accessing }
PLC_View >> controller: anObject [
	
	controller := anObject
]

{ #category : #extent }
PLC_View >> defaultExtent [

	^ 10@10.
]

{ #category : #submorphs }
PLC_View >> dragRectangle [
	"Devuelve un Rectangle de 288@168 alrededor de la posicion actual del puntero del mouse.
	El cual es irtersecado con el área de la network para que no se pase para los costados."

	| center origin corner|
	
	center := World activeHand cursorPoint.
	
	origin := center - (144@84).
	corner := center + (144@84).
	
	^ (Rectangle origin: origin corner: corner) intersect: self bounds.

	
]

{ #category : #accessing }
PLC_View >> editor [
	
	^ editor
]

{ #category : #accessing }
PLC_View >> editor: anObject [
	
	editor := anObject
]

{ #category : #'commands send to self' }
PLC_View >> editorKeyBoradFocus [
	"Avisa a su owner que le dieron el foco del teclado."
	
	self editor ifNotNil: [ 
		"Le saco el foco del teclado a la network que lo tenia"
		( self editor keyboardFocusMorph == self  )
			ifFalse: [ 
				self editor keyboardFocusMorph lostKeyboardFocus.
				self selectedElements do: [ :each |
					each draggingAnother.
					].					
				 ].
		"Le doy el foco del reclado a esta"
		self editor keyboardFocusMorph: self.
		].
	
	

]

{ #category : #accessing }
PLC_View >> elements [
	^ elements
]

{ #category : #accessing }
PLC_View >> elements: anObject [
	elements := anObject
]

{ #category : #extent }
PLC_View >> extentChanged [

	self extent: self totalExtent.
]

{ #category : #'commands send to self' }
PLC_View >> gotKeyboardFocus [
	"Evento cuando el ladderView le dan el foco del teclado."
	
	self borderColor: PLC_GraphicElementProperties uniqueInstance rowColorSelected.
	self changed.

	self selectedElements do: [ :each |
		each selected.
		].
	
	self editorKeyBoradFocus.
]

{ #category : #'event handling' }
PLC_View >> handleKeystroke: anEvent [
	"Manejador del evento de teclado."
	
	"anEvent hand newKeyboardFocus: self. " "Le doy al morph el foco del teclado."
	"anEvent hand newKeyboardFocus: nil." "Le saco al morph el foco del teclado."

	"anEvent shiftPressed ifTrue: [Transcript show:  keyValue.] ." "Detecta si la tecla Shift esta presionada durante el evento"
	"anEvent commandKeyPressed ifTrue: [ self color: Color blue.] ." "Detecta si la tecla Control esta presionada durante el evento"

	| keyValue |

	keyValue := anEvent keyValue.
	
	Transcript show: anEvent asString , ' ' , keyValue asString  , '
'.

	keyValue = 127 "delete"
		ifTrue: [ self keyDeletePressed. ].
		
	keyValue = 111 "O"
		ifTrue: [ self keyOPressed. ].
		
	keyValue = 112 "P"
		ifTrue: [ self keyPPressed. ].


	keyValue = 99 "c"
		ifTrue: [ 
			anEvent commandKeyPressed "Detecta la tecla control del teclado"
				ifTrue: [self commandCopy] 
				ifFalse: [self keyCPressed] 
			]. 
		
	keyValue = 118 "v"
		ifTrue: [ 
			anEvent commandKeyPressed 
				ifTrue: [self commandPaste] 
				ifFalse: [self keyVPressed] 
			].  
		
	keyValue = 98 "b"
		ifTrue: [ self keyBPressed. ].
		
	keyValue = 110 "n"
		ifTrue: [ self keyNPressed. ].

	keyValue = 30 "up arrow"
		ifTrue: [self keyUpPressed. ].
		
	keyValue = 31 "down arrow"
		ifTrue: [self keyDownPressed. ].
	
	keyValue = 29 "right arrow"
		ifTrue: [self keyRightPressed. ].

	keyValue = 28 "left arrow"
		ifTrue: [self keyLeftPressed. ].
]

{ #category : #'event handling' }
PLC_View >> handlesMouseDown: anEvent [
	"Permite manejar el evento de cuando el usuatio clickea el mouse sobre el morph."

	^ true.
]

{ #category : #'event handling' }
PLC_View >> handlesMouseOver: anEvent [
	"Permite manejar el evento de cuando el usuatio pasa el puntero del  mouse sobre el morph."

	^ true.
]

{ #category : #'event handling' }
PLC_View >> handlesMouseOverDragging: anEvent [
	"Permite manejar el evento de cuando el usuatio clickea el mouse sobre el morph."

	^ true.
]

{ #category : #'initialize-release' }
PLC_View >> initialize [
	"comment stating purpose of message"

	super initialize. "Siempre hay que hacerlo en una subclase de MORPH"
	
	"Cambio el tamaño y color"
	self extent: self defaultExtent.
	self color: Color white.
	self borderColor: Color white.
	self borderWidth: 2.
		
	"Abro"
	self openInWorld.

]

{ #category : #'event handling' }
PLC_View >> justDroppedInto: aMorph event: anEvent [
	"Recien soltado dentro de aMorph"
	
	self stopStepping.

]

{ #category : #'keyboard events' }
PLC_View >> keyDeletePressed [
	"Este mensaje se dispara cuando presionan la tecla Suprimir."

	self removeSelectedElements.
]

{ #category : #'keyboard events' }
PLC_View >> keyDownPressed [
	"Este mensaje se dispara cuando presionan la tecla Down Arrow."
		
	| newKeyboardFocusElement |
	
	newKeyboardFocusElement := self beneathMorphFor: self keyboardFocusElement.
	
	self unselectAll.
	self selectedAndKeyboardFocus: newKeyboardFocusElement.
	
	"self networkMorph position: self networkMorph position + (0 @ 1)."
	
]

{ #category : #'keyboard events' }
PLC_View >> keyLeftPressed [
	"Este mensaje se dispara cuando presionan la tecla Left Arrow."
	
	| newKeyboardFocusElement |
	
	newKeyboardFocusElement := self leftMorphFor: self keyboardFocusElement.
	
	self unselectAll.
	self selectedAndKeyboardFocus: newKeyboardFocusElement.
	
	"networkMorph position: self networkMorph position - (1 @ 0)."
]

{ #category : #'keyboard events' }
PLC_View >> keyRightPressed [
	"Este mensaje se dispara cuando presionan la tecla Right Arrow."
	
	| newKeyboardFocusElement |
	
	newKeyboardFocusElement := self rightMorphFor: self keyboardFocusElement.
	
	self unselectAll.
	self selectedAndKeyboardFocus: newKeyboardFocusElement.
	
	"self networkMorph position: self networkMorph position + (1 @ 0)."
	
]

{ #category : #'keyboard events' }
PLC_View >> keyUpPressed [
	"Este mensaje se dispara cuando presionan la tecla Up Arrow."
	
	| newKeyboardFocusElement |
	
	newKeyboardFocusElement := self aboveMorphFor: self keyboardFocusElement.
	
	self unselectAll.
	self selectedAndKeyboardFocus: newKeyboardFocusElement.
	
	"self networkMorph position: self networkMorph position - (0 @ 1)."
	
]

{ #category : #accessing }
PLC_View >> keyboardFocusElement [
	^ keyboardFocusElement
]

{ #category : #accessing }
PLC_View >> keyboardFocusElement: anObject [
	keyboardFocusElement := anObject
]

{ #category : #'mouse events' }
PLC_View >> leftClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
		
	| submorphUnderCursor |	
		
	anEvent hand newKeyboardFocus: self. "Le doy al Network Morph el foco del teclado."
	self gotKeyboardFocus.

	submorphUnderCursor := self submorphUnderCursor: anEvent.
	
	"self lostKeyboardFocus."

	submorphUnderCursor
		ifNil: [
			anEvent shiftPressed 
				ifTrue: [

					]
				ifFalse: [
					self unselectAll.	 "Pasa todos a la lista de deseleccionados y actualiza los estados de los elementos graficos."					
					].				
			] 
		ifNotNil: [
			anEvent shiftPressed 
				ifTrue: [
					self addSelectedAndKeyboardFocus: submorphUnderCursor.
					]
				ifFalse: [
					self unselectAll.	 "Pasa todos a la lista de deseleccionados y actualiza los estados de los elementos graficos."
					self selectedAndKeyboardFocus: submorphUnderCursor.					
					].		
			]. 
		
	self changed.

]

{ #category : #'mouse events' }
PLC_View >> leftDoubleClick: anEvent [
	"Manejador del evento doble click con el boton izquierdo del mouse"
	"(doubleClick) sent when the mouse goes up, down, and up again all within DoubleClickTime."

	| submorphUnderCursor |		
			
	anEvent hand newKeyboardFocus: self. "Le doy al Network Morph el foco del teclado."
	self gotKeyboardFocus.
	
	submorphUnderCursor := self submorphUnderCursor: anEvent.
	
	self keyboardFocusElement lostKeyboardFocus.
	self unselectAll.	 "Pasa todos a la lista de deseleccionados y actualiza los estados de los elementos graficos."
		
	submorphUnderCursor
		ifNil: [
			] 
		ifNotNil: [
			self selectedAndKeyboardFocus: submorphUnderCursor.
			self selectedElements first changeFunction: anEvent.
			]. 
		
	self changed.
]

{ #category : #'mouse events' }
PLC_View >> leftDoubleClickTimeout: anEvent [
	"Manejador del evento doble click timeout con el boton izquierdo del mouse"
	"(doubleClickTimeout) sent when the mouse does not have a doubleClick within DoubleClickTime."

"	self networkController leftDoubleClickTimeout: anEvent."
]

{ #category : #'elements in screen directions' }
PLC_View >> leftMorphFor: aPLC_GraphicElementMorph [
	"Devuelve el Morph a la izquieda del morph pasado como parámetro"

	| startPoint stopPoint result distance |
	
	result := nil.
	
	startPoint := aPLC_GraphicElementMorph leftCenter.
	stopPoint := (self left) @ startPoint y.
	
	distance := startPoint x - stopPoint x.
	
"	Transcript show: startPoint asString , ' ' ,  stopPoint asString , '
	
	'."
	
	1 to: distance do: [ :index | | col |
		"Transcript show: (startPoint - ( index @ 0 )) asString , ' '"
		col := (self submorphs select: [ :each | each containsPoint: startPoint - ( index @ 0 ) ]).
		"Transcript show: col."
		col ifNotEmpty:	[ ^ col first].
		].
	
	result ifNil: [^ aPLC_GraphicElementMorph ].
	
	

]

{ #category : #'commands send to self' }
PLC_View >> lostKeyboardFocus [
	"Evento cuando el ladderView pierde el foco del teclado."
	
	self borderColor: Color white.
	
	self selectedElements do: [ :each |
		each draggingAnother.
		].
]

{ #category : #'event handling' }
PLC_View >> mouseDown: anEvent [
	"Manejador del evento mouse down"
	"Do nothing upon mouse-down except inform the hand to watch for a double-click; wait until an 
	ensuing click:, doubleClick:, or drag: message gets dispatched"

	"Note that mouseMove: and mouseUp: events are not sent to aMorph until it becomes the mouse focus,
	which is typically done by aMorph in its click:, doubleClick:, or drag: methods."
	
	anEvent redButtonPressed "click"
		ifTrue: [
			anEvent hand
				waitForClicksOrDrag: self
				event: anEvent
				selectors: {#leftClick:. #leftDoubleClick:. #leftDoubleClickTimeout:. #startDrag:.}
				threshold: 5.				
				].	
		
	anEvent yellowButtonPressed "action-click"
		ifTrue: [
			anEvent hand
				waitForClicksOrDrag: self
				event: anEvent
				selectors: {#rightClick:. #rightDoubleClick:. #rightDoubleClickTimeout:. nil.}
				threshold: 5.
			].
]

{ #category : #'event handling' }
PLC_View >> mouseEnter: anEvent [
	"Manejador del evento mouse up"
	
	self stopStepping.
]

{ #category : #'event handling' }
PLC_View >> mouseEnterDragging: anEvent [
	"Manejador del evento mouse up"
	
	self startStepping.
	
	"Para caundo el morph bajo el que este arrastrando el cursor pueda ser el mismo Network"
	"anEvent hand submorphsDo: [ :subm | 
		subm == self 
			ifFalse: [
				self startStepping.
				].
		]."
]

{ #category : #'event handling' }
PLC_View >> mouseLeave: anEvent [
	"Manejador del evento mouse up"
	
	self stopStepping.
]

{ #category : #'event handling' }
PLC_View >> mouseLeaveDragging: anEvent [
	"Manejador del evento mouse up"

	self unselectAll.
	self stopStepping.
]

{ #category : #'event handling' }
PLC_View >> mouseMove: anEvent [
	"Manejador del evento mouse move. Este evento ocurre cuando se 
	presiona el mouse y se arrastra presionado sobre el morph."

"	anEvent redButtonPressed 
		ifTrue: [self color: Color white.].
		
	anEvent yellowButtonPressed 
		ifTrue: [self color: Color black].

	self changed."
]

{ #category : #'event handling' }
PLC_View >> mouseUp: anEvent [
	"Manejador del evento mouse up"

	self stopStepping. "Ver......"
]

{ #category : #properties }
PLC_View >> properties [
	"Devuelve la unica instancia de la clase PLC_GraphicElementProperties"

	^ PLC_GraphicElementProperties uniqueInstance.
]

{ #category : #loop }
PLC_View >> refresh [
	"Refresca la vista la vista"

	"Hago la vista invisible durante todo el proceso de dibujado"
	"self visible: false."
	
	"Guardo los bloques conectables de los elementos morph 
	seleccionados y del elemento morph con foco del teclado."
	"self saveUIContext." "ANDA MAL"	
	
	"Remuevo todos los submorphs"
	self removeAllMorphs.
	
	"Inicializo el diccionario elements que contiene asociaciones 
	graphicElement --> connectableBlock "
	self elements: Dictionary new.
	
	"Inicializo las Colecciones"
	self unselectedElements: OrderedCollection new.
	self selectedElements: OrderedCollection new.
	self keyboardFocusElement: self.
]

{ #category : #'event handling' }
PLC_View >> rejectDropMorphEvent: anEvent [
	"Manejador del evento mouse up"
	
	self unselectAll.	"Ver..."
]

{ #category : #'commands send to controller' }
PLC_View >> removeSelectedElements [
	"Remueve todos los elementos seleccionados."
	
	"Remuevo todos los elementos seleccionados"
	"SE JODE PORQUE CAMBIAN LOS ELEMENTOS AL BORRAR EL PRIMERO"
	"self selectedElements do: [ :elem |	
		elem removeElementFrom: self.
		]."
	
	"Parche momentaneo, solo borro el primero de los seleccionados"
	(self selectedElements size > 0 )
		ifTrue: [
			self selectedElements first removeElementFrom: self.
			].
]

{ #category : #'event handling' }
PLC_View >> repelsMorph: aMorph event: anEvent [
	"Devuelve un booleano"

	self stopStepping.
	(self submorphs) do: [:submorph | submorph unselected.]. 

	^(self wantsDroppedMorph: aMorph event: anEvent) not.
]

{ #category : #'mouse events' }
PLC_View >> rightClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
	
"	self networkController rightClick: anEvent."
]

{ #category : #'mouse events' }
PLC_View >> rightDoubleClick: anEvent [
	"Manejador del evento doble click con el boton izquierdo del mouse"
	"(doubleClick) sent when the mouse goes up, down, and up again all within DoubleClickTime."
	
"	self networkController rightDoubleClick: anEvent."
]

{ #category : #'mouse events' }
PLC_View >> rightDoubleClickTimeout: anEvent [
	"Manejador del evento doble click timeout con el boton izquierdo del mouse"
	"(doubleClickTimeout) sent when the mouse does not have a doubleClick within DoubleClickTime."

"	self networkController rightDoubleClickTimeout: anEvent."
]

{ #category : #'elements in screen directions' }
PLC_View >> rightMorphFor: aPLC_GraphicElementMorph [
	"Devuelve el Morph a la derecha del morph pasado como parámetro"

	| startPoint stopPoint result distance |
	
	result := nil.
	
	startPoint := aPLC_GraphicElementMorph rightCenter.
	stopPoint := (self right) @ startPoint y.
	
	distance := stopPoint x - startPoint x.
	
"	Transcript show: startPoint asString , ' ' ,  stopPoint asString , '
	
	'."
	
	1 to: distance do: [ :index | | col |
		"Transcript show: (startPoint - ( index @ 0 )) asString , ' '"
		col := (self submorphs select: [ :each | each containsPoint: startPoint + ( index @ 0 ) ]).
		"Transcript show: col."
		col ifNotEmpty:	[ ^ col first].
		].
	
	result ifNil: [^ aPLC_GraphicElementMorph ].
	
	

]

{ #category : #extent }
PLC_View >> rightOfGraphicElementRightOfAll [
	"Devuelve el right del layoutRectangle del elemento mas a la derecha en pantalla dentro del ladderView"

	^ self elements keys 
		inject: 0
		into: [:resParcial :elem | 
			resParcial max: elem layoutRectangle right].
]

{ #category : #'commands send to self' }
PLC_View >> selectedAndKeyboardFocus: aPLC_GraphicElementMorph [
	"Añade el elemento a la lista de seleccionados. Borra los anteriores."
	
	self unselectAll.
	
	(self unselectedElements includes: aPLC_GraphicElementMorph)
		ifTrue: [
			self unselectedElements remove: aPLC_GraphicElementMorph.
			].		
	
	self selectedElements add: aPLC_GraphicElementMorph.	
	self keyboardFocusElement: aPLC_GraphicElementMorph.
	
	self unselectedElements do: [ :each |
		each notKeyboardFocus.		
		].
	
	aPLC_GraphicElementMorph
		selected;
		keyboardFocus.	
]

{ #category : #accessing }
PLC_View >> selectedElements [
	^ selectedElements
]

{ #category : #accessing }
PLC_View >> selectedElements: anObject [
	selectedElements := anObject
]

{ #category : #'mouse events' }
PLC_View >> startDrag: anEvent [
	"(startDrag) sent when the mouse moves more than threshold pixels 
	from evt's position within DoubleClickTime."	
	
"	self networkController startDrag: anEvent."
]

{ #category : #'event handling' }
PLC_View >> step [
	"accion cada vez que le llega el mensaje step"

	"self submorphsUnderDraggRectangle do: [:submorph | 
		submorph underDraggArea].
	
	self submorphsNotUnderDraggRectangle do: [:submorph | 
		submorph notUnderDraggArea]."

	
]

{ #category : #'event handling' }
PLC_View >> stepTime [
	"stepTime en ms"

	^ 100.
]

{ #category : #submorphs }
PLC_View >> submorphUnderCursor: anEvent [
	"Devuelve un submorph o nil."
	
	| collection |
	
	collection := self submorphsUnderCursor: anEvent.
	
	(collection size > 0)
		ifTrue: [
			^ collection first.
			]
		ifFalse: [
			^ nil.
			]
]

{ #category : #submorphs }
PLC_View >> submorphsNotUnderCursor: anEvent [
	"Devuelve una colección de submorphs Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
	
	| collection |
	
	collection := OrderedCollection new.
	
	self submorphsDo: [ :submorph | 
		(submorph containsPoint: anEvent cursorPoint)
			ifFalse: [ collection add: submorph.]
		].	
	^ collection.
]

{ #category : #submorphs }
PLC_View >> submorphsNotUnderDraggRectangle [
	"Devuelve una colección de submorphs  que estan bajo el área del DraggRectangle"
	
	| collection |
	
	collection := OrderedCollection new.
	
	self submorphsDo: [ :submorph | 
		(submorph bounds intersects: self dragRectangle)
			ifFalse: [ collection add: submorph.]
		].	
	^ collection.
]

{ #category : #submorphs }
PLC_View >> submorphsOn: aRectangle [
	"Devuelve una colección de submorphs  que estan bajo el área de aRectangle"
	
	| collection |
	
	collection := OrderedCollection new.
	
	self submorphsDo: [ :submorph | 
		(submorph bounds intersects: aRectangle)
			ifTrue: [ collection add: submorph.]
		].	
	^ collection.
]

{ #category : #submorphs }
PLC_View >> submorphsUnderCursor: anEvent [
	"Devuelve una colección de submorphs Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
	
	| collection |
	
	collection := OrderedCollection new.
	
	self submorphsDo: [ :submorph | 
		(submorph containsPoint: anEvent cursorPoint)
			ifTrue: [ collection add: submorph.]
		].	
	^ collection.
]

{ #category : #submorphs }
PLC_View >> submorphsUnderDraggRectangle [
	"Devuelve una colección de submorphs  que estan bajo el área del DraggRectangle"
	
	| collection |
	
	collection := OrderedCollection new.
	
	self submorphsDo: [ :submorph | 
		(submorph bounds intersects: self dragRectangle)
			ifTrue: [ collection add: submorph.]
		].	
	^ collection.
]

{ #category : #submorphs }
PLC_View >> submorphsUnselectAll [
	"Pasa todos sus submorphs al estado deseleccionado"

	self submorphs do: [:submorph | 
		submorph unselected].	
]

{ #category : #extent }
PLC_View >> totalExtent [

	^ ( self rightOfGraphicElementRightOfAll + self gridOrigin x ) @ ( self bottomOfGraphicElementBelowOfAll + self gridOrigin y ).
]

{ #category : #accessing }
PLC_View >> uiContext [
	
	^ uiContext
]

{ #category : #accessing }
PLC_View >> uiContext: anObject [
	
	uiContext := anObject
]

{ #category : #'commands send to self' }
PLC_View >> unselectAll [
	"Pasa todos los elementos a la Coleccion de deseleccionados y actualiza los estados de los elementos graficos."
	
	self selectedElements removeAll.
	self unselectedElements removeAll.
	
	self submorphs do: [ :each |
		self unselectedElements add: each.	
		].
		
	self unselectedElements do: [ :each |
		each unselected.
		].
]

{ #category : #accessing }
PLC_View >> unselectedElements [
	^ unselectedElements
]

{ #category : #accessing }
PLC_View >> unselectedElements: anObject [
	unselectedElements := anObject
]

{ #category : #'event handling' }
PLC_View >> wantsDroppedMorph: aMorph event: anEvent [

	self stopStepping.
	^  aMorph isKindOf: PLC_GraphicElementMorph. "Tiene que responder true si el morph es un elemento Ladder o FBD"
]
