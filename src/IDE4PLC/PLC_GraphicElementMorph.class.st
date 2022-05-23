"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicElementMorph is xxxxxxxxx.

Instance Variables
	connectionStateLayer1:		<Object>
	connectionStateLayer2:		<Object>
	userInteractionStateLayer1:		<Object>
	userInteractionStateLayer2:		<Object>
	userInteractionStateLayer3:		<Object>
	xPositioned:		<Object>
	yPositioned:		<Object>

connectionStateLayer1
	- xxxxx

connectionStateLayer2
	- xxxxx

userInteractionStateLayer1
	- xxxxx

userInteractionStateLayer2
	- xxxxx

userInteractionStateLayer3
	- xxxxx

xPositioned
	- xxxxx

yPositioned
	- xxxxx

"
Class {
	#name : #'PLC_GraphicElementMorph',
	#superclass : #Morph,
	#instVars : [
		'userInteractionStateLayer1',
		'userInteractionStateLayer2',
		'userInteractionStateLayer3',
		'connectionStateLayer1',
		'connectionStateLayer2',
		'xPositioned',
		'yPositioned'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #alignment }
PLC_GraphicElementMorph >> aboveAndToTheLeft: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alinea su borde inferior al borde superior de aMorphOrRectangle.

	Self is positioned as shown below:
	
        ---------
        |  self  |
        --------- -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------	     
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.
	
	self position: rectangle topLeft - self extent.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> aboveAndToTheRight: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alineado al borde inferior de aMorphOrRectangle.

	Self is positioned as shown below:
	
    					       ---------
					       |  self  |
		     ------------------- --------- 
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------	  	      
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft + ( rectangle extent x @ self extent y negated ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #'commands recive from view' }
PLC_GraphicElementMorph >> addDependentsOnLadderView: aLadderView from: aConnectableBlock [
	"Agrega sus elementos graficos morphs dependientes al ladder view.
	Estos pueden ser Actual Arguments o Pines."
	
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignAbove: aMorphOrRectangle [
	"Se posiciona arriba de aMorphOrRectangle. Solo mueve a self verticalmente.

NUEVOOOOOOOOOO

	Self is positioned as shown below:
	
		   	    ---------	
		    	    |  self  |
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
"
	self bottom: ( aMorphOrRectangle bottom - aMorphOrRectangle extent y ).
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignBeneath: aMorphOrRectangle [
	"Se posiciona por debajo de aMorphOrRectangle. Solo mueve a self verticalmente.

NUEVOOOOOOOOOO

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		    	    |  self  |
		   	    ---------			    
"
	self top: ( aMorphOrRectangle top + aMorphOrRectangle extent y ).
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignCenteredAbove: aMorphOrRectangle [
	"Se posiciona debajo y centrado de aMorphOrRectangle.

NUEVOOOOOOOOOO

	Self is positioned as shown below:

		   	    ---------
		    	    |  self  |	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------							    
"
	self center: aMorphOrRectangle center.
	self alignAbove: aMorphOrRectangle.
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignCenteredBeneath: aMorphOrRectangle [
	"Se posiciona debajo y centrado de aMorphOrRectangle.

NUEVOOOOOOOOOO

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		    	    |  self  |
		   	    ---------			    
"
	self center: aMorphOrRectangle center.
	self alignBeneath: aMorphOrRectangle.
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignToTheLeft: aMorphOrRectangle [
	"self se posiciona a la izquierda de aMorphOrRectangle. No se cambia la posicion vertical de self.

NUEVOOOOOOOOOO

	Self is positioned as shown below:
	
				     -------------------
				     |      aMorph    |
		        --------- |      (fixed       |
		        |  self  | |    position)    |
		        --------- -------------------	    
"
	self right: ( aMorphOrRectangle right - aMorphOrRectangle extent x ).
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignToTheRight: aMorphOrRectangle [
	"self se posiciona a la derecha de aMorphOrRectangle. No se cambia la posicion vertical de self.

NUEVOOOOOOOOOO

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       | ---------
		     |    position)    | |  self  |
		     -------------------	---------	     
"
	self left: ( aMorphOrRectangle left + aMorphOrRectangle extent x ).
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtBottomLeft: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alineado al borde inferior de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
	--------- |      (fixed       |
	|  self  | |    position)    |
	--------- -------------------		      
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self bottom: rectangle bottom. 
	self position: (rectangle topLeft - self extent) x @ self position y.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtBottomRight: aMorphOrRectangle [
	"Se posiciona a la derecha de aMorphOrRectangle y alineado al borde inferior de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       | ---------
		     |    position)    | |  self  |
		     -------------------	---------	     
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft + ( rectangle extent x @ 0 ).
	self bottom: rectangle bottom.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtLeftAbove: aMorphOrRectangle [
	"Se posiciona por arriba de aMorphOrRectangle y alineado a la izquierda de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     ---------
		     |  self  |
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------		      
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft - ( 0 @ self extent y ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtLeftBeneath: aMorphOrRectangle [
	"Se posiciona por debajo de aMorphOrRectangle y alineado a la izquierda de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		     |  self  |
		     ---------			      
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft + ( 0 @ rectangle extent y ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtRight: aMorphOrRectangle [
	"Se posiciona a la derecha de aMorphOrRectangle. No se cambia la posicion vertical de self.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       | ---------
		     |    position)    | |  self  |
		     -------------------	---------	     
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: ( rectangle origin x + rectangle extent x @ self position y ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtRightAbove: aMorphOrRectangle [
	"Se posiciona por arriba de aMorphOrRectangle y alineado a la derecha de aMorphOrRectangle.

	Self is positioned as shown below:
	
		   		  ---------
		    		  |  self  |
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------			      
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft + ( rectangle extent x @ 0 ) - self extent.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtRigthBeneath: aMorphOrRectangle [
	"Se posiciona por debajo de aMorphOrRectangle y alineado a la derecha de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		    		  |  self  |	
		   		  ---------		      
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.
	
	self position: rectangle topLeft + rectangle extent -  ( self extent x @ 0 ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtTopLeft: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alineado al borde superior de aMorphOrRectangle.

	Self is positioned as shown below:
	
	--------- -------------------
	|  self  | |      aMorph    |
	--------- |      (fixed       |
		     |    position)    |
		     -------------------		      
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.
	
	self position: rectangle topLeft - ( self extent x @ 0 ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> alignedAtTopRight: aMorphOrRectangle [
	"Se posiciona a la derecha de aMorphOrRectangle y alineado al borde superior de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     ------------------- ---------
		     |      aMorph    | |  self  |
		     |      (fixed       | ---------
		     |    position)    |
		     -------------------	      
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.
	
	self position: rectangle topLeft + ( rectangle extent x @ 0 ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #drawing }
PLC_GraphicElementMorph >> backgroundRectangle [
	"Devuelve el rectángulo que se sombrea al pasar el mouse por el elemento."
	
	| rectangle |
	
	rectangle := Rectangle 
		origin: self backgroundRectanglePosition 
		corner: self backgroundRectanglePosition + self backgroundRectangleExtent.
		
	^ rectangle translateBy: self position.
]

{ #category : #extent }
PLC_GraphicElementMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self defaultExtent.
]

{ #category : #position }
PLC_GraphicElementMorph >> backgroundRectanglePosition [
	"Devuelve la posición en pantalla del backgroundRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( 0 @ 2 ).
]

{ #category : #alignment }
PLC_GraphicElementMorph >> beneath: aMorphOrRectangle [
	"Se posiciona por debajo de aMorphOrRectangle. Solo mueve a self verticalmente.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		    	    |  self  |
		   	    ---------			    
"
	
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self bottom: rectangle bottom + self extent y.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> beneathAndToTheLeft: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alinea su borde superior al borde inferior de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------			
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
        --------- -------------------
        |  self  |
        ---------		    
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.
	
	self position: rectangle topLeft+ ( 0 @ rectangle extent y ) - ( self extent x @ 0 ).
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> beneathAndToTheRight: aMorphOrRectangle [
	"Se posiciona a la derecha de aMorphOrRectangle y alinea su borde superior al borde inferior de aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------			
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |	
		     ------------------- ---------	
    					       |  self  |				
  					       ---------			    
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self position: rectangle topLeft + rectangle extent.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> blockConnectedToInput: anInputNumber [
	"Devuelve el bloque conectado a la entrada anInputNumber."

	^ self owner blockConnectedToInput: anInputNumber for: self.
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> blockConnectedToOutput: anOutputNumber [
	"Devuelve el bloque conectado a la salida anInputNumber."

	^ self owner blockConnectedToOutput: anOutputNumber for: self.
]

{ #category : #'align strates' }
PLC_GraphicElementMorph >> centerAlign [
	"Estado s de alineación. Los implementan los Tag Morph"

]

{ #category : #alignment }
PLC_GraphicElementMorph >> centeredAbove: aMorphOrRectangle [
	"Se posiciona por arriba de aMorphOrRectangle y alinea centrado horizontalmente con aMorphOrRectangle.

	Self is positioned as shown below:
	
		   	    ---------
		    	    |  self  |
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------			    
"
	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self center: rectangle center.
	self top: rectangle top - self extent y.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> centeredBeneath: aMorph [
	"Se posiciona por debajo de aMorphy alinea centrado horizontalmente con aMorph.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    |
		     |      (fixed       |
		     |    position)    |
		     -------------------				
		    	    |  self  |
		   	    ---------			    
"

	self center: aMorph center.
	self bottom: aMorph bottom + self extent y.
]

{ #category : #alignment }
PLC_GraphicElementMorph >> centeredToTheLeft: aMorphOrRectangle [
	"Se posiciona por la izquierda de aMorphOrRectangle y alinea centrado verticalmente con aMorphOrRectangle.

	Self is positioned as shown below:
	
		     -------------------
	--------- |      aMorph    |
	|  self  | |      (fixed       |
	--------- |    position)    |			
		     ------------------- 					    
"

	| rectangle |
	
	rectangle := self morphOrRectangleToRectangle: aMorphOrRectangle.

	self center: rectangle center.
	self position: ( rectangle topLeft - self extent ) x @ self position y.
	
	self positionYourLayoutAreaInYourself
]

{ #category : #alignment }
PLC_GraphicElementMorph >> centeredToTheRight: aMorph [
	"Se posiciona a la derecha de aMorph y alinea centrado verticalmente con aMorph.

	Self is positioned as shown below:
	
		     -------------------
		     |      aMorph    | ---------
		     |      (fixed       | |  self  |
		     |    position)    | ---------
		     ------------------- 						    
"
	| rectangle |
	
	rectangle := aMorph bounds.

	self center: rectangle center.
	self position: ( rectangle topLeft + rectangle extent ) x @ self position y.
]

{ #category : #'other events' }
PLC_GraphicElementMorph >> changeFunction [
	"Estado changeFunction."

	"self drawingLayer1: PLC_GraphicElementState unselected.
	self changed."
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> changeFunction: anEvent [
	"Estado changeFunction."
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> connectableBlock [
	"Devuelve el bloque conectable del Elemento Grafico Morph pidiendoselo a su ladder view."
	
	^ self owner modelElementForGraphicElement: self.
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> connectedAtInput: aNumber [
	"Devuelve la conexion o bloque conectado a la entrada aNumber del elemento"

	^ self owner connectedAtInput: aNumber for: self.
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> connectedAtOutput: aNumber [
	"Devuelve la conexion o bloque conectado a la salida aNumber del elemento"

	^ self owner connectedAtOutput: aNumber for: self.
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> connectedToBlock [ 
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Bloque.
	Lo implementa PLC_RightPowerRailMorph "
	
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> connectedToCoil [ 
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Bobina.
	Lo implementa PLC_RightPowerRailMorph "
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> connectedToContact [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Contacto.
	Lo implementa PLC_RightPowerRailMorph "
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> connectedToLeftPowerRail [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Barra Izquierda.
	Lo implementa PLC_RightPowerRailMorph "
]

{ #category : #'connection states layer 2' }
PLC_GraphicElementMorph >> connectedToLeftPowerRailTroughFirstOutputPin [ 
	"Define algoritmo de layout que cambia si 	esta conectado a primer rama o bobina.
	En el caso de la Barra Izquierda cambia el dibujo si es pirmer pin u otro."

	self connectionStateLayer2: PLC_GraphicElementState connectedToLeftPowerRailTroughFirstOutputPin.
	self changed.
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> connectedToRightPowerRail [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Barra Derecha"
]

{ #category : #accessing }
PLC_GraphicElementMorph >> connectionStateLayer1 [
	^ connectionStateLayer1
]

{ #category : #accessing }
PLC_GraphicElementMorph >> connectionStateLayer1: anObject [
	connectionStateLayer1 := anObject
]

{ #category : #accessing }
PLC_GraphicElementMorph >> connectionStateLayer2 [
	^ connectionStateLayer2
]

{ #category : #accessing }
PLC_GraphicElementMorph >> connectionStateLayer2: anObject [
	connectionStateLayer2 := anObject
]

{ #category : #'event handling' }
PLC_GraphicElementMorph >> containsPoint: aPoint [
	"Para setear el area sensitiva del mouse dentro de la caja delimitadora del Morph"

	^ (self backgroundRectangle containsPoint: aPoint).
]

{ #category : #extent }
PLC_GraphicElementMorph >> defaultExtent [
	"Tamaño por defecto del elemento."
	
	^ self gridExtent.
]

{ #category : #layout }
PLC_GraphicElementMorph >> dependentsUnderLayoutRectangle [
	"Devuelve una Ordered Collection con los elementos dependientes 
	de este elemento que se encuentren bajo su layoutRectangle. 
	Esto se utiliza para poder borrar elementos bajo el layout Rectangle 
	del grupo cuando hago el layout Vertical."

	| collection |
	
	collection := OrderedCollection new.

	self elementDependents do: [ :each | 
		( each layoutRectangle intersects: self layoutRectangle )
			ifTrue: [ collection add: each.]
		].	
	
	^collection.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> diagonalLine1Rectangle [
	"Linea diagonal que forma parte de la flecha del Riel Derecho cuando esta conectado a Contacto."

	| width height diagonalLine |

	width := self properties scale x * 4.
	height := self properties scale y * 4.
	
	diagonalLine := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ diagonalLine align: diagonalLine topRight with: self bounds topRight + (self properties scale * (-2 @ 4)).

]

{ #category : #drawing }
PLC_GraphicElementMorph >> diagonalLine2Rectangle [
	"Linea diagonal que forma parte de la flecha del Riel Derecho cuando esta conectado a Contacto."

	| width height diagonalLine |

	width := self properties scale x * 4.
	height := self properties scale y * 4.
	
	diagonalLine := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ diagonalLine align: diagonalLine topRight with: self bounds topRight + (self properties scale * (-8 @ 4)).
]

{ #category : #drawing }
PLC_GraphicElementMorph >> diagonalLine3Rectangle [
	"Linea diagonal que forma parte de la flecha del Riel Derecho cuando esta conectado a Contacto."

	| width height diagonalLine |

	width := self properties scale x * 4.
	height := self properties scale y * 4.
	
	diagonalLine := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ diagonalLine align: diagonalLine bottomRight with: self bounds bottomRight - (self properties scale * (2 @ 4)).
]

{ #category : #drawing }
PLC_GraphicElementMorph >> diagonalLine4Rectangle [
	"Linea diagonal que forma parte de la flecha del Riel Derecho cuando esta conectado a Contacto."

	| width height diagonalLine |

	width := self properties scale x * 4.
	height := self properties scale y * 4.
	
	diagonalLine := Rectangle origin: (0@0) corner: ( width @ height ).
	
	^ diagonalLine align: diagonalLine bottomRight with: self bounds bottomRight - (self properties scale * (8 @ 4)).
]

{ #category : #extent }
PLC_GraphicElementMorph >> doubleWidth [
	"Cambia el ancho del elemento al doble"

	self extent: ( self elementDoubleWidth @ self extent y ).
	self extentChanged.
	self submorphs do: [ :each |
		each doubleWidth.
		].
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> draggingAnother [
	"Estado cuando estaba seleccionado y arrastran otro elemento desde fuera de la network."

	self userInteractionStateLayer1: PLC_GraphicElementState draggingAnother.
	self changed.
	
	self submorphsPerform: #draggingAnother.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> draggingSelf [
	"Estado cuando el elemento esta siendo arrastrado por el mouse."

	self userInteractionStateLayer1: PLC_GraphicElementState draggingSelf.
	self changed.
	
	self submorphsPerform: #draggingSelf.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	aCanvas 
		fillRectangle: self backgroundRectangle 
		color: self userInteractionStateLayer1 backgroundColor.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawBoundsOn: aCanvas [
	"Dibujo el borde del margen del elemento. Tamaño total"
	
	aCanvas
		frameRectangle: self bounds
		width: 1
		colors: {Color blue. Color white alpha: 0}
		dashes: {2. 1}..

]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawDoubleArrowOn: aCanvas [.
	"Dibuja la flecha doble del Riel Derecho conectado a contacto."

	aCanvas line: self diagonalLine1Rectangle origin
		to: self diagonalLine1Rectangle corner
		width: self properties scale x * 2
		color: self userInteractionStateLayer1 elementColor.
	"Parche blanco sobre la linea diagonal"
	aCanvas line: self diagonalLine1Rectangle origin - (1@0)
		to: self diagonalLine1Rectangle origin - (1@1)
		width: self properties scale x * 1
		color: Color white.

	aCanvas line: self diagonalLine2Rectangle origin
		to: self diagonalLine2Rectangle corner
		width: self properties scale x * 2
		color: self userInteractionStateLayer1 elementColor.
	"Parche blanco sobre la linea diagonal"
	aCanvas line: self diagonalLine2Rectangle origin - (1@0)
		to: self diagonalLine2Rectangle origin - (1@1)
		width: self properties scale x * 1
		color: Color white.

	aCanvas line: self diagonalLine3Rectangle bottomLeft
		to: self diagonalLine3Rectangle topRight
		width: self properties scale x * 2
		color: self userInteractionStateLayer1 elementColor.
	"Parche blanco sobre la linea diagonal"
	aCanvas line: self diagonalLine3Rectangle bottomLeft - (1@0 negated)
		to: self diagonalLine3Rectangle bottomLeft - (1@1)
		width: self properties scale x * 1
		color: Color white.

	aCanvas line: self diagonalLine4Rectangle bottomLeft
		to: self diagonalLine4Rectangle topRight
		width: self properties scale x * 2
		color: self userInteractionStateLayer1 elementColor.
	"Parche blanco sobre la linea diagonal"
	aCanvas line: self diagonalLine4Rectangle bottomLeft - (1@0 negated)
		to: self diagonalLine4Rectangle bottomLeft - (1@1)
		width: self properties scale x * 1
		color: Color white.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawElementOn: aCanvas [
	"Dibujo el elemento grafico"
	
	aCanvas 
		fillRectangle: self defaultExtent 
		color: Color red.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawLayoutRectangleOn: aCanvas [
	"Dibujo el borde del LayoutRectangle del elemento."
	
	aCanvas
		frameRectangle: self layoutRectangle
		width: 1
		color: Color green.
]

{ #category : #drawing }
PLC_GraphicElementMorph >> drawOn: aCanvas [
	"Dibujo el elemento grafico"
	
	self userInteractionStateLayer1 drawOn: aCanvas for: self.
	self userInteractionStateLayer2 drawOn: aCanvas for: self.
	self userInteractionStateLayer3 drawOn: aCanvas for: self.
	
	self properties drawBounds ifTrue: [
		self drawBoundsOn: aCanvas
		].
	
	self properties drawLayoutRectangle ifTrue: [
		self drawLayoutRectangleOn: aCanvas
		].
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> element [
	"Devuelve el elemento del bloque conectable del Elemento Grafico Morph pidiendoselo a su ladder view."
	
	^ self connectableBlock element.
]

{ #category : #dependents }
PLC_GraphicElementMorph >> elementDependents [
	"Devuelve una OrderedCollection con sus elementos graficos morphs 
	dependientes que agregó al LadderView. En los que no tienen este 
	metodo reescrito es porque no poseen dependientes entonces 
	devuelve una coleccion vacia."

	^ OrderedCollection new.
]

{ #category : #extent }
PLC_GraphicElementMorph >> elementDoubleWidth [
	"Doble ancho del elemento"

	^ self defaultExtent x.
]

{ #category : #extent }
PLC_GraphicElementMorph >> elementWidth [
	"Ancho estandar del elemento"

	^ self defaultExtent x.
]

{ #category : #extent }
PLC_GraphicElementMorph >> extentChanged [
	"Cambia el tamaño del elemento"
	
	self extent: self totalExtent.
]

{ #category : #pins }
PLC_GraphicElementMorph >> firstPinYDistance [
	"Devuelve la distancia  en pantalla en Y del primer pin de entrada 
	y salida relativa a la posicion vertical de self .
	Es la distancia vertical entre la parte de arriba del elemento y el primer pin."
	
	^ 0.
]

{ #category : #grid }
PLC_GraphicElementMorph >> gridExtent [
	"Devuelve el tamaño en pixeles de una celda de la grilla gris."
	
	^ self properties gridExtent.
]

{ #category : #grid }
PLC_GraphicElementMorph >> gridOrigin [
	"Devuelve la posicion 0@0 de la grilla"

	^ self owner gridOrigin.
]

{ #category : #'event handling' }
PLC_GraphicElementMorph >> handlesMouseOver: anEvent [
	"Permite manejar el evento de que el puntero pasa sobre el morph."

	^true.
	"^false. "
]

{ #category : #'initialize-release' }
PLC_GraphicElementMorph >> initialize [
	"Inicializo el elemento grafico"
	
	"Siempre debe hacer esto al inicializarse un Morph"
	super initialize.			
				
	"Inicializo el morph a su tamaño por defecto"
	self extent: self defaultExtent.
	
	"Inicializo sus estados de Interfaz de Usuario"
	PLC_GraphicElementState initialize.
	self unselected;
		mouseOut;
		notKeyboardFocus;
		notConnectedToLeftPowerRailTroughFirstOutputPin;
		voidCSL1.
	
	"Indican si el elemento esta terminado deposicionarse en X e Y. Inicializan en false"
	self xPositioned: false;
		yPositioned: false.		
					
	"Muestro en pantalla"
	self openInWorld.
]

{ #category : #ladderView }
PLC_GraphicElementMorph >> instanceVariable [
	"Devuelve la variable de instancia si el elemento contiene. 
	Esto sucede en Contacto, Bobina o FB, en los otros devuelve nil"

	^ nil.
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isActualArgument [
	"Devuelve true si es un RightPowerRail Morph"

	^ false.
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isCoil [
	"Devuelve true si el elemento grafico es una bobina."

	^ false
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isContact [
	"Devuelve true si el elemento grafico es un Contacto."

	^ false
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isLeftPowerRail [
	"Devuelve true si el elemento grafico es una Barra derecha."

	^ false
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isPLCBlock [
	"Devuelve true si el elemento grafico es un Bloque."

	^ false
]

{ #category : #'model exploration' }
PLC_GraphicElementMorph >> isRightPowerRail [
	"Devuelve true si es un RightPowerRail Morph"

	^ false.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> keyboardFocus [
	"Estado con el foco del teclado en el elemento."

	self userInteractionStateLayer3: self userInteractionStateLayer1 keyboardFocus.
	self changed.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutFirstPinsYDistance [
	"Devuelve la distancia minima en pantalla en Y del primer pin de entrada 
	y salida relativa a layoutRectangle top de self .
	Es la distancia vertical entre la parte de arriba del elemento y sus sub elementos y el primer pin."
	
	^ self layoutRectangleRelativePosition y + self firstPinYDistance.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutGroupVerticallyOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"Alineo Verticalmnete su grupo de primer pin."

	| previousOutputElement group groupPrev |
	
	"Si ya se encontraba posicionado en Y no lo posiciono."
	( self yPositioned )
		ifFalse: [
			"Obtengo el grupo del elemento"
			group := aLadderView groupFor: self.	
			
			"Chequea si esta conectado a la primer salida del elemento anterior. 
			En base a esto se acomoda de una manera u otra."
			( anOutputNumber = 1 )
				ifTrue: [
					"Posiciono su group a partir del topRight del layoutRectangle del elemento 
					conectado a su entrada"
		
					group layoutVerticallyTop: aGraphicElement layoutRectangle top.
					] 
				ifFalse: [
					
					"ACA DEBE CHEQUEAR QUE ADEMAS YA LO HAYA ACOMODADO EN X
					AL ELEMENTO DEL PIN ANTERIOR PARA QUE NO SE ARME BARDO CON
					LOS BLOQUES, VER 2 PRIMA EN LAS HOJAS "
					
					"Obtengo el elemento conectado a la salida anterior de la que esta 
					conectado self en el elemento  inputGraphicElement."
					previousOutputElement := aGraphicElement blockConnectedToOutput: anOutputNumber - 1.

					"Obtengo el grupo azul en el que se encuentra el previousOutputElement"
					groupPrev := aLadderView groupFor: previousOutputElement.
			
					"Posiciono su firstPinGroup Verticalmente a partir del bottom del layoutRectangle de groupPrev."
					group layoutVerticallyTop: groupPrev layoutRectangle bottom.
					].

			"Chequeo si su grupo pisa otro elemento previamente posicionado. Si pisa lo muevo otra vez. 
			Así en un loop hasta que no pise a nadie verticalmente."
			[ aLadderView gotAnElementVerticallyUnderGroup: group ] 
				whileTrue: [
					group layoutVerticallyTop: 
						( aLadderView maxBottomElementUnderGroup: group ) layoutRectangle bottom.
					].
			
			"Seteo a true el flag de que se encuentra posicionado en Y en cada elemento de grupo serie."
			group yPositioned: true
			
			].
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutHorizontallyLeft: aDistanceX [
	"Este metodo usa el metodo layoutLeft: y le pasa aDistanceX y otro valor
	segun ciertas consideraciones de conexiones y demas."
	"Mensaje para compatibilidad con grupos. Para que funcione el composite Gupos - Elementos."
	
	"Alineo el elemento a aDistanceX"
	self layoutLeft: aDistanceX.

]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutHorizontallyOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"Alineo Horizontalmente su grupo serie."
	
	| group |
	
	"Si ya se encontraba posicionado en X no lo posiciono."
	( self xPositioned )
		ifFalse: [		
			"Posiciono el elemento grafico Horizontalmente a la derecha del 
			layoutRectangle del elemento conectado a su entrada"
			"self layoutHorizontallyLeft: aGraphicElement layoutRectangle right."
			
			"Obtengo el grupo del elemento"
			group := aLadderView groupFor: self.
			
			"Posiciono su grupo Horizontalmente a la derecha del layoutRectangle 
			del elemento conectado a su entrada"
			group layoutHorizontallyLeft: aGraphicElement layoutRectangle right.
						
			"Seteo a true el flag de que se encuentra posicionado en X el grupo."
			group xPositioned: true.
			].
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutLeft: aNumber [
	"self posiciona horizontalmente su layoutRectangle en aNumber."
	
	self layoutPosition: ( aNumber @ (self position y - self layoutRectangleRelativePosition y ) ).
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutOutputsOn: aLadderView from: aGraphicElement output: anOutputNumber [
	"Alineo el elemento conectado a la salida de su grupo serie."
	
	| nextGraphicElement |
	
	"Obtengo el elemento conectado a su única salida"
	nextGraphicElement := self blockConnectedToOutput: 1.
			
	"Posiciona en pantalla el elemento obtenido."
	nextGraphicElement layoutOn: aLadderView from: self output: 1.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutPosition: aPoint [
	"self posiciona su layoutRectangle en el punto aPoint."
	
	self position: aPoint + self layoutRectangleRelativePosition.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutRectangle [
	"Devuelve el rectángulo para acomodar en pantalla los elementos entre si."

	| rectangle |
	
	rectangle := Rectangle 
		origin: self layoutRectanglePosition 
		corner: self layoutRectanglePosition + self layoutRectangleExtent.
		
	^ rectangle translateBy: self position.
]

{ #category : #extent }
PLC_GraphicElementMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self connectionStateLayer1 layoutRectangleExtentFor: self.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutRectangleForGroup [
	"Devuelve el rectángulo para acomodar en pantalla los elementos 
	entre si que usan los grupos azules."

	^ self layoutRectangle.
]

{ #category : #position }
PLC_GraphicElementMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self connectionStateLayer1 layoutRectanglePositionFor: self.
]

{ #category : #position }
PLC_GraphicElementMorph >> layoutRectangleRelativePosition [
	"Posicion relativa entre el layoutRectangle y el position del elemento"

	^ self topLeft - self layoutRectangle topLeft.
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutTop: aDistanceY [
	"self posiciona verticalmente su layoutRectangle en aNumber."
	
	self layoutPosition: ( (self position x - self layoutRectangleRelativePosition x ) @ aDistanceY ).
]

{ #category : #layout }
PLC_GraphicElementMorph >> layoutVerticallyTop: aDistanceY [
	"self se posiciona a partir de la distancia vertical aDistanceY. 
	Self solo se mueve verticalmente, anElement queda fijo."
	
	self layoutTop: aDistanceY
]

{ #category : #'align strates' }
PLC_GraphicElementMorph >> leftAlign [
	"Estado s de alineación. Los implementan los Tag Morph"

]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> leftAndRightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> leftConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"
]

{ #category : #'other events' }
PLC_GraphicElementMorph >> lostKeyboardFocus [
	"Evento que ejecuta el Morph cuando pierde el foco del teclado"
]

{ #category : #'event handling' }
PLC_GraphicElementMorph >> mouseEnter: anEvent [
	"Manejador del evento mouse enter. Este mensaje se le envia al 
	morph cuando el puntero del mouse empieza a pasar por el."

	self mouseOver.
	
]

{ #category : #'event handling' }
PLC_GraphicElementMorph >> mouseLeave: anEvent [
	"Manejador del evento mouse leave. Este mensaje se le envia al 
	morph cuando el puntero del mouse deja de pasarpor el."

	self mouseOut.

]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> mouseOut [
	"Estado cuando el puntero del mouse esta fuera del elemento."

	self userInteractionStateLayer2: PLC_GraphicElementState voidState.
	self changed.
	
	self submorphsPerform: #mouseOut.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> mouseOver [
	"Estado cuando el puntero del mouse esta sobre elemento."

	self userInteractionStateLayer2: self userInteractionStateLayer1 mouseOver.
	self changed.
	
	"self submorphsPerform: #mouseOver."
]

{ #category : #'connection states layer 2' }
PLC_GraphicElementMorph >> notConnectedToLeftPowerRailTroughFirstOutputPin [
	"Define algoritmo de layout que cambia si 	esta conectado a primer rama o bobina.
	En el caso de la Barra Izquierda cambia el dibujo si es pirmer pin u otro."

	self connectionStateLayer2: PLC_GraphicElementState notConnectedToLeftPowerRailTroughFirstOutputPin.
	self changed.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> notDragging [
	"Estado cuando el mouse no trae nada arrastrando."

	self changed.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> notKeyboardFocus [
	"Estado sin el foco del teclado en el elemento."

	self userInteractionStateLayer3: PLC_GraphicElementState voidState.
	self changed.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> notOverDroppArea [ 
	"Estado desseleccionado."

"	self state1: PLC_GraphicElementState unselected.
	self changed."
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> notUnderDraggArea [ 
	"Estado desseleccionado."

"	self state1: PLC_GraphicElementState unselected.
	self changed."
]

{ #category : #'commands recive from view' }
PLC_GraphicElementMorph >> openBranchOnConnectionFrom: aLadderView [
	"Si el elemento grafico es un Horizontal Link abre una rama en la conexion. Si no, no hace nada"
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> overDropArea [
	"Estado cuando el mouse trae arrastrando un elemento y entra en el area
	ddonde un elemento permite el drop del elemento que trae arrastrando 
	el mouse."


	self changed.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> overDroppArea [ 
	"Estado desseleccionado."

"	self state1: PLC_GraphicElementState unselected.
	self changed."
]

{ #category : #properties }
PLC_GraphicElementMorph >> properties [
	"Devuelve la unica instancia de la clase PLC_GraphicElementProperties"

	^ PLC_GraphicElementProperties uniqueInstance.
]

{ #category : #'commands recive from view' }
PLC_GraphicElementMorph >> removeElementFrom: aLadderView [
	"Remueve el elemento pidiendoselo a su ladder view. Hace un double dispatching con este"

]

{ #category : #'commands recive from view' }
PLC_GraphicElementMorph >> removeRightPowerRailFrom: aLadderView [
	"Si es un RPR le envia el mensaje de nuevo al ladder View"
	
	aLadderView removeRightPowerRail: self
]

{ #category : #'align strates' }
PLC_GraphicElementMorph >> rightAlign [
	"Estado s de alineación. Los implementan los Tag Morph"

]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> rightConnectedToVerticalLink [
	"Cambia su estado de conexion capa 1al estado conectado a Enlace Vertical a derecha.
	Lo implementan Contactos, Bobinas y Bloques"
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> selected [
	"Estado seleccionado."

	self userInteractionStateLayer1: PLC_GraphicElementState selected.
	self changed.
	
	self submorphsPerform: #selected.
]

{ #category : #extent }
PLC_GraphicElementMorph >> standardWidth [
	"Cambia el ancho del elemento a ancho estandar."

	self extent: ( self elementWidth @ self extent y ).
	self extentChanged.
	self submorphs do: [ :each |
		each standardWidth.
		].
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> submorphsPerform: aSelector [
	"Actualiza el estado de los submorphs."
	
	self submorphs do: [ :subMorph |
		subMorph perform: aSelector.
		]
]

{ #category : #extent }
PLC_GraphicElementMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self defaultExtent.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> underDragArea [
	"Estado cuando el mouse trae arrastrando un elemento. Estro genera un area 
	grande alreddedor del mouse moviendose y los elementos bajo dicha area
	reciben este estado si aceptan el objeto que el mouse trae arrastrando."

	self changed.
]

{ #category : #'user interaction states' }
PLC_GraphicElementMorph >> unselected [
	"Estado desseleccionado."

	self userInteractionStateLayer1: PLC_GraphicElementState unselected.
	self changed.
	
	self submorphsPerform: #unselected.
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer1 [
	^ userInteractionStateLayer1
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer1: anObject [
	userInteractionStateLayer1 := anObject
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer2 [
	^ userInteractionStateLayer2
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer2: anObject [
	userInteractionStateLayer2 := anObject
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer3 [
	^ userInteractionStateLayer3
]

{ #category : #accessing }
PLC_GraphicElementMorph >> userInteractionStateLayer3: anObject [
	userInteractionStateLayer3 := anObject
]

{ #category : #'connection states layer 1' }
PLC_GraphicElementMorph >> voidCSL1 [
	"Cambia su estado de conexion (connection drawing layer) al estado conectado a Void que es el estado de capa 1 por defecto"

	self connectionStateLayer1: PLC_GraphicElementState voidCSL1.
	self changed.
]

{ #category : #accessing }
PLC_GraphicElementMorph >> xPositioned [
	^ xPositioned
]

{ #category : #accessing }
PLC_GraphicElementMorph >> xPositioned: anObject [
	xPositioned := anObject
]

{ #category : #accessing }
PLC_GraphicElementMorph >> yPositioned [
	^ yPositioned
]

{ #category : #accessing }
PLC_GraphicElementMorph >> yPositioned: anObject [
	yPositioned := anObject
]
