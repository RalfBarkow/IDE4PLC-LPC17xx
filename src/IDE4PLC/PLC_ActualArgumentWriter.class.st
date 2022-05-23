"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ActualArgumentWriter is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ActualArgumentWriter',
	#superclass : #'PLC_ActualArgument',
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #accept }
PLC_ActualArgumentWriter >> accept: anOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro.
	Necesito pasarle el bloque conectable para que pueda moverse 
	a través de las conexiones.
	  ______
 	  |		|
 	  |		|
	--|	      |--  anOperand
	  |_____|
	
	"
	
	anOperand isPLCLiteral
		ifTrue: [ ^ false ].
	
	anOperand isVariable
		ifTrue: [ ^ self acceptVariable: anOperand in: aPLC_ConnectableBlock ].
	
	anOperand isStructItem 
		ifTrue: [ ^ self acceptStructItem: anOperand in: aPLC_ConnectableBlock ].
	
	anOperand isVoid
		ifTrue: [ ^ true ].
]

{ #category : #accept }
PLC_ActualArgumentWriter >> acceptStructItem: aStructItemOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro"
	"
	  ______
 	  |		|
 	  |		|
	--|	      |--  VAR_STRUCT.VAR_ITEM
	  |_____|
	
	"
	
	"Hacer chequeos que faltan"

	^ false.
]

{ #category : #accept }
PLC_ActualArgumentWriter >> acceptVariable: aVariableOperand in: aPLC_ConnectableBlock [
	"Devuelve true acepta el operando que le llega como parámetro"
	"
	  ______
 	  |		|
 	  |		|
	--|	      |--  VAR
	  |_____|
	
	"
	
	"Hacer chequeos que faltan"
	
	"Chequeo 2"
	^ self canWriteVariable: aVariableOperand.
]

{ #category : #accept }
PLC_ActualArgumentWriter >> canWriteVariable: aVariableOperand [
	"Devuelve true si la variable (operando) que le llega como parámetro tiene permiso de escritura"
	"Todas pueden escribirse menos las inputs es decir:
	
	  ______
 	  |		|
 	  |		|
	--|	      |--  aVariableOperand
	  |_____|
	
	Se fija si puede ponerle un valor a aVariableOperand
	"
	
	^ ( aVariableOperand declaration variableCategory varType ~= '_INPUT' )
]

{ #category : #connectableBlocks }
PLC_ActualArgumentWriter >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	| connectableBlock |

	"Busco el contacto, bobina o bloque conectado al actual argument"
	connectableBlock := aPLC_ConnectableBlock blockConnectedToInput: 1.
	
	"Le pido la conexion para añadirle un nuevo elemento"
	^ connectableBlock element connectionToAddElement: aPLC_ElemenMorph inBlock: connectableBlock.
]

{ #category : #'initialize-release' }
PLC_ActualArgumentWriter >> initialize [
	"Inicializaciones"

	super initialize.
	
	self addInput.
]

{ #category : #testing }
PLC_ActualArgumentWriter >> isActualArgumentWriter [
	"Devuelve true si el elemento es una ActualArgumentWriter."

	^ true.
]

{ #category : #library }
PLC_ActualArgumentWriter >> keyword [
	"Devuelve el symbol del elemento"

	^ #ActualArgumentWriter
]
