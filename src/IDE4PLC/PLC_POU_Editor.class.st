"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU_Editor is xxxxxxxxx.

Instance Variables
	borderColor:		<Object>
	color:		<Object>
	keyboardFocusMorph:		<Object>
	pou:		<Object>
	pouBodyEditor:		<Object>
	pouDeclsEditor:		<Object>
	titleColor:		<Object>
	titleName:		<Object>

borderColor
	- xxxxx

color
	- xxxxx

keyboardFocusMorph
	- xxxxx

pou
	- xxxxx

pouBodyEditor
	- xxxxx

pouDeclsEditor
	- xxxxx

titleColor
	- xxxxx

titleName
	- xxxxx

"
Class {
	#name : #'PLC_POU_Editor',
	#superclass : #Object,
	#instVars : [
		'keyboardFocusMorph',
		'pou',
		'color',
		'borderColor',
		'titleColor',
		'titleName',
		'pouBodyEditor',
		'pouDeclsEditor'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'instance creation' }
PLC_POU_Editor class >> newWithPOU: aPOU andColor: aColor andBorderColor: aBorderColor andTitleColor: aTitleColor andTitleName: aTitleName [
	"Nueva instancia con cierto modelo de pou y colores"

	| pouEditor |
	
	"pouDeclsEditor es un Controlador"	
	pouEditor := self new.
	
	"Seteo su Modelo"
	pouEditor pou: aPOU.
	
	"Seteo los colores de su Vista"
	pouEditor color: aColor.
	pouEditor borderColor: aBorderColor.
	pouEditor titleColor: aTitleColor.
	"Seteo el titulo de la vista"
	pouEditor titleName: aTitleName.
	

	pouEditor pouBodyEditor: ( PLC_POU_Body_Editor 
		newWithPOUBody: aPOU pouBody
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance programHeaderColor 
		andTitleName: 'Cuerpo de POU en lenguaje Ladder'
		).
	
	pouEditor pouDeclsEditor: ( PLC_POU_Declarations_Editor 
		newWithPOUDeclarations: aPOU declarations
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance programHeaderColor 
		andTitleName: 'Declaraciones de Variables de POU'
		).
		
	^ pouEditor
]

