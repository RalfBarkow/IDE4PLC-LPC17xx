"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicElementState is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_GraphicElementState',
	#superclass : #Object,
	#classVars : [
		'States',
		'StatesCreated'
	],
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #'instance creation' }
PLC_GraphicElementState class >> clearStates [
	"Borra las instancias creadas"

	States := Dictionary new.
	StatesCreated := false.
	

]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> connectedToBlock [
	"Devuelve la única instancia del estado connectedToBlock"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToBlock.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> connectedToCoil [
	"Devuelve la única instancia del estado rightRailConnectedToCoil"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToCoil.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> connectedToContact [
	"Devuelve la única instancia del estado connectedToContact"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToContact.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> connectedToLeftPowerRail [
	"Devuelve la única instancia del estado connectedToLeftPowerRail"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToLeftPowerRail
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> connectedToLeftPowerRailTroughFirstOutputPin [ 
	"Devuelve la única instancia del estado connectedToLeftPowerRailTroughFirstOutputPin"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToLeftPowerRailTroughFirstOutputPin
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> connectedToRightPowerRail [
	"Devuelve la única instancia del estado connectedToRightPowerRail"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #connectedToRightPowerRail.
]

{ #category : #'instance creation' }
PLC_GraphicElementState class >> createStates [
	"Crea las instancias únicas de los estados"

	States := Dictionary new.	
		
	
	"User Interaction State"
	
	States at: #voidState put: PLC_UIS_VoidState new.
	
	"User Interaction State Layer 1"
	
	States at: #selected 
		put: PLC_UISL1_Selected new.
	States at: #unselected 
		put: PLC_UISL1_Unselected new.
	States at: #draggingAnother 
		put: PLC_UISL1_DraggingAnother new.
	States at: #draggingSelf 
		put: PLC_UISL1_DraggingSelf new.
	
	"User Interaction State Layer 2"
	
	States at: #keyboardFocus 
		put: PLC_UISL2_KeyboardFocus new.
	States at: #underDragArea 
		put: PLC_UISL2_UnderDragArea new.
	States at: #overDropArea 
		put: PLC_UISL2_OverDropArea new.
	
	"User Interaction State Layer 3"
	
	States at: #mouseOver put: PLC_UISL3_MouseOver new.
	

	" Connection State Layer 1"
	
	States at: #voidCSL1 
		put: PLC_CSL1_Void new.
	States at: #connectedToLeftPowerRail 
		put: PLC_CSL1_ConnectedToLeftPowerRail new.
	States at: #connectedToRightPowerRail 
		put: PLC_CSL1_ConnectedToRightPowerRail new.
	States at: #connectedToContact 
		put: PLC_CSL1_ConnectedToContact new.
	States at: #connectedToCoil 
		put: PLC_CSL1_ConnectedToCoil new.
	States at: #connectedToBlock 
		put: PLC_CSL1_ConnectedToBlock new.
	States at: #leftConnectedToVerticalLink 
		put: PLC_CSL1_LeftConnectedToVerticalLink new.
	States at: #rightConnectedToVerticalLink 
		put: PLC_CSL1_RightConnectedToVerticalLink new.
	States at: #leftAndRightConnectedToVerticalLink 
		put: PLC_CSL1_LeftAndRightConnectedToVerticalLink new.
		
	States at: #pinFromBooleanFormalParameter
		put: PLC_CSL1_PinFromBooleanFormalParameter new.
	States at: #pinFromNotBooleanFormalParameter
		put: PLC_CSL1_PinFromNotBooleanFormalParameter new.
		


	"Connection State Layer 2"
	
	States at: #connectedToLeftPowerRailTroughFirstOutputPin 
		put: PLC_CSL2_ConnectedToLeftPowerRailTroughFirstOutputPin new.
	States at: #notConnectedToLeftPowerRailTroughFirstOutputPin 
		put: PLC_CSL2_NotConnectedToLeftPowerRailTroughFirstOutputPin new.
		
	States at: #pinNormal 
		put: PLC_CSL2_PinNormal new.
	States at: #pinNegated 
		put: PLC_CSL2_PinNegated new.
	States at: #pinRisingEdge 
		put: PLC_CSL2_PinRisingEdge new.
	States at: #pinFallingEdge 
		put: PLC_CSL2_PinFallingEdge new.
		
		
	StatesCreated := true.

]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> draggingAnother [ 
	"Devuelve la única instancia del estado arrastrando otro morph"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #draggingAnother.

"	^ PLC_DraggingAnother new."
]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> draggingSelf [ 
	"Devuelve la única instancia del estado arrastrando a el mismo"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #draggingSelf.

"	^ PLC_DraggingSelf new."
]

{ #category : #'class initialization' }
PLC_GraphicElementState class >> initialize [

	super initialize.
	StatesCreated ifNil: [
		StatesCreated := false
		].

]

{ #category : #'instance creation UISL2' }
PLC_GraphicElementState class >> keyboardFocus [
	"Devuelve la única instancia del estado con foco del teclado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #keyboardFocus.
		
	"^ PLC_keyboardFocus new."
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> leftAndRightConnectedToVerticalLink [
	"Devuelve la única instancia del estado leftAndRightConnectedToVerticalLink"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #leftAndRightConnectedToVerticalLink.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> leftConnectedToVerticalLink [
	"Devuelve la única instancia del estado leftConnectedToVerticalLink"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #leftConnectedToVerticalLink.
]

{ #category : #'instance creation UISL3' }
PLC_GraphicElementState class >> mouseOver [
	"Devuelve la única instancia del sub estado cuando el mouse esta sobre el elemento"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #mouseOver.
	
	"^ PLC_MouseOver new."
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> notConnectedToLeftPowerRailTroughFirstOutputPin [
	"Devuelve la única instancia del estado notConnectedToLeftPowerRailTroughFirstOutputPin"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #notConnectedToLeftPowerRailTroughFirstOutputPin
]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> overDropArea [ 
	"Devuelve la única instancia del estado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #overDropArea.
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> pinFallingEdge [
	"Devuelve la única instancia del estado pinFallingEdge"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinFallingEdge.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> pinFromBooleanFormalParameter [
	"Devuelve la única instancia del estado pinFromBooleanFormalParameter"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinFromBooleanFormalParameter.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> pinFromNotBooleanFormalParameter [
	"Devuelve la única instancia del estado pinFromNotBooleanFormalParameter"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinFromNotBooleanFormalParameter.
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> pinNegated [
	"Devuelve la única instancia del estado pinNegated"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinNegated.
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> pinNormal [
	"Devuelve la única instancia del estado pinNormal"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinNormal.
]

{ #category : #'instance creation CSL2' }
PLC_GraphicElementState class >> pinRisingEdge [
	"Devuelve la única instancia del estado pinRisingEdge"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #pinRisingEdge.
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> rightConnectedToVerticalLink [
	"Devuelve la única instancia del estado rightConnectedToVerticalLink"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #rightConnectedToVerticalLink.
]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> selected [
	"Devuelve la única instancia del estado seleccionado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #selected.

	"^ PLC_Selected new."
	

	

]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> underDragArea [ 
	"Devuelve la única instancia del estado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #underDragArea.
]

{ #category : #'instance creation UISL1' }
PLC_GraphicElementState class >> unselected [
	"Devuelve la única instancia del estado desseleccionado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #unselected.

"	^ PLC_Unselected new."
]

{ #category : #'instance creation CSL1' }
PLC_GraphicElementState class >> voidCSL1 [
	"Devuelve la única instancia del estado voidCSL1"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #voidCSL1.
]

{ #category : #'instance creation UIS' }
PLC_GraphicElementState class >> voidState [
	"Devuelve la única instancia del estado seleccionado"
	
	StatesCreated ifFalse: [self createStates].
	
	^ States at: #voidState.

	"^ PLC_VoidState new."
]

{ #category : #drawing }
PLC_GraphicElementState >> drawElementOn: aCanvas for: aPLC_GraphicElementMorph [
	"Le pide al elemento gráfico que dibuje este estado de connection drawin layer."
]

{ #category : #drawing }
PLC_GraphicElementState >> drawOn: aCanvas from: aPLC_GraphicElementMorph [.
	"No dibuja nada. Para no tener que repetirlo en las subclases."
	

]

{ #category : #layout }
PLC_GraphicElementState >> layoutHorizontallyLeft: aDistanceX for: aPLC_GraphicElementMorph [.
	"Como NO esta conectado a un RPR solo alineo el elemento a aDistanceX como si fuese un contacto."

	aPLC_GraphicElementMorph voidLayoutHorizontallyLeft: aDistanceX.
]

{ #category : #extent }
PLC_GraphicElementState >> layoutRectangleExtentFor: aPLC_RightRailMorph [
	"Tamaño del LayoutRectangle en este estado"
]

{ #category : #layout }
PLC_GraphicElementState >> layoutRectangleFor: aGraphicElement [
	"Devuelve el layout Rectangle del elemento en este estado. Se usa para cambiar el 
	layoutRecgatngle de la bobina segun a que esta conectada, si a RPR u otra cosa"
]

{ #category : #position }
PLC_GraphicElementState >> layoutRectanglePositionFor: aPLC_RightRailMorph [
	"Posicion del LayoutRectangle en este estado."
]
