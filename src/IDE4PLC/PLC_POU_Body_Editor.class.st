"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU_Body_Editor is xxxxxxxxx.

Instance Variables
	borderColor:		<Object>
	color:		<Object>
	keyboardFocusMorph:		<Object>
	pouBody:		<Object>
	pouBodyView:		<Object>
	titleColor:		<Object>
	titleName:		<Object>

borderColor
	- xxxxx

color
	- xxxxx

keyboardFocusMorph
	- xxxxx

pouBody
	- xxxxx

pouBodyView
	- xxxxx

titleColor
	- xxxxx

titleName
	- xxxxx

"
Class {
	#name : #'PLC_POU_Body_Editor',
	#superclass : #Object,
	#instVars : [
		'keyboardFocusMorph',
		'pouBody',
		'pouBodyView',
		'color',
		'borderColor',
		'titleColor',
		'titleName'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'instance creation' }
PLC_POU_Body_Editor class >> newWithPOUBody: aPOUBody andColor: aColor andBorderColor: aBorderColor andTitleColor: aTitleColor andTitleName: aTitleName [
	"Nueva instancia con cierto modelo de cuerpo de pou y colores"

	| pouBodyEditor |

	"pouBodyEditor es un Controlador"	
	pouBodyEditor := self new.
	
	"Seteo su Modelo"
	pouBodyEditor pouBody: aPOUBody.
	
	"Seteo los colores de su Vista"
	pouBodyEditor color: aColor.
	pouBodyEditor borderColor: aBorderColor.
	pouBodyEditor titleColor: aTitleColor.
	"Seteo el titulo de la vista"
	pouBodyEditor titleName: aTitleName.
	
	^ pouBodyEditor
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addCoilPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyBPressed
			 ]




]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addFunctionBlockPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyGPressed
			 ]



]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addFunctionPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyFPressed
			 ]
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addLadderComponentPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			"self keyboardFocusMorph keyQPressed"
			 ]	

 
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addNOContactPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyCPressed
			]

]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> addNetwork [
	"Este comando modifica el modelo eliminando la network con el foco del teclado"

	pouBody addNetwork
	
	"Falta, tiene que redibujar todo el editor"
]

