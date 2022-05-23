"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ConnectableBlocksNetwork is xxxxxxxxx.

Instance Variables
	blocks:		<Object>
	networkController:		<Object>
	networkLabel:		<Object>
	pouBody:		<Object>

blocks
	- xxxxx

networkController
	- xxxxx

networkLabel
	- xxxxx

pouBody
	- xxxxx

"
Class {
	#name : #'PLC_ConnectableBlocksNetwork',
	#superclass : #Object,
	#instVars : [
		'pouBody',
		'networkController',
		'networkLabel',
		'blocks'
	],
	#category : #'IDE4PLC-Networks'
}

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> addBlock:  aConnectableBlock [
	"Añade un bloque conectable a la Ordered Collection blocks"

	self blocks add:  aConnectableBlock.
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> blocks [
	^ blocks
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> blocks: anObject [
	blocks := anObject
]

{ #category : #'called POUs' }
PLC_ConnectableBlocksNetwork >> calledStandardFunctionBlocks [
	"Retorna una coleccion de declaraciones de Bloques de Funcion estandar."

	| collection collectionChild |

	"En collection estan las declaraciones de los bloques de funcion usados en la network"
	collection := self standardFunctionBlockConnectableBlocks collect: [ : each | each element declaration ].
	
	collectionChild := collection.
	
	"En collectionChild estan las declaraciones que puedan tener a su vez en su cuerpo estas declaraciones"
	collectionChild do:  [ :each |
		(each pouBody calledPOUs) 
			ifNotNil: [ 
				collection add: 
					each pouBody calledPOUs 
				] 
		].

	^ collection
]

{ #category : #'called POUs' }
PLC_ConnectableBlocksNetwork >> calledStandardFunctions [
	"Retorna una coleccion de declaraciones de Funciones estandar."

	^ self standardFunctionConnectableBlocks collect: [ : each | each element declaration ].
]

{ #category : #'called POUs' }
PLC_ConnectableBlocksNetwork >> calledUserFunctionBlocks [
	"Retorna una coleccion de declaraciones de Bloques Funcion definidos por el usuario."

	^ self userFunctionBlockConnectableBlocks collect: [ : each | each element declaration ].
]

{ #category : #'called POUs' }
PLC_ConnectableBlocksNetwork >> calledUserFunctions [
	"Retorna una coleccion de declaraciones de Funciones definidas por el usuario."

	^ self userFunctionConnectableBlocks collect: [ : each | each element declaration ].
]

{ #category : #'commands add-remove Elements' }
PLC_ConnectableBlocksNetwork >> changeActualArgumentFor: aPLC_ConnectableBlock by: aString [
	"Cambia el Actual Argument. "

	"HACER: 
	
	1 - le pase el string a su pou para que lo convierta en un objeto operando ( PARSEO )
	
	| operand |
	
	Devuelve un objeto que puede ser operando: variable, item de estructura, literal, o void;
	o devolver nil si el string es cualquier otra cosa.
	
	operand := self pouBody pou convertStringToOperand: aString
	
	2a - Si es operando, le pido al elemento actual argument del bc que le llega como parametro
	que cheque si le cabe que le asignen el operando. 
	Este operando seguro entiende dataType y dataValue. 
	Si es variable o item de estructura además se puede buscar su declaración 
		Si le cabe se pone el flag de 'valorInvalido' a False en el actual argument 
		Si no le cabe se pone el flag de 'valorInvalido' a True en el actual argument 
			Siempre se lo asigna (cambia el texto auque se ingrese cualquier verdura), 
			con el flag se determina si se dibuja en rojo o negro para indicar que se 
			va a poder compilar o no.
	
	2b - Si es nil le guarda un operando void al elemento actual argument.	
		
		
	LO DE ABAJO ES UN PARCHE PARA QUE SIGA ANDANDO, DESPUES HAY QUE SACAR TODO....
	"
	
	
	| argument |
	
	"Parseo mal hecho"
	argument := self parse: aString.		

	"Cambia el argumento actual"
	aPLC_ConnectableBlock element actualArgument: argument.
	

	^ true.
]

{ #category : #'commands for checks' }
PLC_ConnectableBlocksNetwork >> checkActualArgumentReader [
	"comment stating purpose of message"
	
	"HACERRRRRRRRRRRR"
	
	self pouBody.
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> functionBlockConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un llamado grafico a Bloque de Funcion."

	^ self blocks select: [ : each | each element isFunctionBlock ].
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> functionConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un llamado grafico a Funcion."

	^ self blocks select: [ : each | each element isFunction ].
]

{ #category : #'initialize-release' }
PLC_ConnectableBlocksNetwork >> initialize [
	"Inicializacion de la Network de Bloques Conectables"
	
	"creo la OC de bloques"
	self blocks: OrderedCollection new.
	
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> inputBlocks [
	"Retorna una coleccion de bloques conectables de entrada.
	Estos son los que no tienen entradas."

	^ self blocks select: [ : each | each isInputBlock ].
]

{ #category : #checks }
PLC_ConnectableBlocksNetwork >> moreWiredInputFor: aConnectableBlock [
	"Devuelve la mayor entrada cableada (conectada a algo que no sea Actual Argument Reader) buscando desde la primera hasta anInputNumber - 1."

	| maxInput |
	
	maxInput := 1.

	( 1 to: aConnectableBlock element inputs size ) do: [ :each |
		( self blockConnectedToInput: each) isActualArgumentReader not
			ifTrue: [
				maxInput := each.
				]. 
		].
		
	^ maxInput.
]

{ #category : #checks }
PLC_ConnectableBlocksNetwork >> moreWiredInputFor: aConnectableBlock until: anInputNumber [
	"Devuelve la mayor entrada cableada (conectada a algo que no sea Actual Argument Reader) buscando desde la primera hasta anInputNumber - 1."

	| maxInput |
	
	maxInput := 1.

	( 1 to: anInputNumber - 1) do: [ :each |
		( aConnectableBlock blockConnectedToInput: each) element isActualArgumentReader not
			ifTrue: [
				maxInput := each.
				]. 
		].
		
	^ maxInput.
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> networkController [
	^ networkController
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> networkController: anObject [
	networkController := anObject
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> networkLabel [
	^ networkLabel
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> networkLabel: anObject [
	networkLabel := anObject
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> outputBlocks [
	"Retorna una coleccion de bloques conectables de salida.
	Estos son los que no tienen salidas."

	^ self blocks select: [ : each | each isOutputBlock ].
]

{ #category : #PARSER }
PLC_ConnectableBlocksNetwork >> parse: aString [
	"PARSEO LO QUE LLEGUE ASI BUSCO LA VARIABLE CORRECTA"
	"aString Parseado pedorramente - Es true, false o numero 
	(entero o time)"
	
	| pouDecls decl varDecl argument |
	
	pouDecls := self pouBody pou declarations.
	
	
	decl := pouDecls includeVarDeclWithIdentifier: aString.
	
	decl 
		ifNil: [
			"No encontro declaracion. Chequeo si puedo convertir aString 
			a un literal, sino creo una nueva variable de la galera con ese
			identifier."
			
			"Parseo de Literales barato"
				
			"Pruebo si el string es TRUE"	
			( (aString = 'true') or: [(aString = 'True') or: [aString = 'TRUE'] ] ) 
				ifTrue: [
					"Si era true creo un Literal true"
					argument := ( PLC_Literal 
						newWithDataType: PLC_DataType Bool
						andDataValue: true	).
					]
				ifFalse: [
					"Pruebo si el string es FALSE"
					( (aString = 'false') or: [(aString = 'False') or: [aString = 'FALSE'] ] ) 
						ifTrue: [ 
							"Si era false creo un Literal false"
							argument := ( PLC_Literal 
								newWithDataType: PLC_DataType Bool
								andDataValue: false ).
							]
						ifFalse: [ 
							"Pruebo si es numerico ENTERO"
							aString isAllDigits
								ifTrue: [ 
									"Si era numero creo un Literal INT"
									argument := ( PLC_Literal 
										newWithDataType: PLC_DataType Int
										andDataValue: aString asNumber ).
									]
								ifFalse: [ 
									"Chequea si empieza con T# o TIME# para parsear el numero como TIME"
									( ( aString beginsWith: 'T#' ) or: [ aString beginsWith: 'TIME#'  ] )
										ifTrue: [ 
											"Si era numero creo un Literal TIME"
											argument := ( PLC_Literal 
												newWithDataType: PLC_DataType Time
												andDataValue: aString extractNumber ).
											] 
										ifFalse: [ 
											"NO PUDE PARSEARLO, INVENTO UNA DECLARACION DE VARIABLE"
											varDecl := PLC_SymbolicVariableDecl 
												newWithDataType: PLC_DataType Bool
												andInitialValue: nil 
												andIdentifier: aString.
											"Creo el Operando Variable a partir de la Declaración de Variable"
											argument := PLC_Variable 
												newWithDeclaration: varDecl 
												andDataValue: nil.
											].
									]. 
							]. 
					].
			]
		ifNotNil: [
			"Encontro declaracion, creo un nuevo Operando variable 
			con la declaración hallada"
			argument := PLC_Variable 
				newWithDeclaration: decl 
				andDataValue: decl initialValue.
			].
		
	^ argument.
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> pouBody [
	^ pouBody
]

{ #category : #accessing }
PLC_ConnectableBlocksNetwork >> pouBody: anObject [
	pouBody := anObject
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> removeBlock:  aConnectableBlock [
	"Remueve un bloque conectable de la Ordered Collection blocks"

	self blocks remove: aConnectableBlock.
]

{ #category : #'commands add-remove Elements' }
PLC_ConnectableBlocksNetwork >> removeContact: aPLC_ConnectableBlockContact [
	"Remueve un Contacto."

	| connectableBlockActualArgumentReader connectableBlockOutputPin connectableBlockInputPin |

	"Busco los pines de los bloques conectables conectados a la primer entrada y salida de la bobina"	
	connectableBlockOutputPin := ( aPLC_ConnectableBlockContact connectedAtInput: 1) outputPin.
	connectableBlockInputPin := ( aPLC_ConnectableBlockContact connectedAtOutput: 1) inputPin.
	
	"Busco el Actual Argument  Writer de la bobina"	
	connectableBlockActualArgumentReader := aPLC_ConnectableBlockContact blockConnectedToInput: 2.
	
	"Desconecto el Actual Argument  Writer de la bobina"
	( connectableBlockActualArgumentReader connectedAtOutput: 1 ) disconnect.
	
	"Desconecto la bobina"
	( aPLC_ConnectableBlockContact connectedAtInput: 1) disconnect.
	( aPLC_ConnectableBlockContact connectedAtOutput: 1) disconnect.
	
	"Remuevo los bloques conectables de la Network de bloques conectables"
	self removeBlock: aPLC_ConnectableBlockContact.
	self removeBlock: connectableBlockActualArgumentReader.
	
	"Conecto los pines obtenidos y realizo los chequeos pertinentes a LPR y VL"
	^ self checkShortCircuitIfConnect: connectableBlockOutputPin To: connectableBlockInputPin.
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> standardFunctionBlockConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un llamado grafico a Bloque de Funcion estandar."

	^ self functionBlockConnectableBlocks select: [ : each | ( each element declaration isUserDefined ) not ].
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> standardFunctionConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un llamado grafico a Funcion estandar."

	^ self functionConnectableBlocks select: [ : each | ( each element declaration isUserDefined ) not ].
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> userFunctionBlockConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un 
	llamado grafico a Bloque de Funcion definida por el usuario."

	^ self functionBlockConnectableBlocks select: [ : each | each element declaration isUserDefined ].
]

{ #category : #blocks }
PLC_ConnectableBlocksNetwork >> userFunctionConnectableBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un 
	llamado grafico a Funcion definida por el usuario."

	^ self functionConnectableBlocks select: [ : each | each element declaration isUserDefined ].
]
