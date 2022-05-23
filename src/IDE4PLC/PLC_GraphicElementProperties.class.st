"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicElementProperties is xxxxxxxxx.

Instance Variables
	drawBounds:		<Object>
	drawGrid:		<Object>
	drawLayoutRectangle:		<Object>
	drawTextLineBorder:		<Object>
	scale:		<Object>

drawBounds
	- xxxxx

drawGrid
	- xxxxx

drawLayoutRectangle
	- xxxxx

drawTextLineBorder
	- xxxxx

scale
	- xxxxx

"
Class {
	#name : #'PLC_GraphicElementProperties',
	#superclass : #Object,
	#instVars : [
		'scale',
		'drawLayoutRectangle',
		'drawBounds',
		'drawGrid',
		'drawTextLineBorder'
	],
	#classVars : [
		'Instance'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_GraphicElementProperties class >> clearInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNotNil: 
		[
		Instance := nil.
		].
]

{ #category : #'instance creation' }
PLC_GraphicElementProperties class >> uniqueInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNil: 
		[
		Instance := PLC_GraphicElementProperties new.
		].
	
	^ Instance.
]

{ #category : #textColors }
PLC_GraphicElementProperties >> actualValueAddressColor [
	"Color de la dirección de memoria de las variables no simbólicas."

	^Color r: 0 g: 153/255 b: 153/255. " (Color r: 0.0 g: 0.6 b: 0.6)"

]

{ #category : #textColors }
PLC_GraphicElementProperties >> actualValueErrorColor [
	"Color de variable (actual value) con error."

	^Color red.

]

{ #category : #textColors }
PLC_GraphicElementProperties >> actualValueLiteralColor [
	"Color de variable (actual value) cuando se le ingresa un literal"

	^Color r: 51/255 g: 102/255 b: 211/255. " (Color r: 0.2 g: 0.4 b: 0.827)"
]

{ #category : #textColors }
PLC_GraphicElementProperties >> actualValueNotDefinedColor [
	"Color de variable (actual value) no definida"

	^Color r: 1 g: 37/255 b: 87/255. " (Color r: 1.0 g: 0.145 b: 0.341)"

]

{ #category : #otherColors }
PLC_GraphicElementProperties >> booleanVariablePinColor [
	 "Es el pin que solo acepta variables booleanas."

	^Color black.
]

{ #category : #styles }
PLC_GraphicElementProperties >> centerUnderlineStyleWithColor: aColor andOrigin: anOrigin andDirection: aDirection [
	"Estilo del Morph subrrayado de la etiqueta. Tiene un color degradado."
	
	^ (GradientFillStyle 	ramp: { 
		0.0 -> aColor.
		0.5 -> Color white.
		1.0 -> aColor. })
			origin: anOrigin;
			direction: aDirection;
			normal: 0@400;
			radial: false.	
]

{ #category : #otherColors }
PLC_GraphicElementProperties >> changeFunctionColor [
	"Color del triangulito para cambiar la funcion o tipo de dato."

	^Color yellow. 

]

{ #category : #otherColors }
PLC_GraphicElementProperties >> dashBorderColor1 [
	 "Color dash oscuro"

	^Color r: 128/255 g: 128/255 b: 128/255. "Color r: 0.502 g: 0.502 b: 0.502"
]

{ #category : #otherColors }
PLC_GraphicElementProperties >> dashBorderColor2 [
	 "Color dash claro"

	^Color r: 61/255 g: 69/255 b: 89/255. "Color r: 0.239 g: 0.271 b: 0.349)"
]

{ #category : #styles }
PLC_GraphicElementProperties >> dashBorderSize [
	"Espesor del borde de linea guionada"
	
	^ 1.
]

{ #category : #styles }
PLC_GraphicElementProperties >> dashColors [
	"Colores de la linea guionada"
	
	^ {	self dashBorderColor1. 
		self dashBorderColor2.}
]

{ #category : #styles }
PLC_GraphicElementProperties >> dashLengths [
	"Longitudes de los guiones de la linea guionada"
	
	^ #(1 1). 
]

{ #category : #draggingAnotherColors }
PLC_GraphicElementProperties >> draggingAnotherBackgroundColor [
	"Color de fondo de contactos, bobinas y de variables (actual value).
	Se aplica cuando estaba seleccionado y el mouse está arrastrando a otro elemento."

	^Color r: 136/255 g: 143/255 b: 158/255. "Color r: 0.534 g: 0.561 b: 0.62"
]

{ #category : #draggingAnotherColors }
PLC_GraphicElementProperties >> draggingAnotherBlockBodyColor [
	"Color de cuerpo del bloque.
	Se aplica cuando estaba seleccionado y el mouse está arrastrando a otro elemento."	

	^Color r: 136/255 g: 143/255 b: 158/255. "Color r: 0.534 g: 0.561 b: 0.62"
]

{ #category : #draggingAnotherColors }
PLC_GraphicElementProperties >> draggingAnotherBlockFootAndHeaderColor [
	"Color de cabecera y pie del bloque.	
	Se aplica cuando estaba seleccionado y el mouse está arrastrando a otro elemento."		

	^Color r: 202/255 g: 204/255 b: 217/255. "(Color r: 0.792 g: 0.8 b: 0.851)"
]

{ #category : #draggingAnotherColors }
PLC_GraphicElementProperties >> draggingAnotherElementColor [
	"Color de los contactos, bobinas y del texto (actual value).
	Se aplica cuando estaba seleccionado y el mouse está arrastrando a otro elemento."	

	^Color white.
]

{ #category : #draggingSelfColors }
PLC_GraphicElementProperties >> draggingSelfBackgroundColor [
	"Color de fondo de contactos, bobinas y de variables (actual value).
	Se aplica cuando el mouse está arrastrando al elemento.
	Idem unselected pero agrega transparencia del 50% (alpha:0.5)"	
		
	^ self unselectedBackgroundColor alpha: 0.5.
]

{ #category : #draggingSelfColors }
PLC_GraphicElementProperties >> draggingSelfBlockBodyColor [
	"Color de cuerpo del bloque.
	Se aplica cuando el mouse está arrastrando al elemento.
	Idem unselected pero agrega transparencia del 50% (alpha:0.5)"
		
	^ self unselectedBlockBodyColor alpha: 0.5.
]

{ #category : #draggingSelfColors }
PLC_GraphicElementProperties >> draggingSelfBlockFootAndHeaderColor [
	"Color de cabecera y pie del bloque.
	Se aplica cuando el mouse está arrastrando al elemento.
	Idem unselected pero agrega transparencia del 50% (alpha:0.5)"	
		
	^ self unselectedBlockFootAndHeaderColor alpha: 0.5.
]

{ #category : #draggingSelfColors }
PLC_GraphicElementProperties >> draggingSelfElementColor [
	"Color de los contactos, bobinas y del texto (actual value).
	Se aplica cuando el mouse está arrastrando al elemento.
	Idem unselected pero agrega transparencia del 50% (alpha:0.5)"
	
	^ self unselectedElementColor alpha: 0.5.
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawBounds [
	^ drawBounds
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawBounds: anObject [
	drawBounds := anObject
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawGrid [
	^ drawGrid
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawGrid: anObject [
	drawGrid := anObject
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawLayoutRectangle [
	^ drawLayoutRectangle
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawLayoutRectangle: anObject [
	drawLayoutRectangle := anObject
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawTextLineBorder [
	^ drawTextLineBorder
]

{ #category : #accessing }
PLC_GraphicElementProperties >> drawTextLineBorder: anObject [
	drawTextLineBorder := anObject
]

{ #category : #textColors }
PLC_GraphicElementProperties >> formalArgumentBackgroundColor [
	"Color de fondo de la variable (formal argument). Color transparente."

	^Color white alpha: 1.0.

]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> functionBlockColor [
	 "Es color cian de la caja de bloque de funcion."

	^ Color r: 0 g: 175/255 b: 239/255
]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> functionBlockHeaderColor [
	 "Es color cian claro de la cabecera de la caja de bloque de funcion."

	^ Color r: 82/255 g: 201/255 b: 244/255
]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> functionColor [
	 "Es color verde oscuro de la caja de funcion."

	^ Color r: 0 g: 168/255 b: 89/255
]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> functionHeaderColor [
	 "Es color verde claro de la cabecera de la caja de funcion."

	^ Color r: 121/255 g: 193/255 b: 78/255
]

{ #category : #grid }
PLC_GraphicElementProperties >> gridExtent [
	"Devuelve el tamaño en pixeles de una celda de la grilla gris."
	
	^ ( 96 @ 18 ).
]

{ #category : #grid }
PLC_GraphicElementProperties >> gridOrigin [
	"Devuelve la posicion 0@0 de la grilla"

	^ ( 20 @ 20 ).
]

{ #category : #'Project colors' }
PLC_GraphicElementProperties >> hardConfigColor [
	 "Es color Azul claro de la barra de titulo de Configuracion
	 de Hardware la ventada de proyecto."

	^ Color r: 89/255 g: 131/255 b: 219/255
]

{ #category : #informativeBlockColors }
PLC_GraphicElementProperties >> informativeBlockBorderColor [
	"Color de borde de cuadro informativo "

	^Color r: 1 g: 248/255 b:161 /255. "Color r: 1.0 g: 0.973 b: 0.631"
]

{ #category : #informativeBlockColors }
PLC_GraphicElementProperties >> informativeBlockColor [
	"Color del cuadro informativo. " 

	^Color r: 224/255 g: 219/255 b: 80/255. "Color r: 0.879 g: 0.859 b: 0.314"
]

{ #category : #'initialize-release' }
PLC_GraphicElementProperties >> initialize [
	"Inicializa las propiedades"

	self scale: (1@1).
	self drawBounds: false.
	self drawGrid: false.
	self drawTextLineBorder: false.
	self drawLayoutRectangle: false.
]

{ #category : #styles }
PLC_GraphicElementProperties >> leftUnderlineStyleWithColor: aColor andOrigin: anOrigin andDirection: aDirection [
	"Estilo del Morph subrrayado de la etiqueta. Tiene un color degradado."
	
	^ (GradientFillStyle 	ramp: { 
		0.0 -> Color white.
		1.0 -> aColor})
			origin: anOrigin;
			direction: aDirection;
			normal: 0@1300;
			radial: false.	
]

{ #category : #otherColors }
PLC_GraphicElementProperties >> mouseOverColor [
	  "Color que se aplica cuando el mouse se posa sobre el elemento"

	^Color r: 195/255 g: 215/255 b: 235/255 alpha: 0.5. "TranslucentColor r: 0.764 g: 0.844 b: 0.922 alpha: 0.498"
]

{ #category : #otherColors }
PLC_GraphicElementProperties >> nonBooleanVariablePinColor [
	 "Es el pin que solo acepta variables no booleanas."

	^Color r: 1 g: 164/255 b: 0.  "Color dorado  (Color r: 1.0 g: 0.643 b: 0.0)"
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> overDropAreaInsertionPointBackgroundColor [
	 "Color de fondo del area de drop que se encuentra tras el cuadradito 
	que representa el punto de inserción."

	^Color red alpha: 0.5.
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> overDropAreaInsertionPointBorderColor [
	 "Color de borde del cuadradito que representa el punto de inserción. Se aplica cuando el 
	mouse viene arrastrando un elemento y pasa sobre el área de drop, que es un área 
	alrededor del cuadradito que simboliza el punto de inserción."

	^Color black.
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> overDropAreaInsertionPointColor [
	 "Color del cuadradito que representa el punto de inserción. Se aplica cuando el mouse 
	viene arrastrando un elemento y pasa sobre el área de drop, que es un área al rededor 
	del cuadradito que simboliza el punto de inserción."

	^Color green.
]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> programColor [
	 "Es color dorado oscuro de la caja de funcion."

	^ Color r: 210/255 g: 174/255 b: 109/255
]

{ #category : #'POU colors' }
PLC_GraphicElementProperties >> programHeaderColor [
	 "Es color dorado claro de la cabecera de la caja de bloque de funcion."

	^ Color r: 223/255 g: 190/255 b: 98/255
]

{ #category : #'Project colors' }
PLC_GraphicElementProperties >> projectColor [
	 "Es color Azul oscuro de la barra de titulo de Proyecto de 
	Automatizacion de la ventada de proyecto."

	^ Color r: 51/255 g: 102/255 b: 211/255
]

{ #category : #styles }
PLC_GraphicElementProperties >> rightUnderlineStyleWithColor: aColor andOrigin: anOrigin andDirection: aDirection [
	"Estilo del Morph subrrayado de la etiqueta. Tiene un color degradado."
	
	^ (GradientFillStyle 	ramp: { 
		0.0 -> aColor.
		1.0 -> Color white})
			origin: anOrigin;
			direction: aDirection;
			normal: 0@400;
			radial: false.	
]

{ #category : #EditableGridColors }
PLC_GraphicElementProperties >> rowColorEven [
	 "Es color de fondo de fila par en la EditableGrid."

	^ Color r: 243/255 g: 243/255 b: 244/255
]

{ #category : #EditableGridColors }
PLC_GraphicElementProperties >> rowColorHeader [
	 "Es color verde claro de la cabecera de la caja de funcion."

	^ Color r: 96/255 g: 96/255 b: 98/255
]

{ #category : #EditableGridColors }
PLC_GraphicElementProperties >> rowColorOdd [
	 "Es color de fondo de fila impar en la EditableGrid."

	^ Color white
]

{ #category : #EditableGridColors }
PLC_GraphicElementProperties >> rowColorSelected [
	 "Es color de fondo de fila cuando esta seleccionada en la EditableGrid."

	^ Color r: 175/255 g: 213/255 b: 250/255
]

{ #category : #accessing }
PLC_GraphicElementProperties >> scale [
	^ scale
]

{ #category : #accessing }
PLC_GraphicElementProperties >> scale: anObject [
	scale := anObject
]

{ #category : #selectedColors }
PLC_GraphicElementProperties >> selectedBackgroundColor [
	"Color de fondo de contactos, bobinas y de variables (actual value).
	Se aplica cuando está seleccionado."
	
	^Color r: 51/255 g: 102/255 b: 211/255.  " (Color r: 0.2 g: 0.4 b: 0.827)"


]

{ #category : #selectedColors }
PLC_GraphicElementProperties >> selectedBlockBodyColor [
	"Color de cuerpo del bloque.
	Se aplica cuando está seleccionado."

	^Color r: 51/255 g: 102/255 b: 211/255.  " (Color r: 0.2 g: 0.4 b: 0.827)"


]

{ #category : #selectedColors }
PLC_GraphicElementProperties >> selectedBlockFootAndHeaderColor [
	"Color de cabecera y pie del bloque.
	Se aplica cuando está seleccionado."

	^Color r: 134/255 g: 164/255 b: 229/255. " (Color r: 0.526 g: 0.643 b: 0.898)" 
]

{ #category : #selectedColors }
PLC_GraphicElementProperties >> selectedElementColor [
	"Color de los contactos, bobinas y del texto (actual value).
	Se aplica cuando está seleccionado."
	
	^Color white.
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> underDragAreaInsertionPointBackgroundColor [
	 "Color de fondo del area de drop que se encuentra tras el cuadradito 
	que representa el punto de inserción."

	^Color green alpha: 0.5.
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> underDragAreaInsertionPointBorderColor [
	"Color de borde del cuadradito que representa el punto de inserción. Se aplica cuando está bajo 
	el área de Dragg al rededor del mouse mientras el mouse viene arrastrando un elemento"

	^Color r: 119/255 g: 136/255 b: 153/255." (Color r: 0.466 g: 0.534 b: 0.6)"
]

{ #category : #insertionPointColors }
PLC_GraphicElementProperties >> underDragAreaInsertionPointColor [
	"Color del cuadradito que representa el punto de inserción. Se aplica cuando está bajo 
	el área de Dragg al rededor del mouse mientras el mouse viene arrastrando un elemento"

	^ Color r: 218/255 g: 233/255 b: 254/255." (Color r: 0.855 g: 0.534 b: 0.996)"
]

{ #category : #unselectedColors }
PLC_GraphicElementProperties >> unselectedBackgroundColor [
	"Color de fondo de contactos, bobinas y de variables (actual value).
	Se aplica cuando está deseleccionado. Es el color por defecto del elemento."	
	
	^Color white.
]

{ #category : #unselectedColors }
PLC_GraphicElementProperties >> unselectedBlockBodyColor [
	"Color de cuerpo del bloque.
	Se aplica cuando está deseleccionado. Es el color por defecto del elemento."	

	^Color r: 223/255 g: 224/255 b: 232/255. "Color r: 0.875 g: 0.879 b: 0.91"

]

{ #category : #unselectedColors }
PLC_GraphicElementProperties >> unselectedBlockFootAndHeaderColor [
	"Color de cabecera y pie del bloque.	
	Se aplica cuando está deseleccionado. Es el color por defecto del elemento."	

	^Color r: 202/255 g: 204/255 b: 217/255. "Color r: 0.792 g: 0.8 b: 0.851" "Color de bloque gris oscuro"
]

{ #category : #unselectedColors }
PLC_GraphicElementProperties >> unselectedElementColor [
	"Color de los contactos, bobinas y del texto (actual value).
	Se aplica cuando está deseleccionado. Es el color por defecto del elemento."
	
	^Color black.
]

{ #category : #otherColors }
PLC_GraphicElementProperties >> voidStateColor [
	  "Color que se aplica en el estado vacio. Color transparente"

	^Color r: 1 g: 1 b: 1 alpha: 0.
]
