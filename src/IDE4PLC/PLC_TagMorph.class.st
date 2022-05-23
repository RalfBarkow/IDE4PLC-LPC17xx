"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_TagMorph is xxxxxxxxx.

Instance Variables
	graphicElement:		<Object>
	text:		<Object>
	textAlign:		<Object>

graphicElement
	- xxxxx

text
	- xxxxx

textAlign
	- xxxxx

"
Class {
	#name : #'PLC_TagMorph',
	#superclass : #'PLC_GraphicElementMorph',
	#instVars : [
		'text',
		'textAlign',
		'graphicElement'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #'instance creation' }
PLC_TagMorph class >> newWithText: aString [
	"Nuevo con texto asString"

	| graphicElem |
	
	graphicElem := self new.
	
	graphicElem text: aString.
	
	graphicElem extentChanged.
	
	Transcript show: graphicElem extent asString.
	
	"Lo posiciono fuera del ladderView para que no moleste cuando
	hago layout"
	graphicElem position: graphicElem position - graphicElem layoutRectangle extent.
	
	^ graphicElem.
	
]

{ #category : #extent }
PLC_TagMorph >> backgroundRectangleExtent [
	"Devuelve el tamaño en pixeles del backgroundRectangle."
	
	^ self extent x @ self textLinesExtent y.
]

{ #category : #'align-states' }
PLC_TagMorph >> centerAlign [
	
	self textAlign: PLC_Aligns center.
	self changed.
]

{ #category : #extent }
PLC_TagMorph >> defaultExtent [
	"Tamaño por defecto"
	
	^ self elementWidth @ super defaultExtent y.
]

{ #category : #drawing }
PLC_TagMorph >> drawElementOn: aCanvas [
	"Dibujo el texto"

	| strings |

	strings := self stringsToDraw.
	
	strings do:[ :str |
		"Linea de texto"
		aCanvas	
			drawString: str
			at: (self stringPositionFor: str index: (strings indexOf: str))
			font: TextStyle defaultFont
			color: self userInteractionStateLayer1 textColor.
			
		"Borde delimitador de la linea de texto"
		self properties drawTextLineBorder 
			ifTrue: [
				self drawTextLineBorderOn: aCanvas 
					rectangle: ((self stringPositionFor: str index: (strings indexOf: str)) 
						corner: (self stringPositionFor: str index: (strings indexOf: str)) + str asMorph extent ).
				].

		].
]

{ #category : #drawing }
PLC_TagMorph >> drawTextLineBorderOn: aCanvas rectangle: aRectangle [
	"Borde delimitador de la linea de texto"
			
	aCanvas	
		frameRectangle: aRectangle
		 width: 1
		colors: {Color red}  
		dashes: {1}.
]

{ #category : #extent }
PLC_TagMorph >> elementDoubleWidth [
	"Doble ancho del elemento"

	^ self properties scale x * 184.
]

{ #category : #extent }
PLC_TagMorph >> elementWidth [
	"Ancho estandar del elemento"

	^ self properties scale x * 88.
]

{ #category : #accessing }
PLC_TagMorph >> graphicElement [
	"Devuelve el elemento grafico asociado a la variable, por ejemplo, un contacto, bobina o bloque"

	^ graphicElement.
]

{ #category : #accessing }
PLC_TagMorph >> graphicElement: anObject [ 
	graphicElement := anObject.
]

{ #category : #'initialize-release' }
PLC_TagMorph >> initialize [
	"Inicializo la etiqueta"

	super initialize.

	text := '<???>'.

	self unselected;			"drawingLayer1"
		notKeyboardFocus.		"drawingLayer3"

	PLC_Aligns initialize.
	self textAlign: PLC_Aligns center.
		
	self extentChanged;
		color: Color white;
		openInWorld.
]

{ #category : #extent }
PLC_TagMorph >> layoutRectangleExtent [
	"Devuelve el tamaño en pixeles del layoutRectangle."
	
	^ self extent + (self properties scale * ( 8 @ 0 ) ).
]

{ #category : #position }
PLC_TagMorph >> layoutRectanglePosition [
	"Devuelve la posición en pantalla del layoutRectangle relativa a position del elemento [px]."
	
	^ self properties scale * ( -4 @ 0 ).
]

{ #category : #'align-states' }
PLC_TagMorph >> leftAlign [
	
	self textAlign: PLC_Aligns left.
	self changed.
]

{ #category : #margin }
PLC_TagMorph >> leftMargin [
	"Retorna el margen izquierdo del texto con respecto al elemento."
	
	^ 0.
]

{ #category : #extent }
PLC_TagMorph >> lineSpacing [
	"Alto de interlineado del texto. Es decir, tamaño de separacion entre lineas."
 
	^ self properties scale y * 4.
]

{ #category : #drawing }
PLC_TagMorph >> numberOfLines [
	"Devuelve el numero de lineas de texto"

	^ self stringsToDraw size.
]

{ #category : #'align-states' }
PLC_TagMorph >> rightAlign [
	
	self textAlign: PLC_Aligns right.
	self changed.
]

{ #category : #margin }
PLC_TagMorph >> rightMargin [
	"Retorna el margen derecho del texto con respecto al elemento."
	
	^ 0.
]

{ #category : #drawing }
PLC_TagMorph >> stringPositionFor: aString index: aNumber [
	"Dibujo el texto"

	| x y |
		
	x:= (self textAlign) txtPositionXFor: aString in: self.
	y := self position y + 2 + ( ( self textLineHeight + self lineSpacing ) * (aNumber-1) ).	
						"2= self top margin"
		
	^  x @ y.
]

{ #category : #drawing }
PLC_TagMorph >> stringsToDraw [
	"Devuelve una Ordered collection con los strings haciendo wrap al contenedor."
	
	"CAMBIAR ESPACIOS POR UNDERLINES: _ para la detecion de como wrapear, OJO con TRIM "

	| string character words wordsWrap stringAcum stringTemp strings stream |
	
	string := self text.
	
	" 1) Separo en palabras."
	
	words := string findTokens: ' '.	"95 - underline"		"32 - space"	"13 - cr"	" 9  - tab"	"10 - line feed"	"12 - form feed"
	(1 to: words size - 1) do: [ :index | 
		words at: index put: ( (words at: index) , ' ' ).
		].
	
	 " 2) Corto las palabras largas."
	
wordsWrap := OrderedCollection new.
	words do: [ :eachWord |
		(eachWord trimRight asMorph extent x <= self textWidth)
			ifTrue:[
				wordsWrap add: eachWord.
				]
			ifFalse:[
				stringAcum :=''.
				stringTemp :=''.	
				stream := eachWord readStream.
				eachWord size timesRepeat: [
					character := stream next.
					stringAcum := stringAcum , character asString.
					(stringAcum asMorph extent x <= self textWidth)
						ifTrue:[
							stringTemp := stringAcum.
							]
						ifFalse:[
							wordsWrap add: stringTemp.
							stringTemp := character asString.
							stringAcum := stringTemp.
							].
					].
				wordsWrap add: stringTemp.
				].
		].
wordsWrap.
	
	
	" 3) Junto las palabras que pueda por linea."
	
	strings := OrderedCollection new.
	stringAcum :=''.
	stringTemp :=''.

	wordsWrap do: [ :eachWordWrap |
		stringAcum := stringTemp ,  eachWordWrap.
		
		(stringAcum trimRight asMorph extent x <= self textWidth) 	"el trimRight es para sacarle el ultimo espacio a derecha para ver si entra sin ese espacio"
			ifTrue:[
				stringTemp := stringAcum.
				]
			ifFalse:[.
				strings add: stringTemp trimRight.
				stringTemp := eachWordWrap.
				stringAcum := ''.
				].
		].
	strings add: stringTemp trimRight.
	
	^ strings.
]

{ #category : #extent }
PLC_TagMorph >> tagHeight [
	"Alto  de una linea de texto mas sus margenes superior e inferior."
 
	^ self textLineHeight + self lineSpacing
]

{ #category : #text }
PLC_TagMorph >> text [
	^ text
]

{ #category : #text }
PLC_TagMorph >> text: anObject [
	text := anObject.
	
	self extentChanged.
]

{ #category : #text }
PLC_TagMorph >> textAlign [
	^ textAlign
]

{ #category : #text }
PLC_TagMorph >> textAlign: anObject [
	textAlign := anObject
]

{ #category : #extent }
PLC_TagMorph >> textLineExtent [
	"Tamaño de una linea de texto"

	^ self textWidth @ self textLineHeight.
]

{ #category : #extent }
PLC_TagMorph >> textLineHeight [
	"Alto  de una linea de texto"
 
	^ self properties scale y * 14. "Aca deberia calcularlo segun el tamaño de al fuente ejemplo: texto asMorph height"
]

{ #category : #extent }
PLC_TagMorph >> textLinesExtent [
	"Tamaño de todas las lineas de texto juntas."

	^ ( (self textLineExtent + self lineSpacing) * (1 @ self numberOfLines) ) - self lineSpacing.
]

{ #category : #extent }
PLC_TagMorph >> textLinesMaxWidth [
	"Devuelve el mayor ancho de linea de texto entre sus lineas de texto."

	^ self stringsToDraw 
		inject: 0
		into: [ :acum :each | 
			acum max: each asMorph extent x.
			].
]

{ #category : #extent }
PLC_TagMorph >> textWidth [
	"Ancho de la linea de texto"

	^ self extent x - self leftMargin - self rightMargin. 
]

{ #category : #extent }
PLC_TagMorph >> totalExtent [
	"Devuelve el tamaño total del elemento. Es el tamaño total del Morph.
	Ningún elemento puede pisar este área de otro elemento."
	
	^ self extent x @ ( self textLinesExtent y + self lineSpacing).
]
