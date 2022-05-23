"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU_Declarations_Editor is xxxxxxxxx.

Instance Variables
	borderColor:		<Object>
	color:		<Object>
	keyboardFocusMorph:		<Object>
	pouDeclarations:		<Object>
	pouDeclarationsView:		<Object>
	selectedIndex:		<Object>
	titleColor:		<Object>
	titleName:		<Object>

borderColor
	- xxxxx

color
	- xxxxx

keyboardFocusMorph
	- xxxxx

pouDeclarations
	- xxxxx

pouDeclarationsView
	- xxxxx

selectedIndex
	- xxxxx

titleColor
	- xxxxx

titleName
	- xxxxx

"
Class {
	#name : #'PLC_POU_Declarations_Editor',
	#superclass : #Object,
	#instVars : [
		'selectedIndex',
		'keyboardFocusMorph',
		'pouDeclarations',
		'pouDeclarationsView',
		'color',
		'borderColor',
		'titleColor',
		'titleName'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'instance creation' }
PLC_POU_Declarations_Editor class >> newWithPOUDeclarations: aPOUDecls andColor: aColor andBorderColor: aBorderColor andTitleColor: aTitleColor andTitleName: aTitleName [
	"Nueva instancia con cierto modelo de cuerpo de pou y colores"

	| pouDeclsEditor |

	"pouDeclsEditor es un Controlador"	
	pouDeclsEditor := self new.
	
	"Seteo su Modelo"
	pouDeclsEditor pouDeclarations: aPOUDecls.
	
	"Seteo los colores de su Vista"
	pouDeclsEditor color: aColor.
	pouDeclsEditor borderColor: aBorderColor.
	pouDeclsEditor titleColor: aTitleColor.
	"Seteo el titulo de la vista"
	pouDeclsEditor titleName: aTitleName.
	
	^ pouDeclsEditor
]

