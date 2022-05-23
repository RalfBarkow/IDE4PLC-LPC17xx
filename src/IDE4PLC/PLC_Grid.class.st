"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Grid is xxxxxxxxx.

Instance Variables
	identifier:		<Object>
	morphRows:		<Object>
	pouDeclarations:		<Object>
	rows:		<Object>
	selectedIndex:		<Object>

identifier
	- xxxxx

morphRows
	- xxxxx

pouDeclarations
	- xxxxx

rows
	- xxxxx

selectedIndex
	- xxxxx

"
Class {
	#name : #'PLC_Grid',
	#superclass : #'PLC_View',
	#instVars : [
		'rows',
		'morphRows',
		'selectedIndex',
		'pouDeclarations',
		'identifier'
	],
	#category : #'IDE4PLC-Networks'
}

{ #category : #'initialize-release' }
PLC_Grid class >> newWithRows: ro [
	"Nuevo con ciertas filas, que adentro tienen columnas"

	| grid |
	
	grid := self new.
	grid rows: ro.
	
	"Regresco la vista"
	grid refresh.	
	
	
	^ grid.
]

{ #category : #cell }
PLC_Grid >> cellExtentCategory [
	"El tamaño de Celda de la columna Categoria"

	^ 108@23
]

{ #category : #cell }
PLC_Grid >> cellExtentDescription [
	"El tamaño de Celda de la columna Descripcion"

	^ 363@23
]

{ #category : #cell }
PLC_Grid >> cellExtentInitialValue [
	"El tamaño de Celda de la columna Valor Inicial"

	^ 99@23
]

{ #category : #cell }
PLC_Grid >> cellExtentName [
	"El tamaño de Celda de la columna Name"

	^ 98@23
]

{ #category : #cell }
PLC_Grid >> cellExtentType [
	"El tamaño de Celda de la columna Tipo de Datos"

	^ 56@23
]

{ #category : #cell }
PLC_Grid >> colNumberFor: aMorph [
	"Devuelve numero de columna donde este ubicado el morph"

	self morphRows do: [ :col |
		(col includes: aMorph)
			ifTrue: [
				^ col indexOf: aMorph
				 ].
		].
	
	^ 1.
]

{ #category : #cell }
PLC_Grid >> colPositions [
	"Es una OC con las posiciones de columnas"

	| colExt |

	colExt := OrderedCollection new.
	
	colExt add: 0.
		
	colExt add: 
		self cellExtentCategory x + 1.
		
	colExt add: 
		self cellExtentCategory x 
		+ self cellExtentName x + 2.
		
	colExt add: 
		self cellExtentCategory x 
		+ self cellExtentName x
		+ self cellExtentType x + 3.
		
	colExt add: 
		self cellExtentCategory x 
		+ self cellExtentName x
		+ self cellExtentType x 
		+ self cellExtentInitialValue x +4.

	^ colExt.
]

{ #category : #cell }
PLC_Grid >> colSize [
	"Devuelve la cantidad de columnas"

	^ self rows first size.
]

{ #category : #cell }
PLC_Grid >> colWidths [
	"Es una OC con los anchos de columnas"

	| colExt |

	colExt := OrderedCollection new.
	
	colExt add: self cellExtentCategory x.
	colExt add: self cellExtentName x.
	colExt add: self cellExtentType x.
	colExt add: self cellExtentInitialValue x.
	colExt add: self cellExtentDescription x.

	^ colExt.
]

{ #category : #cell }
PLC_Grid >> createRowsMorphs [
	"Fila de titulos. Es una OC con los titulos de izquierda a derecha"

	| cellMorph morphCol |
	
	morphRows := OrderedCollection new.
		
	morphCol := OrderedCollection new.
	
	
	( 1 to: self rowSize ) do: [ :rowIndex |
		
		( 1 to: self colSize ) do: [ :colIndex |
			
			cellMorph := PLC_CellMorph newWithText: ( self nameAt: rowIndex at: colIndex ).
			
			cellMorph extent: ( self colWidths at: colIndex ) @ self rowHeight.
			cellMorph color: PLC_GraphicElementProperties uniqueInstance rowColorHeader.
			cellMorph centerAlign.
			cellMorph position: ( self position x + 2 + self colPositions at: colIndex ) 
					@ ( self position y + 2 + ( self rowHeight * (rowIndex ) ) + rowIndex ).		
			cellMorph changed.		
			cellMorph extentChanged.		
			
			morphCol add: cellMorph.
			
			"Lo agrego de submorph"
			self addMorph: cellMorph.
			"Lo agrego al diccionario elementos"
			self elements at: cellMorph put: ( self nameAt: rowIndex at: colIndex ).	
			"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
			self selectedAndKeyboardFocus: cellMorph.				
			
			].
		
			morphRows add: morphCol.
			morphCol := OrderedCollection new.
				
		].

	self extent: ( self extent x @ 
		(rows size + 4 + (rows size + 1 * self rowHeight) ) 
		).

]

{ #category : #cell }
PLC_Grid >> createTitleRowMorphs [
	"Fila de titulos. Es una OC con los titulos de izquierda a derecha"

	| titleMorph |
	
	( 1 to: self titleRowNames size ) do: [ :index |
		index.
		
		titleMorph := PLC_TitleMorph new.
		titleMorph extent: ( self colWidths at: index ) @ self rowHeight ;
			backgroundColor: PLC_GraphicElementProperties uniqueInstance rowColorHeader;
			backgroundBorderWidth: 1;
			leftMargin: 0;
			emphasis: 0;
			text: ( self titleRowNames  at: index );
			centerAlign;
			changed;
			position: ( self position x + self colPositions at: index ) @ self position y + 2.
	
		"Lo agrego de submorph"
		self addMorph: titleMorph.
		"Lo agrego al diccionario elementos"
		self elements at: titleMorph put: ( self titleRowNames  at: index ).	
		"Lo agrego a la lista de seleccionados y le doy el foco del teclado"
		self selectedAndKeyboardFocus: titleMorph.
		
		].
]

{ #category : #accessing }
PLC_Grid >> identifier [
	
	^ identifier
]

{ #category : #accessing }
PLC_Grid >> identifier: anObject [
	
	identifier := anObject
]

{ #category : #'initialize-release' }
PLC_Grid >> initialize [
	"comment stating purpose of message"

	super initialize. "Siempre hay que hacerlo en una subclase de MORPH"
	
	rows := OrderedCollection new.
	selectedIndex := 1.
		
	"Cambio el tamño de la grilla"
	self extent: 732@195.
	"Cambio el color de la grilla"
	self color: PLC_GraphicElementProperties uniqueInstance rowColorSelected.
	"Cambio la posición de la grilla"
	self position: 0@0.
	
]

{ #category : #loop }
PLC_Grid >> leftClick: anEvent [
	"Manejador del evento Click con boton izquiedo del mouse"
	"(click) sent when the mouse button goes up within doubleClickTime."
		
	| submorphUnderCursor rowNumber |	
		
	anEvent hand newKeyboardFocus: self. "Le doy al Network Morph el foco del teclado."
	self gotKeyboardFocus.

	submorphUnderCursor := self submorphUnderCursor: anEvent.
	
	"self lostKeyboardFocus."

	submorphUnderCursor
		ifNil: [
			self unselectAll.	 "Pasa todos a la lista de deseleccionados y actualiza los estados de los elementos graficos."					
			]		
		ifNotNil: [
			self unselectAll.	 "Pasa todos a la lista de deseleccionados y actualiza los estados de los elementos graficos."
			rowNumber := self rowNumberFor: submorphUnderCursor.
			
			self selectedAndKeyboardFocus: submorphUnderCursor.	
				
			(self morphsAt: rowNumber) do: [ :each |
				self addSelectedAndKeyboardFocus: each 
				].		
			
			self selectedIndex: rowNumber.
					
			].
		
	self changed.

]

{ #category : #cell }
PLC_Grid >> morphAt: rowNumber at: colNumber [
	"Devuelve el morph de la celda ubicada en la fila: rowNumber columna: colNumber"

	^ ( self morphRows at: rowNumber ) at: colNumber.
]

{ #category : #accessing }
PLC_Grid >> morphRows [
	
	^ morphRows
]

{ #category : #accessing }
PLC_Grid >> morphRows: anObject [
	
	morphRows := anObject
]

{ #category : #cell }
PLC_Grid >> morphsAt: rowNumber [
	"Devuelve una coleccion de morphs de la fila: rowNumber"

	^ ( self morphRows at: rowNumber ).
]

{ #category : #cell }
PLC_Grid >> nameAt: rowNumber at: colNumber [
	"Devuelve el texto que va en la celda ubicada en la fila: rowNumber columna: colNumber"

	^ ( self rows at: rowNumber ) at: colNumber.
]

{ #category : #cell }
PLC_Grid >> positionNumberFor: aMorph [
	"Devuelve numero de fila y columna donde este ubicado el morph"

	^ (self rowNumberFor: aMorph) @ (self colNumberFor: aMorph)
]

{ #category : #accessing }
PLC_Grid >> pouDeclarations [
	
	^ pouDeclarations
]

{ #category : #accessing }
PLC_Grid >> pouDeclarations: anObject [
	
	pouDeclarations := anObject
]

{ #category : #loop }
PLC_Grid >> refresh [
	"Regresco la vista"
		
	super refresh.
	
	"Elimino sus OC de celdas morphs"
	self morphRows: nil.
	
	"Creo las celdas editables Morphs"
	self createTitleRowMorphs.
	self createRowsMorphs.
	
	"Selecciono la ultima fila que había sido seleccionada"
	self unselectAll.
	self selectedAndKeyboardFocus: (self morphsAt: selectedIndex) first. 
	(self morphsAt: selectedIndex) do: [ :each |
		self addSelectedAndKeyboardFocus: each 
		].
	
]

{ #category : #cell }
PLC_Grid >> rowHeight [
	"Devuelve el alto de las filas"

	^ 23.
]

{ #category : #cell }
PLC_Grid >> rowNumberFor: aMorph [
	"Devuelve numero de fila donde este ubicado el morph"

	self morphRows do: [ :col |
		(col includes: aMorph)
			ifTrue: [
				^ self morphRows indexOf: col
				 ].
		].
	
	^ 1.
]

{ #category : #cell }
PLC_Grid >> rowSize [
	"Devuelve la cantidad de filas"

	^ self rows size.
]

{ #category : #accessing }
PLC_Grid >> rows [
	
	^ rows
]

{ #category : #accessing }
PLC_Grid >> rows: anObject [
	
	rows := anObject
]

{ #category : #accessing }
PLC_Grid >> selectedIndex [
	
	^ selectedIndex
]

{ #category : #accessing }
PLC_Grid >> selectedIndex: anObject [
	
	selectedIndex := anObject
]

{ #category : #loop }
PLC_Grid >> textChangedIn: aPLC_CellMorph by: aString [
	"Cambió el texto del morph aPLC_EditaleTagMorph por el del string aString"
	
	"Le cambia el texto. No hace falta refrescar toda la grilla"
	"aPLC_CellMorph text: aString."
	
	
"	Transcript show: (self positionNumberFor: aPLC_CellMorph) asString , '
'."
	
	"Le envio un punto (fila@columna) y el texto al controlador para que modifique el modelo"
	self editor 
		textChangedInView: (self positionNumberFor: aPLC_CellMorph) 
		by: aString.
]

{ #category : #cell }
PLC_Grid >> titleRowNames [
	"Fila de titulos. Es una OC con los titulos de izquierda a derecha"

	| titlesRowOC |

	titlesRowOC := OrderedCollection new.
	
	titlesRowOC add: 'Categoría'.
	titlesRowOC add: 'Nombre'.
	titlesRowOC add: 'Tipo'.
	titlesRowOC add: 'Valor Inicial'.
	titlesRowOC add: 'Descripción'.

	^ titlesRowOC.
]