{ #category : #accessing }
PLC_POU_Body_Editor >> borderColor [
	
	^ borderColor
]

{ #category : #accessing }
PLC_POU_Body_Editor >> borderColor: anObject [
	
	borderColor := anObject
]

{ #category : #'ladder editor' }
PLC_POU_Body_Editor >> buildLadderView [
	"Construye la vista y se la asigna a su variable de instancia pouBodyView para recordarla"
	
	| controller networkModel ladderView scroller expander controls | 
	
	
	"Creo la colección de controls que despues se pasa a la columna morph como array"
	controls := OrderedCollection new.
	
	"Agrego la barra de herramientas"
	controls add: self pouLadderTitle.
	controls add: self ladderToolbar.
	
	
	"Crequeo que haya al menos una network"
	( self pouBody networks size > 0 )
		ifTrue: [ 
			"networkModel es el modelo de network ladder"
			networkModel := pouBody networks at: 1.
	
			"Controlador de la network Ladder"
			controller := PLC_LadderController newWithModel: networkModel. 
		
			"Vista de la network Ladder"
			ladderView := controller openLadderView.
	
			"Le agrego a la vista de network ladder una referencia a 
			este controlador editor de cuerpod e pou"
			ladderView editor: self.
	
			"A la primera network le doy el foco del teclado"
			self keyboardFocusMorph: ladderView.
	
			"Le creo los scroller al ladderView"
			scroller := ( self builder newScrollPaneFor: ladderView ) 
				hResizing: #spaceFill; 
				vResizing: #spaceFill.

			"Le creo el expander sobre los scroller al ladderView"
			expander := ( self builder newExpander: 'Segmento 1'  for: scroller ) 
				spaceFillWeight: 1; 
				expanded: true.	
	
			"Agrego el expander a la colección que forma la columna"
			controls add: expander.
			
			]. 	
	

	"Repito todos los pasos anteriores para als demas networks salvo que no 
	les agrego el foco del teclado ni expando sus expanders"
	(2 to: pouBody networks size) do: [ :index |
		
		"networkModel es el modelo de network ladder"
		networkModel := pouBody networks at: index.
		
		"Controlador de la network Ladder"
		controller := PLC_LadderController newWithModel: networkModel. 
		
		"Vista de la network Ladder"
		ladderView := controller openLadderView.
	
		"Le agrego a la vista de network ladder una referencia a 
		este controlador editor de cuerpod e pou"
		ladderView editor: self.
		
		"Le creo los scroller al ladderView"
		scroller := ( self builder newScrollPaneFor: ladderView ) 
			hResizing: #spaceFill; 
			vResizing: #spaceFill.

		"Le creo el expander sobre los scroller al ladderView"
		expander := ( self builder newExpander: 'Segmento ' , index asString for: scroller ) 
			spaceFillWeight: 1; 
			expanded: false.	
				
		"Agrego el expander a la colección que forma la columna"
		controls add: expander.
		 ].



	"Creo la columna morph"
	pouBodyView := self builder newColumn: controls asArray.
	"hResizing: #spaceFill;
	vResizing: #shrinkWrap;
	cellSpacing: 10"	

	pouBodyView 
		cellInset: 0";
		extent: 720 @ 450".	
			
					
	^ pouBodyView.	
	
	

]

{ #category : #view }
PLC_POU_Body_Editor >> builder [
	"Devuelve el builder"

	^ UITheme builder.
]

{ #category : #view }
PLC_POU_Body_Editor >> clearView [
	"Elimina la Vista"

	pouBodyView := nil.
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> closeBranchPressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyPPressed
			]

]

{ #category : #accessing }
PLC_POU_Body_Editor >> color [
	
	^ color
]

{ #category : #accessing }
PLC_POU_Body_Editor >> color: anObject [
	
	color := anObject
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> deletePressed [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyDeletePressed 
			]




]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> drawGroups [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph drawGroups 
			]




]

{ #category : #'fbd editor' }
PLC_POU_Body_Editor >> fbdPouBodyEditor [
	"Devuelve la columna con el editor de lenguaje FBD"
	
	"HACER"
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> generateCode [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph generateCode 
			]




]

{ #category : #'il editor' }
PLC_POU_Body_Editor >> ilPouBodyEditor [
	"Devuelve la columna con el editor de lenguaje IL"
	
	"HACER"
]

{ #category : #'open/close' }
PLC_POU_Body_Editor >> imageFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	^ 'IDE4PLC_files/GUI_Images/pouEditorToolbar/'.
]

{ #category : #accessing }
PLC_POU_Body_Editor >> keyboardFocusMorph [
	"EN ESTE CASO ES UNA NETWORK"
	
	^ keyboardFocusMorph
]

{ #category : #accessing }
PLC_POU_Body_Editor >> keyboardFocusMorph: anObject [
	keyboardFocusMorph := anObject
]

{ #category : #'ladder editor' }
PLC_POU_Body_Editor >> ladderPouBodyMorph [
	"devuelve un PLC_TitleMorph"

	| titleMorph |

	titleMorph := PLC_TitleMorph new.
	titleMorph extent: 780@30.
	titleMorph backgroundColor: self titleColor.
	titleMorph backgroundBorderWidth: 1.
	titleMorph leftMargin: 10.
	titleMorph emphasis: 1.
	titleMorph text: self titleName.
	titleMorph leftAlign.
	titleMorph changed.
	
	^ titleMorph.
]

{ #category : #'ladder editor' }
PLC_POU_Body_Editor >> ladderToolbar [ 
	"Devuelve la barra de herramientas superior de la ventana de edición de Ladder"
	
	| builder |
	
	"^PLC_LadderToolBarMorph new."

	builder := UITheme builder.
	
	^ builder newToolbar: {
		
		builder
			newButtonFor: self "if we had a model it would go here"
			getState: nil
			action: #addNetwork "drawGroups"
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addNetwork.png')
			help: 'Añadir Segmento.'.
			
		builder
			newButtonFor: self
			getState: nil
			action: #removeNetwork
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'removeNetwork.png')
			help: 'Remover Segmento seleccionado.'.	
	
		builder
			newButtonFor: self
			getState: nil
			action: #addNOContactPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addContact.png') 
			help: 'Añadir Contacto.'.
			
		builder
			newButtonFor: self 
			getState: nil
			action: #addCoilPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addCoil.png') 
			help: 'Añadir Bobina.'.
			
		builder
			newButtonFor: self 
			getState: nil
			action: #openBranchPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'openBranch.png') 
			help: 'Abrir Rama.'.  
			
		builder
			newButtonFor: self
			getState: nil
			action: #closeBranchPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'closeBranch.png') 
			help: 'Cerrar Rama.'.			
			
		builder
			newButtonFor: self
			getState: nil
			action: #addLadderComponentPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addLadderComponent.png') 
			help: 'Añadir componente Ladder.'.	
			
		builder
			newButtonFor: self
			getState: nil
			action: #addFunctionPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addFunction.png') 
			help: 'Añadir llamado a Función.'.
			
		builder
			newButtonFor: self
			getState: nil
			action: #addFunctionBlockPressed
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addFunctionBlock.png') 
			help: 'Añadir llamado a Bloque de Función.'.
			
		builder
			newButtonFor: self
			getState: nil
			action: #generateCode
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addProgramControl.png') 
			help: 'Añadir componente de Control de Ejecución.'.
			
		builder
			newButtonFor: self
			getState: nil
			action: #deletePressed
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

{ #category : #'open/close' }
PLC_POU_Body_Editor >> open [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Cuerpo de POU' ) model: nil.
	
	"Agrego el editor de ladder"
	window addMorph: self pouBodyView fullFrame: (
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

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> openBranchPressed [ 
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph keyOPressed
			]

 
]

{ #category : #accessing }
PLC_POU_Body_Editor >> pouBody [
	
	^ pouBody
]

{ #category : #accessing }
PLC_POU_Body_Editor >> pouBody: anObject [
	
	pouBody := anObject
]

{ #category : #accessing }
PLC_POU_Body_Editor >> pouBodyView [
	"Devuelve una vista de pouBody si no existia la crea"

	pouBodyView ifNil: [ 
		( pouBody language = 'LADDER DIAGRAM' )
			ifTrue: [ self buildLadderView  ].
		"( pouBody language = 'INSTRUCTION LIST' )
			ifTrue: [ self buildILView  ].
		( pouBody language = '' )
			ifTrue: [ self buildStandardView  ]."
		].
		
	^pouBodyView
]

{ #category : #'ladder editor' }
PLC_POU_Body_Editor >> pouLadderTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self ladderPouBodyMorph )
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'open/close' }
PLC_POU_Body_Editor >> projectFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ 'D:/Proyecto/Pharo-1.3-13315-OneClick.app/Contents/Resources/PLeriC'."
	^ ''.
]

{ #category : #'ladder Commands' }
PLC_POU_Body_Editor >> removeNetwork [
	"Este comando modifica el modelo eliminando la network con el foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			pouBody removeNetwork: self keyboardFocusMorph.
			]
	
	"Falta, tiene que redibujar todo el editor"

]

{ #category : #accessing }
PLC_POU_Body_Editor >> titleColor [
	
	^ titleColor
]

{ #category : #accessing }
PLC_POU_Body_Editor >> titleColor: anObject [
	
	titleColor := anObject
]

{ #category : #accessing }
PLC_POU_Body_Editor >> titleName [
	
	^ titleName
]

{ #category : #accessing }
PLC_POU_Body_Editor >> titleName: anObject [
	
	titleName := anObject
]
