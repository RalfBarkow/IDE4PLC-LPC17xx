"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicElementGroup is xxxxxxxxx.

Instance Variables
	elements:		<Object>

elements
	- xxxxx

"
Class {
	#name : #'PLC_GraphicElementGroup',
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #elements }
PLC_GraphicElementGroup >> add: anElementOrGroup [
	"Añade un elemento o grupo al grupo. 
	Si el grupo  a añadir es el mismo produce un error.
	Si se intenta agregar repetidos produce error."
	
	( ( anElementOrGroup == self ) or: [ self includes: anElementOrGroup ] )
		ifTrue: [
			self error: 'No se puede añadir un grupo a si mismo, ni se permiten repetidos dentro del grupo'.
			] 
		ifFalse: [
			self elements add: anElementOrGroup.
			].
]

{ #category : #position }
PLC_GraphicElementGroup >> bottom [
	"Devuelve su posicion inferior en Y."

	^ self layoutRectangle bottom.
]

{ #category : #position }
PLC_GraphicElementGroup >> bottom: aDistance [
	"Setea su posicion inferior en Y."

	self elements do: [ :elem |
		elem bottom: aDistance.
		].
]

{ #category : #accessing }
PLC_GraphicElementGroup >> elements [
	^ elements
]

{ #category : #accessing }
PLC_GraphicElementGroup >> elements: anObject [
	elements := anObject
]

{ #category : #elements }
PLC_GraphicElementGroup >> elementsDependentsUnderGroupLayoutRectangle [
	"Devuelve una Ordered Collection con los elementos dependientes 
	de cada uno de los elementos del grupo  que estén dentro del 
	layoutRectangle de cada elemento. Esto se utiliza para poder 
	borrar elementos bajo 	el layout Rectangle del grupo cuando hago 
	el alyout Vertical."

	| collection |
	
	collection := OrderedCollection new.

	self elements do: [ :each |
		collection addAll: each dependentsUnderLayoutRectangle.
		].
	
	^collection.
]

{ #category : #elements }
PLC_GraphicElementGroup >> includes: anElementOrGroup [
	"Devuelve True si el Grupo incluye al elemento grafico."

	^ self elements includes: anElementOrGroup.
]

{ #category : #'initialize-release' }
PLC_GraphicElementGroup >> initialize [
	"Inicializa la Ordered Collection elements que contiene elementos graficos"

	self elements: OrderedCollection new.
	
	
	
]

{ #category : #elements }
PLC_GraphicElementGroup >> last [

	^ self elements last. 
]

{ #category : #elements }
PLC_GraphicElementGroup >> layoutFirstPinsYDistance [
	"Devuelve la distancia minima en pantalla en Y del primer pin de entrada 
	y salida relativa a la posicion vertical de self .
	Es la distancia vertical entre la parte de arriba del elemento y sus sub elementos y el primer pin."

	^ self maxFirstPinYDistance.

]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutHorizontallyLeft: aDistanceX [
	"Dispone en pantalla todos los elementos internos del grupo de elementos Horizontalmente.
	Este junto con el metodo del mismo nombre en Elemento hace que se pueda crear un composite. 
	Es decir, Grupos que contengan Elementos u oros Grupos."
            
            
	self elements first xPositioned 
		ifFalse: [ 
			self elements first layoutHorizontallyLeft: aDistanceX.
			].
				
	(2 to: self elements size) do: [ :ind |
		( self  elements at: ind ) xPositioned 
			ifFalse: [ 
				( self  elements at: ind ) layoutHorizontallyLeft: ( self  elements at: ind - 1 ) layoutRectangle right.
				].
		].
 
]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutPosition: aPoint [
	"Dispone en pantalla todos los elementos internos del grupo de elementos."

	"Layout horizontal de los elementos interiores."
	self layoutHorizontallyLeft: aPoint x.
	
	"Layout vertical de los elementos interiores"
	self layoutVerticallyTop: aPoint y.
]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutRectangle [
	"Devuelve el layoutRectangle mayor de la coleccion elements
	que contiene una rama serie de elementos."

	^ self layoutRectangleForGroup.
]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutRectangleForGroup [
	"Devuelve el layoutRectangle mayor de la coleccion elements
	que contiene una rama serie de elementos."

	| layoutRectangle elementConnectedToGroup |

	layoutRectangle := self elements inject: self elements first layoutRectangleForGroup
		into: [ :layoutRectangleForGroup :element | 
			layoutRectangleForGroup merge: element layoutRectangleForGroup
			].
	
	"Extiendo layoutRectangle del grupo a derecha. Esto es para que el layoutRectangle del 
	grupo sea el máximo posible a derecha para que acomode bien Contactos y Bloques."	
	"Chequeo si el ultimo del grupo es un RightPowerRail. Si no es modifico el layoutRectangle
	del grupo. "
	self elements last isRightPowerRail
		ifFalse: [ 
			"Busco el elemento conectado al ultimo elementos del grupo"
			elementConnectedToGroup := self elements last blockConnectedToOutput: 1.
			"Extiendo el layoutRectangle del grupo a derecha hasta la izquierda del elemento hallado."
			layoutRectangle := 	Rectangle 
				origin: layoutRectangle origin 
				corner: ( elementConnectedToGroup layoutRectangle left @ layoutRectangle bottom).
			].
		
	"Extiendo layoutRectangle del grupo a izquierda. Esto es para que el layoutRectangle del 
	grupo sea el máximo posible a izquierda para que acomode bien bobinas."			
	"Busco el elemento conectado al primer elemento del grupo"
	elementConnectedToGroup := self elements first blockConnectedToInput: 1.
	"Extiendo el layoutRectangle del grupo a izquierda hasta la derecha del elemento hallado."
	layoutRectangle := 	Rectangle 
		origin: ( elementConnectedToGroup layoutRectangle right @ layoutRectangle top)
		corner: layoutRectangle corner.		
		
	^ layoutRectangle.
]

{ #category : #position }
PLC_GraphicElementGroup >> layoutRectanglePosition [
	"Devuelve la posicion del layoutRectangle.
	Este mensaje es para tener polimorfismo con los elementos graficos."

	^ self layoutRectangle position.
]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutRectangleRelativePosition [
	"Posicion relativa entre el layoutRectangle y el position del elemento"

	^ self elements first topLeft - self layoutRectangle topLeft.
]

{ #category : #layout }
PLC_GraphicElementGroup >> layoutVerticallyTop: aDistanceY [
	"Dispone en pantalla todos los elementos internos del grupo de elementos Verticalmente."

	| firstPinsYPosition top |

	"Busco la mayor altura del primer pin"
	firstPinsYPosition := self maxFirstPinYDistance.
			
	"Asigno la altura hallada a todos los morphs de la misma linea"		
	self elements do: [ :aGraphicElement | 
		aGraphicElement layoutVerticallyTop: aDistanceY + firstPinsYPosition - ( aGraphicElement layoutFirstPinsYDistance ).
		].
]

{ #category : #position }
PLC_GraphicElementGroup >> left [
	"Devuelve su posicion izquierda en X."

	^ self layoutRectangle left.
]

{ #category : #elements }
PLC_GraphicElementGroup >> left: aDistanceX [
	"Cambia la posicion horizontal de sus elementos internos."
	
	self elements do: [ :aGraphicElement | 
		aGraphicElement left: aDistanceX.
		].
]

{ #category : #elements }
PLC_GraphicElementGroup >> maxFirstPinYDistance [
	"Devuelve la maxima distancia minima de sus subelementos."

	"Busco la mayor altura del primer pin"
	^ self elements 
		inject: 0 
		into: [:maxY :aGraphicElement | maxY max: aGraphicElement layoutFirstPinsYDistance ].
]

{ #category : #position }
PLC_GraphicElementGroup >> right [
	"Devuelve su posicion derecha en X."

	^ self layoutRectangle right.
]

{ #category : #position }
PLC_GraphicElementGroup >> right: aDistance [
	"Setea su posicion derecha en X."

	self elements do: [ :elem |
		elem right: aDistance.
		].
]

{ #category : #position }
PLC_GraphicElementGroup >> top [
	"Devuelve su posicion superior en Y."

	^ self layoutRectangle top.
]

{ #category : #elements }
PLC_GraphicElementGroup >> topLeft [
	"Posiciondel primer elemento del grupo."

	^ self elements first topLeft.
]

{ #category : #layout }
PLC_GraphicElementGroup >> xPositioned [
	"Devuelve true si el flag de xPositioned de cada uno de sus elementos es true."
	
	^ self elements allSatisfy: [ :elem |
		elem xPositioned.
		].
]

{ #category : #layout }
PLC_GraphicElementGroup >> xPositioned: aBoolean [
	"Setea a aBoolean el flag de xPositioned de cada uno de sus elementos."
	
	self elements do: [ :elem |
		elem xPositioned: aBoolean.
		].
]

{ #category : #layout }
PLC_GraphicElementGroup >> yPositioned [
	"Devuelve true si el flag de yPositioned de cada uno de sus elementos es true."
	
	^ self elements allSatisfy: [ :elem |
		elem yPositioned.
		].
]

{ #category : #layout }
PLC_GraphicElementGroup >> yPositioned: aBoolean [
	"Setea a aBoolean el flag de yPositioned de cada uno de sus elementos."
	
	self elements do: [ :elem |
		elem yPositioned: aBoolean.
		].
]
