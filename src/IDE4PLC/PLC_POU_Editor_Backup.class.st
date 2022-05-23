"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU_Editor_Backup is xxxxxxxxx.

Instance Variables
	keyboardFocusNetwork:		<Object>
	selectedVariableIndex:		<Object>

keyboardFocusNetwork
	- xxxxx

selectedVariableIndex
	- xxxxx

"
Class {
	#name : #'PLC_POU_Editor_Backup',
	#superclass : #Object,
	#instVars : [
		'keyboardFocusNetwork',
		'selectedVariableIndex'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'add-remove' }
PLC_POU_Editor_Backup >> addNetwork [
	"Añade un nuevo segmento a la ventana"
	
	^ 'Se agrego segmento.'
]

{ #category : #'open/close' }
PLC_POU_Editor_Backup >> builder [
	"Devuelve el builder"

	^ UITheme builder.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> descriptionMorph [
	"devuelve un PLC_TitleMorph"

	| descriptionMorph |

	descriptionMorph := PLC_TitleMorph new.
	descriptionMorph extent: 400@20.
	descriptionMorph backgroundColor: self varTitlesColor.
	descriptionMorph backgroundBorderWidth: 1.
	descriptionMorph emphasis: self varTitleEmphasis.
	descriptionMorph text: 'Descripción'.
	descriptionMorph changed.
	
	^ descriptionMorph.
]

{ #category : #'fbd editor' }
PLC_POU_Editor_Backup >> fbdPouBodyEditor [
	"Devuelve la columna con el editor de lenguaje FBD"
	
	"HACER"
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> globalVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> globalVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self globalVarsMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> globalVarsMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@30.
	globalVarsMorph backgroundColor: Color black twiceLighter.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: 1.
	globalVarsMorph text: 'Globales'. "Declaraciones de variables globales"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - events' }
PLC_POU_Editor_Backup >> hasSelectedVariable [
	^selectedVariableIndex > 0
]

{ #category : #'il editor' }
PLC_POU_Editor_Backup >> ilPouBodyEditor [
	"Devuelve la columna con el editor de lenguaje IL"
	
	"HACER"
]

{ #category : #'open/close' }
PLC_POU_Editor_Backup >> imageFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ self proyectFilesPath , 'imagenes/'."
	^ ''.
]

{ #category : #'variable editor - lists' }
PLC_POU_Editor_Backup >> inOutVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> inOutVarMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@25.
	globalVarsMorph backgroundColor: self varTitleColor.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: self varTitleEmphasis.
	globalVarsMorph text: 'Entrada-Salida'. "Declaraciones de variables de Entrada-Salida"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> inOutVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self inOutVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor - lists' }
PLC_POU_Editor_Backup >> inputVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> inputVarMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@25.
	globalVarsMorph backgroundColor: self varTitleColor.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: self varTitleEmphasis.
	globalVarsMorph text: 'Entrada'. "Declaraciones de variables de Entrada"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> inputVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self inputVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> interfaceVarsColumn [
	"Devuelve la columna con el editor de lenguaje Ladder"
	
	| interfaceVarsColumn |
	
	interfaceVarsColumn := self builder newColumn: { 
		self varTitles.
		
		self inputVarTitle.
		self inputVarLists. 	
			
		self outputVarTitle.
		self outputVarLists. 	
			
		self inOutVarTitle.
		self inOutVarLists. 	
	}.
	
	interfaceVarsColumn cellInset: 0;
		extent: 720 @ 20.
		
	^ interfaceVarsColumn.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> internalVarsColumn [
	"Devuelve la columna con el editor de lenguaje Ladder"

	| internalVarsColumn |
	
	internalVarsColumn := self builder newColumn: { 
		
		self varTitles.
		
		self varVarTitle.
		self varVarLists. 
		
		self tempVarTitle.
		self tempVarLists. 	
	}.
	
	internalVarsColumn cellInset: 0;
		extent: 720 @ 20.
		
	^ internalVarsColumn.
]

{ #category : #accessing }
PLC_POU_Editor_Backup >> keyboardFocusNetwork [
	^ keyboardFocusNetwork
]

{ #category : #accessing }
PLC_POU_Editor_Backup >> keyboardFocusNetwork: anObject [
	keyboardFocusNetwork := anObject
]

{ #category : #'ladder editor' }
PLC_POU_Editor_Backup >> ladderPouBodyEditor [
	"Devuelve la columna con el editor de lenguaje Ladder"
	
	| ladderPouBodyEditor controller ladderView scroller expander |

	controller := PLC_LadderController newWithModel: nil.
	
	ladderView := controller openLadderView.

	self keyboardFocusNetwork: ladderView.
		
	scroller := ( self builder newScrollPaneFor: ladderView ) 
		hResizing: #spaceFill; 
		vResizing: #spaceFill.

	expander := ( self builder newExpander: 'Segmento 1'  for: scroller ) 
		spaceFillWeight: 1; 
		expanded: true.

	ladderPouBodyEditor := self builder newColumn: {   
		self ladderPouBodyMorph.
		self ladderToolbar.
		expander.
	}.

	"hResizing: #spaceFill;
	vResizing: #shrinkWrap;
	cellSpacing: 10"	
	
	ladderPouBodyEditor 
		cellInset: 0";
		extent: 720 @ 450".	
					
	^ ladderPouBodyEditor.
					

]

{ #category : #'ladder editor' }
PLC_POU_Editor_Backup >> ladderPouBodyMorph [
	"devuelve un PLC_TitleMorph"

	| titleMorph |

	titleMorph := PLC_TitleMorph new.
	titleMorph extent: 780@30.
	titleMorph backgroundColor: PLC_GraphicElementProperties uniqueInstance programHeaderColor.
	titleMorph backgroundBorderWidth: 1.
	titleMorph leftMargin: 10.
	titleMorph emphasis: 1.
	titleMorph text: 'Cuerpo de POU en lenguaje Ladder'.
	titleMorph leftAlign.
	titleMorph changed.
	
	^ titleMorph.
]

{ #category : #'ladder editor' }
PLC_POU_Editor_Backup >> ladderToolbar [ 
	"Devuelve la barra de herramientas superior de la ventana de edición de Ladder"
	
	| builder |
	
	"^PLC_LadderToolBarMorph new."

	builder := UITheme builder.
	
	^ builder newToolbar: {
		"
		builder
			newButtonFor: self keyboardFocusNetwork ""if we had a model it would go here""
			getState: nil
			action: #drawGroups
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addNetwork.png')
			help: 'Añadir Segmento.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #dfdff
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'removeNetwork.png')
			help: 'Remover Segmento seleccionado.'.
		"
		
		
		
		"builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #ilExport
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'ilExport.png')
			help: 'Exportar Configuracion en IL.'."
			
		builder
			newButtonFor: self keyboardFocusNetwork "if we had a model it would go here"
			getState: nil
			action: #compile
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'compile.png')
			help: 'Compilar.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #bootLPCLink
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'bootLPCLink.png')
			help: 'Conectarse al PLC.'.	
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #downloadProgram
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'downloadProgram.png')
			help: 'Descargar Programa al PLC.'.	
				
				
				
	
	
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #keyCPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addContact.png') 
			help: 'Añadir Contacto.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #keyBPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addCoil.png') 
			help: 'Añadir Bobina.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #keyOPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'openBranch.png') 
			help: 'Abrir Rama.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork
			getState: nil
			action: #keyPPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'closeBranch.png') 
			help: 'Cerrar Rama.'.			
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #keyFPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addFunction.png') 
			help: 'Añadir llamado a Función.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork 
			getState: nil
			action: #keyGPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addFunctionBlock.png') 
			help: 'Añadir llamado a Bloque de Función.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork
			getState: nil
			action: #generateCode
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addProgramControl.png') 
			help: 'Añadir componente de Control de Ejecución.'.
			
		builder
			newButtonFor: self keyboardFocusNetwork
			getState: nil
			action: #keyDeletePressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'removeSelected.png') 
			help: 'Remover componente(s) seleccionado(s).'.
			
			
			
		"
		builder
			newButtonFor: nil ""if we had a model it would go here""
			getState: nil
			action: #openFile
			arguments: nil
			getEnabled: nil
			labelForm: builder theme smallNewIcon
			help: 'Nuevo'.

		builder
			newButtonFor: nil
			getState: nil
			action: #openFile
			arguments: nil
			getEnabled: nil
			labelForm: builder theme smallOpenIcon
			help: 'Abrir'.

		builder
			newButtonFor: nil
			getState: nil
			action: #saveFile
			arguments: nil
			getEnabled: nil
			labelForm: builder theme smallSaveIcon
			help: 'Guardar'.

		builder
			newButtonFor: nil
			getState: nil
			action: #print
			arguments: nil
			getEnabled: nil
			labelForm: builder theme smallPrintIcon
			help: 'Imprimir' 
		" 
	}.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> locatedMorph [
	"devuelve un PLC_TitleMorph"

	| addressMorph |

	addressMorph := PLC_TitleMorph new.
	addressMorph extent: 90@25.
	addressMorph backgroundColor: Color black twiceLighter lighter.
	addressMorph backgroundBorderWidth: 1.
	addressMorph emphasis: 1.
	addressMorph text: 'Ubicación'.
	addressMorph changed.
	
	^ addressMorph.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> locatedVarLists [
	"Genera la fila"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varAddress
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Ubicación de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> locatedVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self locatedVarsMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> locatedVarTitles [
	"Genera la fila"

	| row |

	row := self builder newRow: {
		(self nameMorph)
			hResizing: #spaceFill;
			minWidth: 200.
		(self typeMorph)
			hResizing: #spaceFill;
			minWidth: 90.
		(self locatedMorph)
			hResizing: #spaceFill;
			minWidth: 90.
		(self descriptionMorph)
			hResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> locatedVarsMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@30.
	globalVarsMorph backgroundColor: Color black twiceLighter.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: 1.
	globalVarsMorph text: 'Ubicadas'. "Declaraciones de variables ubicadas 	Variables representadas directamente"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> nameMorph [
	"devuelve un PLC_TitleMorph"

	| nameMorph |

	nameMorph := PLC_TitleMorph new.
	nameMorph extent: 200@20.
	nameMorph backgroundColor: self varTitlesColor.
	nameMorph backgroundBorderWidth: 1.
	nameMorph emphasis: self varTitlesEmphasis.
	nameMorph text: 'Nombre'.
	nameMorph changed.
	
	^ nameMorph.
]

{ #category : #'open/close' }
PLC_POU_Editor_Backup >> open [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window windowExtent aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Editor de Unidad de Organización de Programa (POU)' ) model: nil.
	
	"Agrego el editor de variables"
	window addMorph: self pouVarDeclEditor fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.4 )
			offsets: ( 0@0 corner: 1@0 )
		).
	"Agrego el editor de ladder"
	window addMorph: self ladderPouBodyEditor fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		).		
		
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

{ #category : #Eric }
PLC_POU_Editor_Backup >> openEric [
	"Abre la ventana"

	| content |
		
		"(builder newLabel: 'Nombre')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			color: Color white; 
			minHeight: 50;
			minWidth: 200.	"	

	content := self builder newColumn: {
		self varMenu. 		
		self globalVarTitle.
		self varTitles.
		self globalVarLists. 		
		self locatedVarTitle.
		self locatedVarTitles.
		self locatedVarLists.
	}.

	content cellInset: 0.
		"hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellSpacing: 10."

	"(builder newPluggableDialogWindow: 'Titulo' for: content)
		extent: 800@600; 
		 openInWorld."
	
	 (content openInWindowLabeled: 'Contactos') 
		extent: 800@600.
]

{ #category : #Eric }
PLC_POU_Editor_Backup >> openEric2 [
	"Abre la ventana"

	|builder content variablesRow menu varTitles1 varTitles2 |

	builder := UITheme builder.
	
	menu := builder newRow: {
		builder newButtonFor: self 
			action: #addButtonClick 
			label: 'Añadir' 
			help: 'Crear un contacto nuevo'.				
		builder newButtonFor: self 
			action: #removeButtonClick 		
			label: 'Remover' 
			help: 'Remover contacto selecccionado'.
		builder newButtonFor: self 
			action: #editButtonClick 		
			label: 'Editar' 
			help: 'Editar contacto selecccionado' 
		}.
		
	varTitles1 := builder newRow: {
		(self globalVarsMorph)
			hResizing: #spaceFill.
		}.
		
	varTitles2 := builder newRow: {
		(self nameMorph)
			hResizing: #spaceFill;
			minWidth: 200.
		(self typeMorph)
			hResizing: #spaceFill;
			minWidth: 90.
		(self descriptionMorph)
			hResizing: #spaceFill;
			minWidth: 400.
		}.		
	
	variablesRow := builder newRow: {
		(builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		(builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		(builder 
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
		"(builder newLabel: 'Nombre')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			color: Color white; 
			minHeight: 50;
			minWidth: 200.	"	
	
	varTitles1 cellInset: 0.
	
	varTitles2 cellInset: 0.
	
	variablesRow cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"

	content := builder newColumn: {
		menu.
		varTitles1.
		varTitles2.
		variablesRow.
	}.

	content cellInset: 0.
		"hResizing: #spaceFill;
		vResizing: #spaceFill;
		cellSpacing: 10."

	"(builder newPluggableDialogWindow: 'Titulo' for: content)
		extent: 800@600; 
		 openInWorld."
	
	 (content openInWindowLabeled: 'Contactos') 
		extent: 800@600.
]

{ #category : #Eric }
PLC_POU_Editor_Backup >> openEric3 [
	"Abre la ventana"

	| window windowExtent aWorld varDeclsContainer varDecls pouBody pouBodyContainer |
		
		"(builder newLabel: 'Nombre')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			color: Color white; 
			minHeight: 50;
			minWidth: 200.	"	

	varDecls := self builder newColumn: {
		self varMenu. 		
		self globalVarTitle.
		self varTitles.
		self globalVarLists. 		
		self locatedVarTitle.
		self locatedVarTitles.
		self locatedVarLists.
	}.

	varDecls cellInset: 0;
		minHeight: 10";
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		cellSpacing: 10".

	"(builder newPluggableDialogWindow: 'Titulo' for: content)
		extent: 800@600; 
		 openInWorld."

	
	"(varDecls openInWindowLabeled: 'Contactos') 
		extent: 800@600."
	
	"varDeclsContainer := PluggablePanelMorph new.
	varDeclsContainer addMorph: varDecls."

	varDeclsContainer := varDecls.
	
	pouBody := Morph new.
	pouBodyContainer := pouBody.


	"Creo la ventana y agrego los controles"

	window := ( SystemWindow labelled: 'Ventana' ) model: nil.
		
	window addMorph: varDeclsContainer fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.4 )
			offsets: ( 0@0 corner: 1@0 )
		).
	window addMorph: pouBodyContainer fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		).		
		
	"window updatePaneColors."
	window extent: 800@600.
	
	aWorld := Morph new currentWorld.
	
	aWorld addMorph: window.
	window activate.
	aWorld startSteppingSubmorphsOf: window.

	^ window.
]

{ #category : #Eric }
PLC_POU_Editor_Backup >> openEric4 [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window windowExtent aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Editor de Unidad de Organización de Programa (POU)' ) model: nil.
	
	"Agrego el editor de variables"
	window addMorph: self pouVarDeclEditor fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.4 )
			offsets: ( 0@0 corner: 1@0 )
		).
	"Agrego el editor de ladder"
	window addMorph: self ladderPouBodyEditor fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		).		
		
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

{ #category : #'variable editor - lists' }
PLC_POU_Editor_Backup >> outputVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> outputVarMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@25.
	globalVarsMorph backgroundColor: self varTitleColor.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: self varTitleEmphasis.
	globalVarsMorph text: 'Salida'. "Declaraciones de variables de Salida"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> outputVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self outputVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> pouVarDeclEditor [
	"Devuelve la columna con el editor de lenguaje Ladder"
	
	| pouVarDeclEditor exp1 exp2 eg1 |
		
	"scroller := ( self builder newScrollPaneFor: ladderView ) 
		hResizing: #spaceFill; 
		vResizing: #spaceFill."

	"morph1 := (PanelMorph new fillStyle: (SolidFillStyle color: Color red))
		hResizing: #spaceFill;
		vResizing: #spaceFill."
		
	exp1 := ( self builder newExpander: 'Variables de interfaz' for: self interfaceVarsColumn )
		spaceFillWeight: ProportionalSplitterMorph splitterWidth;
		expanded: true.
	
	eg1 := EdgeGripMorph new
		target: exp1;
		edgeName: #bottom;
		vResizing: #rigid;
		extent: 24 @ 1;
		on: #mouseDown send: #expandedSizingRigid to: exp1.
	
	exp2 := ( self builder newExpander: 'Variables internas'  for: self internalVarsColumn )
		spaceFillWeight: ProportionalSplitterMorph splitterWidth;
		expanded: false.
	
	pouVarDeclEditor := self builder 
		newColumn: { 
			self pouVarTitle.
			self variableToolBar.
			exp1. 
			eg1. 
			exp2.
			}.
	
	pouVarDeclEditor cellInset: 0;
		extent: 720 @ 20.
		
	^ pouVarDeclEditor.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> pouVarMorph [
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

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> pouVarTitle [
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
PLC_POU_Editor_Backup >> projectFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ 'D:/Proyecto/Pharo-1.3-13315-OneClick.app/Contents/Resources/PLeriC'."
	^ ''.
]

{ #category : #'variable editor - lists' }
PLC_POU_Editor_Backup >> tempVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> tempVarMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@25.
	globalVarsMorph backgroundColor: self varTitleColor.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: self varTitleEmphasis.
	globalVarsMorph text: 'Temporales'. "Declaraciones de variables Temporales"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> tempVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self tempVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> typeMorph [
	"devuelve un PLC_TitleMorph"

	| typeMorph |

	typeMorph := PLC_TitleMorph new.
	typeMorph extent: 90@20.
	typeMorph backgroundColor: self varTitlesColor.
	typeMorph backgroundBorderWidth: 1.
	typeMorph emphasis: self varTitlesEmphasis.
	typeMorph text: 'Tipo'.
	typeMorph changed.
	
	^ typeMorph.
]

{ #category : #'PARA EDITOR DE RESOURCE' }
PLC_POU_Editor_Backup >> varAddress [
	
	| col |

	col := OrderedCollection new.
	
	col add: '%I0.0'.
	col add: ''.
	col add: ''.
	col add: ''.
	
	^ col.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> varDescription [
	
	| col |

	col := OrderedCollection new.
	
	col add: 'Variable 1, representa el cambio en la corriente nominal.'.
	col add: 'Variable 2, representa el cambio en la corriente nominal.'.
	col add: 'Variable 3, representa el cambio en la corriente nominal.'.
	col add: 'Variable 4, representa el cambio en la corriente nominal.'.
	
	^ col.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> varInitialValue [
	
	| col |

	col := OrderedCollection new.
	
	col add: '0'.
	col add: '1'.
	col add: '15'.
	col add: '50'.
	
	^ col.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> varName [

	
	| col |

	col := OrderedCollection new.
	
	col add: 'variable1'.
	col add: 'var_2_laaaaarga'.
	col add: 'var3'.
	col add: 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'.

	^ col.
]

{ #category : #'variable editor - style' }
PLC_POU_Editor_Backup >> varTitleColor [
	"Genera la fila"
	
	^ Color gray.
]

{ #category : #'variable editor - style' }
PLC_POU_Editor_Backup >> varTitleEmphasis [
	""
	
	^ 0.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> varTitles [
	"Genera la fila"

	| row |

	row := self builder newRow: {
		(self nameMorph)
			hResizing: #spaceFill;
			minWidth: 200.
		(self typeMorph)
			hResizing: #spaceFill;
			minWidth: 90.
		(self descriptionMorph)
			hResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor - style' }
PLC_POU_Editor_Backup >> varTitlesColor [
	"Color"
	
	^ PLC_GraphicElementProperties uniqueInstance rowColorHeader.
]

{ #category : #'variable editor - style' }
PLC_POU_Editor_Backup >> varTitlesEmphasis [
	""
	
	^ 1.
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> varType [
	
	| col |

	col := OrderedCollection new.
	
	col add: 'Bool'.
	col add: 'Bool'.
	col add: 'Int'.
	col add: 'Int'.
	
	^ col.
]

{ #category : #'variable editor - lists' }
PLC_POU_Editor_Backup >> varVarLists [
	"Genera la fila de Lists de variables"

	| row |

	row := self builder newRow: {
		( self builder 
			newListFor: self   
			list: #varName
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Nombre de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 200.
		( self builder 
			newListFor: self   
			list: #varType
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Tipo de datos de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 90.
		( self builder
			newListFor: self   
			list: #varDescription
			selected: #variableSelectedIndex
			changeSelected: #variableSelectedIndex:
			help: 'Descripción de la Variable')
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			minWidth: 400.
		}.
		
	row cellInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.		"shrinkWrap"
	
	^ row.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> varVarMorph [
	"devuelve un PLC_TitleMorph"

	| globalVarsMorph |

	globalVarsMorph := PLC_TitleMorph new.
	globalVarsMorph extent: 780@25.
	globalVarsMorph backgroundColor: self varTitleColor.
	globalVarsMorph backgroundBorderWidth: 1.
	globalVarsMorph emphasis: self varTitleEmphasis.
	globalVarsMorph text: 'Internas'. "Declaraciones de variables Internas"
	globalVarsMorph changed.
	
	^ globalVarsMorph.
]

{ #category : #'variable editor - titles' }
PLC_POU_Editor_Backup >> varVarTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self varVarMorph)
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'variable editor - events' }
PLC_POU_Editor_Backup >> variableSelectedIndex [
	^ selectedVariableIndex ifNil: [selectedVariableIndex := 0]
]

{ #category : #'variable editor - events' }
PLC_POU_Editor_Backup >> variableSelectedIndex: aSmallInteger [ 
	selectedVariableIndex := aSmallInteger.
	self 
		changed: #variableSelectedIndex;
  		changed: #hasSelectedVariable
		
]

{ #category : #'variable editor' }
PLC_POU_Editor_Backup >> variableToolBar [
	"Genera la fila"

	^ self builder newRow: {
		self builder newButtonFor: self 
			action: #addButtonClick 
			label: 'Añadir Variable' 
			help: 'Abre el dialogo para añadir una variable.'.				
		self builder newButtonFor: self 
			action: #removeButtonClick 		
			label: 'Remover Variable' 
			help: 'Remueve la Variable seleccionada.'.
		self builder newButtonFor: self 
			action: #editButtonClick 		
			label: 'Editar Variable' 
			help: 'Abre el dialogo para editar la Variable seleccionada.'.	
		}.
]