{ #category : #'declarations Commands' }
PLC_POU_Declarations_Editor >> addButtonClick [  
	"Este comando modifica el modelo añadiendo una nueva declaracion de variable"

	| decl |

	self keyboardFocusMorph
		ifNotNil: [ 
			decl := pouDeclarations inputVarDecls detect: [ 
					self keyboardFocusMorph morpAt: self keyboardFocusMorph selectedIndex ] 
				ifNone: [].
			decl variableCategory remove: decl.
			
			
			"Refresca la vista"
			self refreshKeyboardFocusMorph.
			].
	


	
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> borderColor [
	
	^ borderColor
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> borderColor: anObject [
	
	borderColor := anObject
]

{ #category : #'variable editor' }
PLC_POU_Declarations_Editor >> buildDeclsView [
	"Construye la vista y se la asigna a su variable de instancia pouDeclarationsView para recordarla"
	
	| scroller gridMorph exp1 exp2 eg1 | 
	
	"scroller := ( self builder newScrollPaneFor: ladderView ) 
		hResizing: #spaceFill; 
		vResizing: #spaceFill."

	"morph1 := (PanelMorph new fillStyle: (SolidFillStyle color: Color red))
		hResizing: #spaceFill;
		vResizing: #spaceFill."
		
	gridMorph := self interfaceVarsGridMorph.
	gridMorph editor: self.
	gridMorph controller: self.
	gridMorph identifier: 'interfaceVarsGridMorph'.
	self keyboardFocusMorph: gridMorph.
		
		
	scroller := ( self builder newScrollPaneFor: gridMorph ) 
		hResizing: #spaceFill; 
		vResizing: #spaceFill.

	exp1 := ( self builder newExpander: 'Variables de interfaz' for: scroller ) 
		spaceFillWeight: ProportionalSplitterMorph splitterWidth;
		expanded: true.
	
	eg1 := EdgeGripMorph new
		target: exp1;
		edgeName: #bottom;
		vResizing: #rigid;
		extent: 24 @ 1;
		on: #mouseDown send: #expandedSizingRigid to: exp1.
		

		
	gridMorph := self nonIinterfaceVarsGridMorph.
	gridMorph editor: self.
	gridMorph controller: self.
	gridMorph identifier: 'nonIinterfaceVarsGridMorph'.
		
	scroller := ( self builder newScrollPaneFor: gridMorph ) 
		hResizing: #spaceFill; 
		vResizing: #spaceFill.

	exp2 := ( self builder newExpander: 'Variables Internas y Externas' for: scroller ) 
		spaceFillWeight: ProportionalSplitterMorph splitterWidth;
		expanded: false.
	
	pouDeclarationsView := self builder 
		newColumn: { 
			self pouVarTitle.
			self variableToolBar.
			exp1. 
			eg1. 
			exp2.
			}.
	
	pouDeclarationsView cellInset: 0;
		extent: 732 @ 60.
		
	^ pouDeclarationsView.		
		
	
	

]

{ #category : #view }
PLC_POU_Declarations_Editor >> builder [
	"Devuelve el builder"

	^ UITheme builder.
]

{ #category : #view }
PLC_POU_Declarations_Editor >> clearView [
	"Elimina la Vista"

	pouDeclarationsView := nil.
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> color [
	
	^ color
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> color: anObject [
	
	color := anObject
]

{ #category : #'open/close' }
PLC_POU_Declarations_Editor >> imageFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ self proyectFilesPath , 'imagenes/'."
	^ ''.
]

{ #category : #view }
PLC_POU_Declarations_Editor >> interfaceVarsGridMorph [
	"Devuelve el morph grid con sus rows"

	^ PLC_Grid newWithRows: self interfaceVarsGridMorphRows.
]

{ #category : #view }
PLC_POU_Declarations_Editor >> interfaceVarsGridMorphRows [
	"Devuelve el contenido del gridMorph"
	
	| decls rows col |
	
	rows := OrderedCollection new.
	col := OrderedCollection new.
	
	decls := pouDeclarations inputVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].
	
	decls := pouDeclarations inOutVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].
	
	decls := pouDeclarations outputVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].

	^ rows.
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> keyboardFocusMorph [
	
	^ keyboardFocusMorph
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> keyboardFocusMorph: anObject [
	
	keyboardFocusMorph := anObject
]

{ #category : #view }
PLC_POU_Declarations_Editor >> nonIinterfaceVarsGridMorph [
	"Devuelve el morph grid con sus rows"

	^ PLC_Grid newWithRows: self nonIinterfaceVarsGridMorphRows.
]

{ #category : #view }
PLC_POU_Declarations_Editor >> nonIinterfaceVarsGridMorphRows [
	"Devuelve  el contenido del grid morph"
	
	| decls rows col |
	
	rows := OrderedCollection new.
	col := OrderedCollection new.
	
	decls := pouDeclarations varDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].
	
	decls := pouDeclarations tempVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].
	
	decls := pouDeclarations constantVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].
	
	decls := pouDeclarations externVarDecls.
	decls do: [ :decl |
		"Junto los valores de columnas de una fila"
		col add:  'VAR' , decls varType.
		col add: decl identifier.
		col add: decl dataType ilCompile.
		col add: decl initialValue ilCompile.
		col add: decl description.
		
		"Las agrego a la fila"
		rows add: col.
		
		"Reseteo la Columna antes de la proxima iteracion"
		col := OrderedCollection new.
		].

	^ rows.
]

{ #category : #'open/close' }
PLC_POU_Declarations_Editor >> open [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Editor de Declaraciones de Variables de POU' ) model: nil.
	
	"Agrego el editor de variables"
	window addMorph: self pouDeclarationsView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.5 )
			offsets: ( 0@0 corner: 1@0 )
		).
	"Agrego el editor de ladder"
	"window addMorph: self ladderPouBodyEditor fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		).	"	
		
	window updatePaneColors.
	window extent: 800@600.
	
	aWorld := Morph new currentWorld.
	aWorld addMorph: window.
	
	window activate.
	
	aWorld startSteppingSubmorphsOf: window.

	^ window.


		"(builder newLabel: 'Nombre')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			color: Color white; 
			minHeight: 50;
			minWidth: 200.	"	

	" VAR DECLS ES UNA COLUMNA
	
	varDecls := self builder newColumn: {
		self variableToolBar. 		
		self globalVarTitle.
		self globalVarTitles.
		self globalVarLists. 		
		self locatedVarTitle.
		self locatedVarTitles.
		self locatedVarLists.
	}.
	
	varDecls cellInset: 0;
		minHeight: 10;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		cellSpacing: 10

	(builder newPluggableDialogWindow: 'Titulo' for: content)
		extent: 800@600; 
		 openInWorld."

	"(varDecls openInWindowLabeled: 'Contactos') 
		extent: 800@600."
	
	"varDeclsContainer := PluggablePanelMorph new.
	varDeclsContainer addMorph: varDecls."
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> pouDeclarations [
	
	^ pouDeclarations
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> pouDeclarations: anObject [
	
	pouDeclarations := anObject
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> pouDeclarationsView [
	"Devuelve una vista de pouBody si no existia la crea"

	pouDeclarationsView ifNil: [ 
		self buildDeclsView
		].
		
	^pouDeclarationsView
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> pouVarMorph [
	"devuelve un PLC_TitleMorph"

	| titleMorph |

	titleMorph := PLC_TitleMorph new.
	titleMorph extent: 780@30.
	titleMorph backgroundColor: PLC_GraphicElementProperties uniqueInstance programHeaderColor.
	titleMorph backgroundBorderWidth: 1.
	titleMorph leftMargin: 10.
	titleMorph emphasis: 1.
	titleMorph text: 'Declaraciones de variables de POU'.
	titleMorph leftAlign.
	titleMorph changed.
	
	^ titleMorph.
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> pouVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self pouVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
	

]

{ #category : #'open/close' }
PLC_POU_Declarations_Editor >> projectFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ 'D:/Proyecto/Pharo-1.3-13315-OneClick.app/Contents/Resources/PLeriC'."
	^ ''.
]

{ #category : #'declarations Commands' }
PLC_POU_Declarations_Editor >> refreshKeyboardFocusMorph [
	"Refresco la Vista, primero le cambio su rows por el nuevo contenido"

	(self keyboardFocusMorph identifier = 'interfaceVarsGridMorph')	
		ifTrue: [ 
			self keyboardFocusMorph  rows: self interfaceVarsGridMorphRows.
			]
		ifFalse: [ 
			self keyboardFocusMorph  rows: self nonIinterfaceVarsGridMorphRows.	
			].	
	self keyboardFocusMorph refresh.
]

{ #category : #'declarations Commands' }
PLC_POU_Declarations_Editor >> removeButtonClick [  
	"Este comando modifica el modelo eliminando la declaracion de variable seleccionada"

	| decl |

	self keyboardFocusMorph
		ifNotNil: [ 
			decl := pouDeclarations inputVarDecls declarations detect: [ 
					self keyboardFocusMorph morpAt: self keyboardFocusMorph selectedIndex ] 
				ifNone: [].
			decl variableCategory remove: decl.
			
			
			"Refresca la vista"
			self refreshKeyboardFocusMorph.
			].
	


	
]

{ #category : #'declarations Commands' }
PLC_POU_Declarations_Editor >> textChangedInView: aPoint by: aString [
	"Recivo de la vista (gridMorph) un punto (fila@columna) y el texto para  modificar el modelo"

	| gridRowNumber gridColNumber decls |

	gridRowNumber := aPoint x.
	gridColNumber := aPoint y.
	
	decls := OrderedCollection new.
	
	"Aca decido si es el grid de las variables de interfaz o el otro.
	Y agrego a la OC decls todas las declaraciones de variables en 
	el mismo orden que estan en los grid."
	(self keyboardFocusMorph identifier = 'interfaceVarsGridMorph')	
		ifTrue: [ 
			decls addAll: pouDeclarations inputVarDecls.
			decls addAll: pouDeclarations inOutVarDecls.
			decls addAll: pouDeclarations outputVarDecls.
			]
		ifFalse: [ 
			decls addAll: pouDeclarations varDecls.
			decls addAll: pouDeclarations tempVarDecls.
			decls addAll: pouDeclarations constantVarDecls.	
			decls addAll: pouDeclarations externVarDecls.			
			].
	
	"Aca habría que cambiar la categoría"
	(gridColNumber = 1)
		ifTrue: [ 
			
			].
	
	"Aca habría que cambiar el nombre"
	(gridColNumber = 2)
		ifTrue: [ 
			( decls at: gridRowNumber ) identifier: aString.
			].

	"Aca habría que cambiar el Tipo"
	(gridColNumber = 3)
		ifTrue: [ 
			"Tengo que esctibir de la forma Bool o Int, etc."
			( decls at: gridRowNumber ) dataType: (PLC_DataType perform: aString asSymbol) .
			"Tengo que refrescar tambien el valor inicial"
			( decls at: gridRowNumber ) initialValue: ( decls at: gridRowNumber ) dataType initialValue.
			].

	"Aca habría que cambiar el Valor Inicial"
	(gridColNumber = 4)
		ifTrue: [ 
			"aString Parseado pedorramente - Es true, false o numero"
			( ( decls at: gridRowNumber ) dataType = PLC_DataType Bool )
				ifTrue: [
					( decls at: gridRowNumber ) initialValue: ( 
						PLC_Literal 
							newWithDataType: ( decls at: gridRowNumber ) dataType 
							andDataValue: 
								( (aString = 'true') or: [(aString = 'True') or: [aString = 'TRUE'] ] ) 
						).
					]
				ifFalse: [
					( decls at: gridRowNumber ) initialValue: ( 
						PLC_Literal 
							newWithDataType: ( decls at: gridRowNumber ) dataType 
							andDataValue: aString asNumber
						).
					].
			].	

	"Aca habría que cambiar la Descripción"
	(gridColNumber = 5)
		ifTrue: [ 
			( decls at: gridRowNumber ) description: aString.
			].
		
		
		
	"Refresco la Vista, primero le cambio su rows por el nuevo contenido"
	self refreshKeyboardFocusMorph.
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> titleColor [
	
	^ titleColor
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> titleColor: anObject [
	
	titleColor := anObject
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> titleName [
	
	^ titleName
]

{ #category : #accessing }
PLC_POU_Declarations_Editor >> titleName: anObject [
	
	titleName := anObject
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> varTitleColor [
	"Genera la fila"
	
	^ Color gray.
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> varTitleEmphasis [
	""
	
	^ 0.
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> varTitlesColor [
	"Color"
	
	^ PLC_GraphicElementProperties uniqueInstance rowColorHeader.
]

{ #category : #'variable editor - style' }
PLC_POU_Declarations_Editor >> varTitlesEmphasis [
	""
	
	^ 1.
]

{ #category : #'variable editor - events' }
PLC_POU_Declarations_Editor >> variableSelectedIndex [
	^ selectedVariableIndex ifNil: [selectedVariableIndex := 0]
]

{ #category : #'variable editor - events' }
PLC_POU_Declarations_Editor >> variableSelectedIndex: aSmallInteger [ 
	selectedVariableIndex := aSmallInteger.
	self 
		changed: #variableSelectedIndex;
  		changed: #hasSelectedVariable
		
]

{ #category : #'variable editor' }
PLC_POU_Declarations_Editor >> variableToolBar [
	"Genera la fila"

	^ self builder newRow: {
		self builder newButtonFor: self 
			action: #addButtonClick 
			label: 'Añadir Declaración de Variable' 
			help: 'Abre el dialogo para añadir una Declaración de Variable.'.				
		self builder newButtonFor: self 
			action: #removeButtonClick 		
			label: 'Remover Declaración de Variable' 
			help: 'Remueve la Declaración de Variable seleccionada.'.
		}.
]
