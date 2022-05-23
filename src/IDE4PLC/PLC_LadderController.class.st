"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LadderController is xxxxxxxxx.

Instance Variables
	ladderNetwork:		<Object>
	ladderView:		<Object>

ladderNetwork
	- xxxxx

ladderView
	- xxxxx

"
Class {
	#name : #'PLC_LadderController',
	#superclass : #Object,
	#instVars : [
		'ladderView',
		'ladderNetwork'
	],
	#category : #'IDE4PLC-Networks'
}

{ #category : #'instance creation' }
PLC_LadderController class >> newWithModel: aLadderNetwork [
	"Crea una nueva instancia con el modelo de bloques conectables asociado"

	| controller |
	
	"Creo un controlador Ladder"
	controller := self new.
	
	"Le agrego el modelo"
	controller ladderNetwork: ( aLadderNetwork ifNil: [ PLC_LadderNetwork new. ] ) .
	
	^ controller.
	
]

{ #category : #'commands recive from View' }
PLC_LadderController >> addCoilOn: aConnectableBlockOrConnection [
	"Agrega una Bobina sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_Element Coil.
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade una Bobina en el modelo." 	
	self ladderNetwork addCoil: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #'commands recive from View' }
PLC_LadderController >> addFunctionBlockCallWithDeclaration: functionBlockDeclaration on: aConnectableBlockOrConnection [
	"Agrega una Llamada a Función sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_GraphicFunctionBlockCall
		newWithDeclaration: functionBlockDeclaration 
		andNetwork: self ladderNetwork.
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade una Llamada a Función en el modelo." 	
	self ladderNetwork addFunctionBlockCall: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> addFunctionCallWithDeclaration: functionDeclaration on: aConnectableBlockOrConnection [
	"Agrega una Llamada a Función sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_GraphicFunctionCall
		newWithDeclaration: functionDeclaration 
		andNetwork: self ladderNetwork.		
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade una Llamada a Función en el modelo." 	
	self ladderNetwork addFunctionCall: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> addNCContactOn: aConnectableBlockOrConnection [
	"Agrega un Contacto normal cerrado sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_Element NCContact.
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade un Contacto en el modelo." 	
	self ladderNetwork addContact: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #'commands recive from View' }
PLC_LadderController >> addNCoilOn: aConnectableBlockOrConnection [
	"Agrega una Bobina negada sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_Element NCoil.
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade una Bobina en el modelo." 	
	self ladderNetwork addCoil: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> addNOContactOn: aConnectableBlockOrConnection [
	"Agrega un Contacto normal abierto sobre el elemento que tenga el foco del teclado."
	
	| connection element |
	
	"Creo el elemento"
	element := PLC_Element NOContact.
	
	"Busco la conexion donde voy a añadir el elemento"
	connection := aConnectableBlockOrConnection connectionToAddElement: element.

	"Crea y añade un Contacto en el modelo." 	
	self ladderNetwork addContact: element onConnection: connection.
	
	"Refresca la vista"
	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> changeActualArgumentFor: aPLC_ConnectableBlock by: aString [
	"Cambia el Actual Argument. "
		
	( self ladderNetwork changeActualArgumentFor: aPLC_ConnectableBlock by: aString )
		ifTrue: [
			"Refresca la vista"
			self ladderView refresh.
			].
	

]

{ #category : #'commands recive from View' }
PLC_LadderController >> closeBranchFrom: aPLC_ConnectableBlockOrConnection to: aPLC_Connection [
	"Cierra una rama entre una conexion o bloque y otra conexion si se puede."

	"Abre una rama sobre la conexion aConnection en el modelo." 	
	self ladderNetwork closeBranchFrom: aPLC_ConnectableBlockOrConnection to: aPLC_Connection.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #compilation }
PLC_LadderController >> generateCodeIn: aProgramAccumulator [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."

	self ladderNetwork generateCodeIn: aProgramAccumulator.

]

{ #category : #accessing }
PLC_LadderController >> ladderNetwork [
	^ ladderNetwork
]

{ #category : #accessing }
PLC_LadderController >> ladderNetwork: anObject [
	ladderNetwork := anObject
]

{ #category : #accessing }
PLC_LadderController >> ladderView [
	^ ladderView
]

{ #category : #accessing }
PLC_LadderController >> ladderView: anObject [
	ladderView := anObject
]

{ #category : #'commands recive from View' }
PLC_LadderController >> openBranchOnConnection: aConnection [
	"Abre una rama sobre una conexion (==)."

	"Abre una rama sobre la conexion aConnection en el modelo." 	
	self ladderNetwork openBranchOnConnection: aConnection.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #ladderView }
PLC_LadderController >> openLadderView [
	"comment stating purpose of message"

	"Creo una vista ladder y se la agrego al controlador"
	self ladderView: PLC_LadderView new.
	
	"Le agrego el controlador a la vista creada"
	self ladderView ladderController: self.
	
	"Le digo a la vista que se refresque en pantalla"
	self refreshView.
	
	"Retorna el ladderView"
	^ self ladderView.
]

{ #category : #ladderView }
PLC_LadderController >> refreshView [
	"comment stating purpose of message"

	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> removeCoil: aCoil [
	"Remueve un Bobina."

	"Remueve una Bobina en el modelo." 	
	self ladderNetwork removeCoil: aCoil.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #'commands recive from View' }
PLC_LadderController >> removeContact: aContact [
	"Remueve un Contacto."

	"Remueve un Contacto en el modelo." 	
	self ladderNetwork removeContact: aContact.
	
	"Refresca la vista"
	self ladderView refresh.

]

{ #category : #'commands recive from View' }
PLC_LadderController >> removeFunctionCall: aFunctionCallConnectableBlock [
	"Remueve un llamado a Función."

	"Remueve un llamado a Función en el modelo." 	
	self ladderNetwork removeFunctionCall: aFunctionCallConnectableBlock.
	
	"Refresca la vista"
	self ladderView refresh.
]

{ #category : #'commands recive from View' }
PLC_LadderController >> removeRightPowerRail: aPLC_ConnectableBlockRPR [
	"Remueve un Right Power Rail."

	"Remueve si es posible el Right Power Rail aPLC_ConnectableBlockRPR en el modelo." 	
	self ladderNetwork removeRightPowerRail: aPLC_ConnectableBlockRPR.
	
	"Refresca la vista"
	self ladderView refresh.

]
