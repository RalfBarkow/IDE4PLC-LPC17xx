"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_EditorProgram is xxxxxxxxx.

Instance Variables
	drawingArea:		<Object>
	instructions:		<Object>
	menubar:		<Object>
	projectTree:		<Object>
	properties:		<Object>
	toolbar:		<Object>
	window:		<Object>

drawingArea
	- xxxxx

instructions
	- xxxxx

menubar
	- xxxxx

projectTree
	- xxxxx

properties
	- xxxxx

toolbar
	- xxxxx

window
	- xxxxx

"
Class {
	#name : #'PLC_EditorProgram',
	#superclass : #Object,
	#instVars : [
		'window',
		'menubar',
		'toolbar',
		'projectTree',
		'instructions',
		'properties',
		'drawingArea'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #varios }
PLC_EditorProgram >> chooseColor [
	self drawingArea paintingColor: (self window chooseColor: self drawingArea paintingColor)
]

{ #category : #varios }
PLC_EditorProgram >> draw [
	self window alert: 'Fool! You are already painting. '
]

{ #category : #varios }
PLC_EditorProgram >> drawingArea [
	^ drawingArea ifNil: [
		drawingArea := PaintCanvas new]
]

{ #category : #'initialize-release' }
PLC_EditorProgram >> initialize [
	self initialize1.
	self initialize2.

]

{ #category : #'initialize-release' }
PLC_EditorProgram >> initialize1 [
	super initialize.
	self installMenubar.
	self installToolbar.
	self installDrawingArea.
	self window openInWorld.
	self window  extent: 800@600.
]

{ #category : #'initialize-release' }
PLC_EditorProgram >> initialize2 [
	
	|win projectMenu tools dock text holder editMenu |

	super initialize.
	
	win := StandardWindow new.

	projectMenu := win newMenu.

	projectMenu
		addToggle: 'Nuevo...ACAAAA'
		target: self "would be model"
		selector: #projectMenuNewProject.
	projectMenu lastItem
		font: win theme menuFont;
		icon: win theme smallNewIcon;
		keyText: 'Ctrl+N'.

	projectMenu
		addToggle: 'Abrir...' "'Open' translated"
		target: self 
		selector: #projectMenuOpenProject.
	projectMenu lastItem
		font: win theme menuFont;
		icon: win theme smallOpenIcon;
		keyText: 'Ctrl+O'.
	
	projectMenu
		addToggle: 'Guardar'
		target: self
		selector: #projectMenuSaveProject
		getStateSelector: nil
		enablementSelector: nil.
	projectMenu lastItem
		font: win theme menuFont;
		icon: win theme smallSaveIcon;
		keyText: 'Ctrl+S'.

	projectMenu
		addToggle: 'Guardar como...'
		target: self
		selector: #projectMenuSaveProjectAs
		getStateSelector: nil
		enablementSelector: nil.
	projectMenu lastItem
		font: win theme menuFont;
		icon: win theme smallSaveAsIcon;
		keyText: 'Ctrl+Mayus+S'.

	projectMenu
		addToggle: 'Imprimir...'
		target: nil
		selector: #projectMenuPrintProject.
	projectMenu lastItem
		font: win theme menuFont;
		icon: win theme smallPrintIcon;
		keyText: 'Ctrl+P'.

	editMenu := win newMenu.

	editMenu
		addToggle: 'Cortar'
		target: self 
		selector: #editMenuCut.
	editMenu lastItem
		font: win theme menuFont;
		icon: win theme smallCutIcon;
		keyText: 'Ctrl+X'.
		
	editMenu
		addToggle: 'Copiar'
		target: self 
		selector: #editMenuCopy.
	editMenu lastItem
		font: win theme menuFont;
		icon: win theme smallCopyIcon;
		keyText: 'Ctrl+C'.

	editMenu
		addToggle: 'Pegar'
		target: self 
		selector: #editMenuPaste.
	editMenu lastItem
		font: win theme menuFont;
		icon: win theme smallPasteIcon;
		keyText: 'Ctrl+V'.

	editMenu
		addToggle: 'Borrar'
		target: self 
		selector: #editMenuDelete.
	editMenu lastItem
		font: win theme menuFont;
		icon: win theme smallDeleteIcon;
		keyText: 'Supr'.

	editMenu
		addToggle: 'Cambiar nombre'
		target: self 
		selector: #editMenuChangeName.
	editMenu lastItem
		font: win theme menuFont;
		icon: nil;
		keyText: 'F2'.		

	editMenu
		addToggle: 'Compilar'
		target: self 
		selector: #editMenuCompile.
	editMenu lastItem
		font: win theme menuFont;
		icon: win theme smallDoItIcon;
		keyText: 'Ctrl+B'.




	tools := win newToolbar: {
		win
			newButtonFor: nil "if we had a model it would go here"
			getState: nil
			action: #openFile
			arguments: nil
			getEnabled: nil
			labelForm: win theme smallNewIcon
			help: 'Nuevo'.

		win
			newButtonFor: nil
			getState: nil
			action: #openFile
			arguments: nil
			getEnabled: nil
			labelForm: win theme smallOpenIcon
			help: 'Abrir'.

		win
			newButtonFor: nil
			getState: nil
			action: #saveFile
			arguments: nil
			getEnabled: nil
			labelForm: win theme smallSaveIcon
			help: 'Guardar'.

		win
			newButtonFor: nil
			getState: nil
			action: #print
			arguments: nil
			getEnabled: nil
			labelForm: win theme smallPrintIcon
			help: 'Imprimir'}.

		holder := StringHolder new.

		text := win
			newTextEditorFor: holder
			getText:  #contents
			setText: #contents:
			getEnabled: nil.

		dock := win newToolDockingBar.

		dock
			add: 'Proyecto' "'File' translated"
			font: win theme menuBarFont
			icon: nil "win theme smallOpenIcon"
			help: 'Operaciones de proyecto' "'File operations' translated"
			subMenu: projectMenu;
			addMorphBack: tools;

			add: 'Proyecto' "'File' translated"
			font: win theme menuBarFont
			icon: nil "win theme smallOpenIcon"
			help: 'Operaciones de proyecto' "'File operations' translated"
			subMenu: projectMenu;
			addMorphBack: tools;
			
			add: 'Proyecto' "'File' translated"
			font: win theme menuBarFont
			icon: nil "win theme smallOpenIcon"
			help: 'Operaciones de proyecto' "'File operations' translated"
			subMenu: projectMenu;
			addMorphBack: tools;
			
			add: 'Edición'
			font: win theme menuBarFont
			icon: nil
			help: 'Operaciones de proyecto'
			subMenu: editMenu;
			addMorphBack: tools.
			
		win
			addMorph: dock
			fullFrame: (LayoutFrame fractions: (0@0 corner: 1@0) offsets: (0@0 corner: 0 @ dock minExtent y));
			addMorph: text
			fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1) offsets: (0@dock minExtent y corner: 0 @ 0)).
		win

			themeChanged;
			openInWorld.

]

{ #category : #'initialize-release' }
PLC_EditorProgram >> installDrawingArea [
	self window 
		addMorph: self drawingArea
		fullFrame: (
			LayoutFrame
				fractions: (0@0 corner: 1@1)
				offsets: (0@(self menubar minExtent y "+ self toolbar minExtent y") corner:  0@0)).
	self drawingArea color: Color red
]

{ #category : #'initialize-release' }
PLC_EditorProgram >> installMenubar [
	self window 
		addMorph: self menubar
		fullFrame: (
			LayoutFrame
				fractions: (0@0 corner: 1@0)
				offsets: (0@0 corner:  0@ self menubar minExtent y))
]

{ #category : #'initialize-release' }
PLC_EditorProgram >> installToolbar [

| buttonPanel |

buttonPanel := PluggablePanelMorph new.
self window addMorph: buttonPanel fullFrame: ( 
    LayoutFrame
        fractions: (0@0.99 corner: 1@1)
        offsets: (0@50 negated corner: 0@0)).
buttonPanel  color: (Color gray).


#(uno dos tres) do: [:label| |aButton| 
   aButton := PluggableButtonMorph new label: label; yourself.
   buttonPanel addMorph: aButton fullFrame: nil.
].

	"self window 
		addMorph: self toolbar
		fullFrame: (
			LayoutFrame
				fractions: (0@0 corner: 1@0)
				offsets: (0@self menubar minExtent y corner:  0@ self menubar minExtent y + self toolbar minExtent y))"
]

{ #category : #varios }
PLC_EditorProgram >> load [
	self window fileOpen: 'Seleccione un mapa de bits a cargar' extensions: #('png'  'jpg').
	self window deny: 'It is only a demo, you cannot load bitmap yet'
]

{ #category : #varios }
PLC_EditorProgram >> menubar [
	^ menubar ifNil: [ | menuProyecto menuConfiguracion |
		menuProyecto := self window newMenu.
		menuProyecto 
			addToggle: 'Abrir'
			target: self
			selector: #load.
		menuProyecto 
			addToggle: 'Guardar'
			target: self
			selector: #save.
		menuProyecto 
			addToggle: 'Imprimir'
			target: self
			selector: #print.

		menuConfiguracion := self window newMenu.
		menuConfiguracion 
			addToggle: 'Abrir'
			target: self
			selector: #load.
		menuConfiguracion 
			addToggle: 'Guardar'
			target: self
			selector: #save.
		menuConfiguracion 
			addToggle: 'Imprimir'
			target: self
			selector: #print.

		menubar := self window newToolDockingBar.
		menubar 
			add: 'Proyecto'
			font: self window theme menuBarFont
			icon: nil
			help: 'Operaciones de proyecto'
			subMenu: menuProyecto.
		menubar
			add: 'Configuracion'
			font: self window theme menuBarFont
			icon: nil
			help: 'Configuraciones'
			subMenu: menuConfiguracion.
		menubar
		]
]

{ #category : #varios }
PLC_EditorProgram >> messageSelecsave [
	self window fileSave: 'Select a bitmap to load' extensions: #('png'  'jpg').
	self window deny: 'It is only a demo, you cannot save bitmap yet'
]

{ #category : #varios }
PLC_EditorProgram >> save [
	self window fileSave: 'Escriba un nombre para la imagen a guardar' extensions: #('png'  'jpg').
	self window deny: 'It is only a demo, you cannot save bitmap yet'
]

{ #category : #varios }
PLC_EditorProgram >> toolbar [
	"^ toolbar ifNil: [ | tools |
		tools := self window newToolbar: {
			self window
		}.
		toolbar := self window newToolDockingBar addMorph: tools]"
]

{ #category : #varios }
PLC_EditorProgram >> window [
 	^ window ifNil: [
		window := StandardWindow labelled: 'PLeriC Project Manager'.
		window announcer
			on: WindowResizing 
			do: [:ann | self drawingArea extent: ann newSize].
		window]
]
