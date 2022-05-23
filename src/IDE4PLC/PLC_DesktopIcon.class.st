"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_DesktopIcon is xxxxxxxxx.

Instance Variables
	action:		<Object>
	imagePath:		<Object>
	imagePathHover:		<Object>

action
	- xxxxx

imagePath
	- xxxxx

imagePathHover
	- xxxxx

"
Class {
	#name : #'PLC_DesktopIcon',
	#superclass : #ImageMorph,
	#instVars : [
		'imagePath',
		'imagePathHover',
		'action'
	],
	#classVars : [
		'InitialPosition',
		'Theme',
		'library',
		'pou',
		'project'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'class variables' }
PLC_DesktopIcon class >> blackTheme [
	"Cambia el Tema a tema negro"
	
	Theme := 'black'.
]

{ #category : #'class variables' }
PLC_DesktopIcon class >> blueTheme [
	"Cambia el Tema a tema azul"
	
	Theme := 'blue'.
]

{ #category : #'instance creation' }
PLC_DesktopIcon class >> createIcons [
	"Crea todos los Iconos"
	
	project := self projectIcon.
	pou := self pouIcon.
	library := self pouLibraryIcon.
	
]

{ #category : #'class variables' }
PLC_DesktopIcon class >> library [ 

	^ library 

]

{ #category : #'class variables' }
PLC_DesktopIcon class >> pou [ 

	^ pou
]

{ #category : #'instance creation' }
PLC_DesktopIcon class >> pouIcon [
	"Devuelve un nuevo DesktopIcon de Crear POU"
	
	| icon pouEditor |
		
	icon := PLC_DesktopIcon new.
	icon imagePath: icon desktopIconsPath , 'POU.png'.
	icon imagePathHover: icon desktopIconsPath , 'POU_hover_' , Theme , '.png'.
	icon mouseOut.
	icon position: InitialPosition + (130@0). 
	
	
	"Creo un nuevo editor de POU"
	pouEditor := PLC_POU_Editor 
		newWithPOU: PLeriC pou
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance programColor 
		andTitleName: 'POU: PROGRAMA'.	

	
	"ACA LE PASO A AQUIEN LE DICE OPEN"
	icon action: pouEditor.	

	^ icon.
]

{ #category : #'instance creation' }
PLC_DesktopIcon class >> pouLibraryIcon [
	"Devuelve un nuevo DesktopIcon de Biblioteca de POUs"
	
	| icon |
		
	icon := PLC_DesktopIcon new.
	icon imagePath: icon desktopIconsPath , 'POULibrary.png'.
	icon imagePathHover: icon desktopIconsPath , 'POULibrary_hover_' , Theme , '.png'.
	icon mouseOut.
	icon position: InitialPosition + (260@0). 
	

	"ACA LE PASO A AQUIEN LE DICE OPEN -  
	Con open PLeriC resetea la declaracion de programa"
	icon action: PLeriC.

	^ icon.
]

{ #category : #'class variables' }
PLC_DesktopIcon class >> project [ 

	^ project 
]

{ #category : #'instance creation' }
PLC_DesktopIcon class >> projectIcon [
	"Devuelve un nuevo DesktopIcon de Proyecto"
	
	| icon |
		
	icon := PLC_ProIcon new.
	icon imagePath: icon desktopIconsPath , 'Project.png'.
	icon imagePathHover: icon desktopIconsPath , 'Project_hover_' , Theme , '.png'.
	icon mouseOut.
	icon position: InitialPosition.
	
	^ icon.
	
	"Devuelve un nuevo DesktopIcon de Crear POU"
	
"	| icon pouEditor |
		
	icon := PLC_DesktopIcon new.
	icon imagePath: 'POU.png'.
	icon imagePathHover: 'POU_hover_' , Theme , '.png'.
	icon mouseOut.
	icon position: InitialPosition + (130@0). 
	"
	
	"Creo un nuevo editor de POU"
"	pouEditor := PLC_POU_Editor 
		newWithPOU: PLeriC pou
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance programColor 
		andTitleName: 'POU: PROGRAMA'.	"

	
	"ACA LE PASO A AQUIEN LE DICE OPEN"
"	icon action: pouEditor.	

	^ icon."
]

{ #category : #'class variables' }
PLC_DesktopIcon class >> screen1920x1080 [
	"Indica la posicion de los iconos cuando la pantalla es de 1920x1080 px"
	
	InitialPosition := 20@20. 
]

{ #category : #'class variables' }
PLC_DesktopIcon class >> screen800x600 [
	"Indica la posicion de los iconos cuando la pantalla es de 800 x600 px"
	
	InitialPosition := 83@200. 
]

{ #category : #accessing }
PLC_DesktopIcon >> action [
	^ action
]

{ #category : #accessing }
PLC_DesktopIcon >> action: anObject [
	action := anObject
]

{ #category : #'initialize-release' }
PLC_DesktopIcon >> desktopIconsPath [
	"Devuelve el path de imagenes"

	^ 'IDE4PLC_files/GUI_Images/desktopIcons/'
]

{ #category : #'event handling' }
PLC_DesktopIcon >> handlesMouseDown: anEvent [
	"Permite manejar el evento de cuando el usuatio clickea el mouse sobre el morph."

	^ true.
]

{ #category : #'event handling' }
PLC_DesktopIcon >> handlesMouseOver: anEvent [
	"Permite manejar el evento de que el puntero pasa sobre el morph."

	^true.
]

{ #category : #accessing }
PLC_DesktopIcon >> imagePath [
	^ imagePath
]

{ #category : #accessing }
PLC_DesktopIcon >> imagePath: anObject [
	imagePath := anObject
]

{ #category : #accessing }
PLC_DesktopIcon >> imagePathHover [
	^ imagePathHover
]

{ #category : #accessing }
PLC_DesktopIcon >> imagePathHover: anObject [
	imagePathHover := anObject
]

{ #category : #'initialize-release' }
PLC_DesktopIcon >> initialize [
	"Inicialización del ícono"

	super initialize.
	
	self imagePath: self desktopIconsPath , 'Project.png'.
	self imagePathHover: self desktopIconsPath , 'Project_hover_blue.png'.
	
	
	self image: ( Form fromFileNamed: self imagePath ).
	
	self openInWorld.
]

{ #category : #'mouse events' }
PLC_DesktopIcon >> leftClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
		
	self action open.
]

{ #category : #'mouse events' }
PLC_DesktopIcon >> leftDoubleClick: anEvent [
	"Manejador del evento doble click con el boton izquierdo del mouse"
	"(doubleClick) sent when the mouse goes up, down, and up again all within DoubleClickTime."

]

{ #category : #'mouse events' }
PLC_DesktopIcon >> leftDoubleClickTimeout: anEvent [
	"Manejador del evento doble click timeout con el boton izquierdo del mouse"
	"(doubleClickTimeout) sent when the mouse does not have a doubleClick within DoubleClickTime."



]

{ #category : #'event handling' }
PLC_DesktopIcon >> mouseDown: anEvent [
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
PLC_DesktopIcon >> mouseEnter: anEvent [
	"Manejador del evento mouse enter. Este mensaje se le envia al 
	morph cuando el puntero del mouse empieza a pasar por el."

	self mouseOver.
]

{ #category : #'event handling' }
PLC_DesktopIcon >> mouseLeave: anEvent [
	"Manejador del evento mouse leave. Este mensaje se le envia al 
	morph cuando el puntero del mouse deja de pasarpor el."

	self mouseOut.
]

{ #category : #'mouse events' }
PLC_DesktopIcon >> mouseOut [
	"Cuando el mouse está fuera del ícono cambia su imagen"

	self image: ( Form fromFileNamed: self imagePath ).
]

{ #category : #'mouse events' }
PLC_DesktopIcon >> mouseOver [
	"Cuando el mouse está sobre el ícono cambia su imagen"

	self image: ( Form fromFileNamed: self imagePathHover ).
]

{ #category : #'event handling' }
PLC_DesktopIcon >> mouseUp: anEvent [
	"Manejador del evento mouse up"
	
	
]

{ #category : #'mouse events' }
PLC_DesktopIcon >> rightClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."

]

{ #category : #'mouse events' }
PLC_DesktopIcon >> rightDoubleClick: anEvent [
	"Manejador del evento doble click con el boton izquierdo del mouse"
	"(doubleClick) sent when the mouse goes up, down, and up again all within DoubleClickTime."
	


]

{ #category : #'mouse events' }
PLC_DesktopIcon >> rightDoubleClickTimeout: anEvent [
	"Manejador del evento doble click timeout con el boton izquierdo del mouse"
	"(doubleClickTimeout) sent when the mouse does not have a doubleClick within DoubleClickTime."



]

{ #category : #'mouse events' }
PLC_DesktopIcon >> startDrag: anEvent [
	"Manejador del evento doble click timeout con el boton izquierdo del mouse"
	"(startDrag) sent when the mouse moves more than threshold pixels from evt's position within DoubleClickTime."	
	
	anEvent hand grabMorph: self
]