{ #category : #Commands }
PLC_POU_Editor >> addPOUToLibrary [ 
	"Añade su POU a la biblioteca de POUs"
	
	pou.



]

{ #category : #Commands }
PLC_POU_Editor >> bootLPCLink [ 

	PLeriC bootLPCLink
]

{ #category : #accessing }
PLC_POU_Editor >> borderColor [
	
	^ borderColor
]

{ #category : #accessing }
PLC_POU_Editor >> borderColor: anObject [
	
	borderColor := anObject
]

{ #category : #'pou editor' }
PLC_POU_Editor >> buildPOUView [
	"Construye la vista y se la asigna a su variable de instancia pouBodyView para recordarla"
	
	| controls pouView | 
	
	
	"Creo la colección de controls que despues se pasa a la columna morph como array"
	controls := OrderedCollection new.
	
	"Agrego la barra de herramientas"
	controls add: self pouTitle.
	controls add: self pouName. "Me trae tambien los botones"
	"controls add: self pouToolbar."
	
	"Creo la columna morph"
	pouView := self builder newColumn: controls asArray.
	"hResizing: #spaceFill;
	vResizing: #shrinkWrap;
	cellSpacing: 10"	

	pouView 
		cellInset: 0";
		extent: 720 @ 450".	
			
					
	^ pouView.	
	
	

]

{ #category : #view }
PLC_POU_Editor >> builder [
	"Devuelve el builder"

	^ UITheme builder.
]

{ #category : #view }
PLC_POU_Editor >> clearView [
	"Elimina la Vista"

	pouBodyView := nil.
]

{ #category : #accessing }
PLC_POU_Editor >> color [
	
	^ color
]

{ #category : #accessing }
PLC_POU_Editor >> color: anObject [
	
	color := anObject
]

{ #category : #Commands }
PLC_POU_Editor >> compile [ 

	PLeriC cCompileConfigSoft
]

{ #category : #Commands }
PLC_POU_Editor >> downloadProgram [ 

	PLeriC downloadProgram


]

{ #category : #Commands }
PLC_POU_Editor >> generateCode [
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	self keyboardFocusMorph 
		ifNotNil: [ 
			self keyboardFocusMorph generateCode 
			]




]

{ #category : #'open/close' }
PLC_POU_Editor >> imageFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	^ 'IDE4PLC_files/GUI_Images/pouEditorToolbar/'.
]

{ #category : #accessing }
PLC_POU_Editor >> keyboardFocusMorph [
	
	^ keyboardFocusMorph
]

{ #category : #accessing }
PLC_POU_Editor >> keyboardFocusMorph: anObject [
	
	keyboardFocusMorph := anObject
]

{ #category : #'pou editor' }
PLC_POU_Editor >> ladderPouBodyMorph [
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

{ #category : #'open/close' }
PLC_POU_Editor >> open [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	self openWindow.
]

{ #category : #'open/close' }
PLC_POU_Editor >> openWindow [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Editor de Unidad de Organización de Programa (POU)' ) model: nil.
	

	"Agrego La cabecera del Editor de POU"
	window addMorph: self buildPOUView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.16 )
			offsets: ( 0@0 corner: 1@0 )
		).	
			
	"Agrego el editor de variables"
	window addMorph: pouDeclsEditor buildDeclsView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.16 corner: 1@0.4 )
			offsets: ( 0@0 corner: 1@0 )
		).
	"Agrego el editor de ladder"
	window addMorph: pouBodyEditor buildLadderView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		).		
		
	window updatePaneColors.
	window extent: 770@580.
	window position: 10@10.
	
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
PLC_POU_Editor >> pou [
	
	^ pou
]

{ #category : #accessing }
PLC_POU_Editor >> pou: anObject [
	
	pou := anObject
]

{ #category : #accessing }
PLC_POU_Editor >> pouBodyEditor [
	
	^ pouBodyEditor
]

{ #category : #accessing }
PLC_POU_Editor >> pouBodyEditor: anObject [
	
	pouBodyEditor := anObject
]

{ #category : #accessing }
PLC_POU_Editor >> pouDeclsEditor [
	
	^ pouDeclsEditor
]

{ #category : #accessing }
PLC_POU_Editor >> pouDeclsEditor: anObject [
	
	pouDeclsEditor := anObject
]

{ #category : #'pou editor' }
PLC_POU_Editor >> pouName [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self pouNameMorph )
			"hResizing: #spaceFill".
			
		self builder
			newButtonFor: self  "if we had a model it would go here"
			getState: nil
			action: #compile
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'compile.png')
			help: 'Compilar.'.
			
		self builder
			newButtonFor: self  
			getState: nil
			action: #bootLPCLink 
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'bootLPCLink.png')
			help: 'Conectarse al PLC.'.	
			
		self builder
			newButtonFor: self  
			getState: nil
			action: #downloadProgram
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'downloadProgram.png')
			help: 'Descargar Programa al PLC.'.	
			
		self builder
			newButtonFor: self
			getState: nil
			action: #addPOUToLibrary
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addToLibrary.png')
			help: 'Añadir POU a la Biblioteca.'.	
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'pou editor' }
PLC_POU_Editor >> pouNameMorph [
	"devuelve un PLC_TitleMorph"

	| titleMorph |

	titleMorph := PLC_TitleMorph new.
	titleMorph extent: 488@56.
	titleMorph backgroundColor: (Color r:1 g: 1 b: 1 alpha: 0.1) .
	titleMorph backgroundBorderWidth: 1.
	titleMorph leftMargin: 30.
	titleMorph emphasis: 0.
	titleMorph textColor: Color black.
	titleMorph text: 'Nombre: ' , self pou identifier.
	titleMorph leftAlign.
	titleMorph changed.
	
	^ titleMorph.
]

{ #category : #'pou editor' }
PLC_POU_Editor >> pouTitle [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self pouTitleMorph )
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'pou editor' }
PLC_POU_Editor >> pouTitleMorph [
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

{ #category : #'pou editor' }
PLC_POU_Editor >> pouToolbar [ 
	"Devuelve la barra de herramientas superior de la ventana de edición de Ladder"
	
	| builder |
	
	"^PLC_LadderToolBarMorph new."

	builder := UITheme builder.
	
	^ builder newToolbar: {
		
		builder
			newButtonFor: self "if we had a model it would go here"
			getState: nil
			action: #showPOUCode
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'compile.png')
			help: 'Compilar POU.'.
			
		builder
			newButtonFor: self
			getState: nil
			action: #addPOUToLibrary
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addToLibrary.png')
			help: 'Añadir POU a la Biblioteca.'.	
	}.
]

{ #category : #'open/close' }
PLC_POU_Editor >> projectFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ 'D:/Proyecto/Pharo-1.3-13315-OneClick.app/Contents/Resources/PLeriC'."
	^ ''.
]

{ #category : #Commands }
PLC_POU_Editor >> showPOUCode [ 
	"Reenvia el comando correspondiente al boton de la ladderToolBar 
	pulsado a la network con foco del teclado"

	| configSoft |

	configSoft := PLeriC createConfigSoftWithPOU: pou.
	
	configSoft cCompile.
]

{ #category : #accessing }
PLC_POU_Editor >> titleColor [
	
	^ titleColor
]

{ #category : #accessing }
PLC_POU_Editor >> titleColor: anObject [
	
	titleColor := anObject
]

{ #category : #accessing }
PLC_POU_Editor >> titleName [
	
	^ titleName
]

{ #category : #accessing }
PLC_POU_Editor >> titleName: anObject [
	
	titleName := anObject
]
