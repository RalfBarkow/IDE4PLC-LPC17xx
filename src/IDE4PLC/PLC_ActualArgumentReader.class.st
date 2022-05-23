"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ActualArgumentReader is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ActualArgumentReader',
	#superclass : #'PLC_ActualArgument',
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #accept }
PLC_ActualArgumentReader >> accept: anOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro.
	Necesito pasarle el bloque conectable para que pueda moverse 
	a través de las conexiones.
				   ______
 	 			   |		  |
 				   |		  |
	anOperand  --|	        |--  
			 	   |______|
	
	"
	
	anOperand isPLCLiteral
		ifTrue: [ ^ self acceptLiteral: anOperand in: aPLC_ConnectableBlock ].
	
	anOperand isVariable
		ifTrue: [ ^ self acceptVariable: anOperand in: aPLC_ConnectableBlock ].
	
	anOperand isStructItem 
		ifTrue: [ ^ self acceptStructItem: anOperand in: aPLC_ConnectableBlock ].
	
	anOperand isVoid
		ifTrue: [ ^ true ].
]

{ #category : #accept }
PLC_ActualArgumentReader >> acceptLiteral: aLiteralOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro"
	"
				   ______
 	 			   |		  |
 				   |		  |
		       10  --|	        |--  
			 	   |______|
	
	"
	
	| inputPinNumber otherConnectableBlock varDecl |
	
	"Obtengo el número de pin de entrada al que está conectado el pin de salida único este Actual Argument"
	inputPinNumber := aPLC_ConnectableBlock inputPinNumberConnectedToOutput: 1.
	
	"Obtengo el bloque conectable al que está conectado este Actual Argument"
	otherConnectableBlock := aPLC_ConnectableBlock blockConnectedToOutput: 1.
	
	"Obtengo la declaración de variable de la entrada numero inputPinNumber de otherConnectableBlock"
	varDecl := otherConnectableBlock inputs at: inputPinNumber.
	
	"CHEQUEO - Le pregunto a la variable si acepta el valor y el tipo del literal.
	Le pregunta tambien a su categoria: >>acceptLiteral"
	^ ( varDecl acceptLiteral: aLiteralOperand )
]

{ #category : #accept }
PLC_ActualArgumentReader >> acceptStructItem: aStructItemOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro"
	"
							   ______
 	 						   |		  |
 							   |		  |
	VAR_STRUCT.VAR_ITEM  --|	        |--  
						 	   |______|
	
	"
	
	"Hacer chequeos que faltan"

	^ false.
]

{ #category : #accept }
PLC_ActualArgumentReader >> acceptVariable: aVariableOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro
				   ______
 	 			   |		  |
 				   |		  |
		     VAR  --|	        |--  
			 	   |______|
	
	"
	
	"Hacer chequeos que faltan"

	| inputPinNumber otherConnectableBlock varDecl |
	
	"1 - PRIEMER CHEQUEO - Chequea si la varaible que quiero asignar puede leerse o no.
	Si no puede, sale, si puede sigue chequeando."
	( self canReadVariable: aVariableOperand )
		ifFalse: [ ^ false ].

	
	"Obtengo el número de pin de entrada al que está conectado el pin de salida único este Actual Argument"
	inputPinNumber := aPLC_ConnectableBlock inputPinNumberConnectedToOutput: 1.
	
	"Obtengo el bloque conectable al que está conectado este Actual Argument"
	otherConnectableBlock := aPLC_ConnectableBlock blockConnectedToOutput: 1.
	
	"Obtengo la declaración de variable de la entrada numero inputPinNumber de otherConnectableBlock"
	varDecl := otherConnectableBlock inputs at: inputPinNumber.
	
	
	"2 - SEGUNDO CHEQUEO - Le pregunto a la variable si acepta el tipo de aVariableOperand.
	Si da falso ya sale y sino hace el segundo chequeo"
	^ varDecl acceptVariable: aVariableOperand.


]

{ #category : #accept }
PLC_ActualArgumentReader >> canReadVariable: aVariableOperand [
	"Devuelve true si la variable (operando) que le llega como parámetro tiene permiso de lectura"
	
	^ ( aVariableOperand declaration variableCategory varType ~= '_OUTPUT' )
]

{ #category : #'initialize-release' }
PLC_ActualArgumentReader >> initialize [
	"Inicializaciones"

	super initialize.
	
	self addOutput.
]

{ #category : #testing }
PLC_ActualArgumentReader >> isActualArgumentReader [
	"Devuelve true si el elemento es una ActualArgumentReader."

	^ true.
]

{ #category : #library }
PLC_ActualArgumentReader >> keyword [
	"Devuelve el symbol del elemento"

	^ #ActualArgumentReader
]
