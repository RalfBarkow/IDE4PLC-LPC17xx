"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ListSelector is xxxxxxxxx.

Instance Variables
	borderColor:		<Object>
	color:		<Object>
	library:		<Object>
	target:		<Object>
	targetMessage:		<Object>
	view:		<Object>

borderColor
	- xxxxx

color
	- xxxxx

library
	- xxxxx

target
	- xxxxx

targetMessage
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #'PLC_ListSelector',
	#superclass : #Object,
	#instVars : [
		'view',
		'borderColor',
		'color',
		'library',
		'target',
		'targetMessage'
	],
	#category : #'IDE4PLC-GUI'
}

{ #category : #example }
PLC_ListSelector class >> example [
	"an example"

	| selector |
	selector := self new.
	selector openAt: 100@200.
	
	^ selector.
	
	"Con estas dos lineas abris una ventanita para elegir la funcion. Ya se, esta muy feo, 
	 fijate si te sale rapido ponerlo mas bonito, si no ya fue"
	
	"En el metodo buildView tenes los detalles de que Morph son: fijate que es un morph externo que incluye
	 dos morphs internos. Las posiciones de los internos estan puestas a mano respecto del de afuera.
	  Fijate que poniendole la posicion al morph de afuera, los de adentro se acomodan solitos.
	 Tal vez haya algo mas cheto, pero yo no lo conozco."
	
	"fijate en el metodo processFunctionSelection, ahi tenes que reemplazar el mensaje 
	  por lo que tengas que hacer para agregar una funcion en el segmento actual.
	  El metodo selectedFunction devuelve la instancia de PLC_Function correspondiente 
	a la funcion elegida"

]

{ #category : #'instance creation' }
PLC_ListSelector class >> newWithLibrary: aDictionary [
	"Nueva instancia con cierta biblioteca"

	| listSelector |
	
	listSelector := self new.
	
	listSelector borderColor: Color green.
	listSelector color: Color green twiceLighter.
	
	listSelector library: aDictionary.
	
	
	listSelector openAt: 100@200.
	
	
	^ listSelector
]

{ #category : #'instance creation' }
PLC_ListSelector class >> newWithLibrary: aDictionary andColor: aColor andBorderColor: aBorderColor [
	"Nueva instancia con cierta biblioteca"

	| listSelector |
	
	listSelector := self new.
	
	listSelector color: aColor.
	listSelector borderColor: aBorderColor.
	
	listSelector library: aDictionary.
	
	^ listSelector
]

{ #category : #accessing }
PLC_ListSelector >> borderColor [
	
	^ borderColor
]

{ #category : #accessing }
PLC_ListSelector >> borderColor: anObject [
	
	borderColor := anObject
]

{ #category : #list }
PLC_ListSelector >> buildView [
	"build and remenber my internal view"
	| builder listinha botoncito botoncito2 | 

	builder := UITheme builder.
	view := BorderedMorph new.
	view 
		borderWidth: 2;
		position: 100@300;
		color: self color;
		borderColor: self borderColor.

"list : (PLC_Function StdFunctions keys asArray))"

	listinha := builder 
			newListFor: (ListModel new list: self library keys asArray)
			list: #list
			selected: #selectionIndex
			changeSelected: #selectionIndex:
			getEnabled: nil
			help: 'Elegir el elemento a insetar'.
	listinha 
		position: (view position+(5@5));
		name: 'functionList';
		height: 200;
		width: 180.

	botoncito := builder
			newButtonFor: self 
			action: #processFunctionSelection
			label: 'Agregar' 
			help: 'Agregar el elemento elegido al segmento.'.
	botoncito 
		position: (view position + (13@listinha height + 20));
		setNameTo: #selectButton.	" (48@listinha height + 20));"

	botoncito2 := builder
			newButtonFor: self 
			action: #cancel
			label: 'Cancelar' 
			help: 'Cierra el selector.'.
	botoncito2 
		position: (view position + (78@listinha height + 20));
		setNameTo: #selectButton.

	view extent: ((listinha width + 10)@(listinha height + botoncito height + 30)).
	view addMorphBack: listinha.
	view addMorphBack: botoncito.
	view addMorphBack: botoncito2.

]

{ #category : #list }
PLC_ListSelector >> cancel [
	"Cierra la ventana"

	self view delete.
]

{ #category : #list }
PLC_ListSelector >> clearView [
	"Elimina la Vista"

	view := nil.
]

{ #category : #accessing }
PLC_ListSelector >> color [
	
	^ color
]

{ #category : #accessing }
PLC_ListSelector >> color: anObject [
	
	color := anObject
]

{ #category : #list }
PLC_ListSelector >> functionListPanel [
	"the morph rendering the function list"

	^self view submorphs detect: [ :morph | morph externalName = 'functionList' ].
]

{ #category : #'initialize-release' }
PLC_ListSelector >> initialize [
	"Inicializa"

	"view := nil."

]

{ #category : #accessing }
PLC_ListSelector >> library [
	
	^ library
]

{ #category : #accessing }
PLC_ListSelector >> library: anObject [
	
	library := anObject
]

{ #category : #list }
PLC_ListSelector >> openAt: somePosition [
	"my view"

	self functionListPanel model selectionIndex: 1.
	self view 
		position: somePosition;
		openInWorld.
	self functionListPanel takeKeyboardFocus.

]

{ #category : #list }
PLC_ListSelector >> processFunctionSelection [
	"process the fac that the user has made a selection on the function list"

	self selectedFunction 
		ifNil: [ 
			UITheme builder message: 'Debe elegir algun elemento.' 
			]
		ifNotNil: [ 
			"UITheme builder message: 
				('El elemento seleccionado es ', self selectedFunction cPOUName , '.' ).
				  self view delete. "
				
			"Target es el objeto al que le mando el resultado de la seleccion en el 
			list, por ejemplo, un ladderView que le mando una funcion elegida para 
			que se inserte"	
			self target 
				perform: self targetMessage 
				with: self selectedFunction.
				
			self cancel.
			]
]

{ #category : #list }
PLC_ListSelector >> selectedFunction [
	"the function currently selected, an instance of PLC_Function"

	^self functionListPanel model selectedItem
		ifNil: [ nil ]
		ifNotNil: [ self library at: (self functionListPanel model selectedItem) ]
]

{ #category : #accessing }
PLC_ListSelector >> target [
	"Aca guarda el objeto destino a quien tiene que devolverle el item seleccionado"
	
	^ target
]

{ #category : #accessing }
PLC_ListSelector >> target: anObject [
	
	target := anObject
]

{ #category : #accessing }
PLC_ListSelector >> targetMessage [
	"Aca guarda el lemsaje que le tiene que mandar objeto destino a quien tiene que devolverle el item seleccionado"
	
	^ targetMessage
]

{ #category : #accessing }
PLC_ListSelector >> targetMessage: anObject [
	
	targetMessage := anObject
]

{ #category : #list }
PLC_ListSelector >> view [
	"my view"

	view ifNil: [ self buildView ].
	^view
]

{ #category : #accessing }
PLC_ListSelector >> view: anObject [
	
	view := anObject
]
