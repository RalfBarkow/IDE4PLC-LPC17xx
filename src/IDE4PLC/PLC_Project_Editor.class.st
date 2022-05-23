"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Project_Editor is xxxxxxxxx.

Instance Variables
	borderColor:		<Object>
	color:		<Object>
	hardConfigEditor:		<Object>
	keyboardFocusMorph:		<Object>
	project:		<Object>
	titleColor:		<Object>
	titleName:		<Object>

borderColor
	- xxxxx

color
	- xxxxx

hardConfigEditor
	- xxxxx

keyboardFocusMorph
	- xxxxx

project
	- xxxxx

titleColor
	- xxxxx

titleName
	- xxxxx

"
Class {
	#name : #'PLC_Project_Editor',
	#superclass : #Object,
	#instVars : [
		'keyboardFocusMorph',
		'project',
		'color',
		'borderColor',
		'titleColor',
		'titleName',
		'hardConfigEditor'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #'instance creation' }
PLC_Project_Editor class >> newWithProject: aProject andColor: aColor andBorderColor: aBorderColor andTitleColor: aTitleColor andTitleName: aTitleName [
	"Nueva instancia con cierto modelo de pou y colores"

	| projectEditor |
	
	"projectEditor es un Controlador"	
	projectEditor := self new.
	
	"Seteo su Modelo"
	projectEditor project: aProject. 
	
	"Seteo los colores de su Vista"
	projectEditor color: aColor.
	projectEditor borderColor: aBorderColor.
	projectEditor titleColor: aTitleColor.
	"Seteo el titulo de la vista"
	projectEditor titleName: aTitleName.
	
	"hardConfigEditor es un Controlador"	
	"projectEditor hardConfigEditor: ( PLC_POU_Body_Editor 
		newWithPOUBody: aProject pouBody
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance hardConfigColor 
		andTitleName: 'Configuraciones de Hardware'
		)."
		
	^ projectEditor
]

{ #category : #Commands }
PLC_Project_Editor >> addProjectToLibrary [ 
	"Añade su POU a la biblioteca de POUs"
	
	project.



]

{ #category : #accessing }
PLC_Project_Editor >> borderColor [
	
	^ borderColor
]

{ #category : #accessing }
PLC_Project_Editor >> borderColor: anObject [
	
	borderColor := anObject
]

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> buildProjectView [
	"Construye la vista y se la asigna a su variable de instancia pouBodyView para recordarla"
	
	| controls projectView | 
	
	
	"Creo la colección de controls que despues se pasa a la columna morph como array"
	controls := OrderedCollection new.
	
	"Agrego la barra de herramientas"
	controls add: self titleControl.
	controls add: self nameControl. "Me trae tambien los botones"
	"controls add: self pouToolbar."
	
	"Creo la columna morph"
	projectView := self builder newColumn: controls asArray.
	"hResizing: #spaceFill;
	vResizing: #shrinkWrap;
	cellSpacing: 10"	

	projectView 
		cellInset: 0";
		extent: 720 @ 450".	
			
					
	^ projectView.	
	
	

]

{ #category : #view }
PLC_Project_Editor >> builder [
	"Devuelve el builder"

	^ UITheme builder.
]

{ #category : #accessing }
PLC_Project_Editor >> color [
	
	^ color
]

{ #category : #accessing }
PLC_Project_Editor >> color: anObject [
	
	color := anObject
]

{ #category : #accessing }
PLC_Project_Editor >> hardConfigEditor [
	
	^ hardConfigEditor
]

{ #category : #accessing }
PLC_Project_Editor >> hardConfigEditor: anObject [
	
	hardConfigEditor := anObject
]

{ #category : #'open/close' }
PLC_Project_Editor >> imageFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ self proyectFilesPath , 'imagenes/'."
	^ ''.
]

{ #category : #accessing }
PLC_Project_Editor >> keyboardFocusMorph [
	
	^ keyboardFocusMorph
]

{ #category : #accessing }
PLC_Project_Editor >> keyboardFocusMorph: anObject [
	
	keyboardFocusMorph := anObject
]

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> ladderPouBodyMorph [
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

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> nameControl [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self nameMorph )
			"hResizing: #spaceFill".
			
		self builder
			newButtonFor: self
			getState: nil
			action: #addProjectToLibrary
			arguments: nil
			getEnabled: nil
			labelForm: (Form fromFileNamed: self imageFilesPath , 'addToLibrary.png')
			help: 'Añadir Proyecto a la Biblioteca.'.	
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> nameMorph [
	"devuelve un PLC_TitleMorph"

	| titleMorph |

	titleMorph := PLC_TitleMorph new.
	titleMorph extent: 693@56.
	titleMorph backgroundColor: (Color r:1 g: 1 b: 1 alpha: 0.1) .
	titleMorph backgroundBorderWidth: 1.
	titleMorph leftMargin: 30.
	titleMorph emphasis: 0.
	titleMorph textColor: Color black.
	titleMorph text: 'Nombre: ' , self project identifier.
	titleMorph leftAlign.
	titleMorph changed.
	
	^ titleMorph.
]

{ #category : #'open/close' }
PLC_Project_Editor >> open [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	self openWindow.
]

{ #category : #'open/close' }
PLC_Project_Editor >> openWindow [
	"Abre la ventana del  Editor. Para esto creo la ventana y agrego los controles"

	| window aWorld   |

	"Creo la ventana"
	window := ( SystemWindow labelled: 'Editor de Proyecto de Automatización' ) model: nil.
	

	"Agrego La cabecera del Editor de POU"
	window addMorph: self buildProjectView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0 corner: 1@0.16 )
			offsets: ( 0@0 corner: 1@0 )
		).	
			
	"Agrego el editor de Configuraciones de Hardware"
	"window addMorph: hardConfigEditor buildView fullFrame: (
		LayoutFrame 
			fractions: ( 0@0.4 corner: 1@1 )
			offsets: ( 0@0 corner: 1@0 )
		)."		
		
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

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> pouName [
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

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> pouToolbar [ 
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

{ #category : #accessing }
PLC_Project_Editor >> project [
	
	^ project
]

{ #category : #accessing }
PLC_Project_Editor >> project: anObject [
	
	project := anObject
]

{ #category : #'open/close' }
PLC_Project_Editor >> projectFilesPath [
	"Devuelve el string de la ruta de los archivos del proyecto"

	"^ 'D:/Proyecto/Pharo-1.3-13315-OneClick.app/Contents/Resources/PLeriC'."
	^ ''.
]

{ #category : #accessing }
PLC_Project_Editor >> titleColor [
	
	^ titleColor
]

{ #category : #accessing }
PLC_Project_Editor >> titleColor: anObject [
	
	titleColor := anObject
]

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> titleControl [
	"Genera la fila"
	
	| row |

	row := self builder newRow: {
		(self titleMorph )
			hResizing: #spaceFill.
		}.
		
	row cellInset: 0.
	
	^ row.
]

{ #category : #'hardware configurations editor' }
PLC_Project_Editor >> titleMorph [
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

{ #category : #accessing }
PLC_Project_Editor >> titleName [
	
	^ titleName
]

{ #category : #accessing }
PLC_Project_Editor >> titleName: anObject [
	
	titleName := anObject
]
