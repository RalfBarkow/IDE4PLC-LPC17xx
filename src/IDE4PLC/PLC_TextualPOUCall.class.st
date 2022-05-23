"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_TextualPOUCall is xxxxxxxxx.

Instance Variables
	declaration:		<Object>
	inOutAssignments:		<Object>
	inputAssignments:		<Object>
	instanceOperand:		<Object>
	outputAssignments:		<Object>

declaration
	- xxxxx

inOutAssignments
	- xxxxx

inputAssignments
	- xxxxx

instanceOperand
	- xxxxx

outputAssignments
	- xxxxx

"
Class {
	#name : #'PLC_TextualPOUCall',
	#superclass : #Object,
	#instVars : [
		'declaration',
		'instanceOperand',
		'inputAssignments',
		'outputAssignments',
		'inOutAssignments'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'instance creation' }
PLC_TextualPOUCall class >> newFromDeclaration: pouDeclaration andInstanceOperand: inst [
	"Crea un nuevo llamado IL a partir de la declaración pouDeclaration."

	| pouCall |
	
	pouCall := self new.	

	pouCall declaration: pouDeclaration.
	pouCall instanceOperand: inst.

	pouDeclaration inputVarDecls do: [ :each | 
		pouCall inputAssignments add: 
			( PLC_InputAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].

	pouDeclaration inOutVarDecls do: [ :each | 
		pouCall inOutAssignments add: 
			( PLC_InOutAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].

	pouDeclaration outputVarDecls do: [ :each | 
		pouCall outputAssignments add: 
			( PLC_OutputAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].
	
	^ pouCall.
]

{ #category : #compilation }
PLC_TextualPOUCall >> cPOUName [
	"Devuelve el nombre en C de la POU"
	
	"Ejemplo: 
	
	PLC_F_ADD_INT"
	
	^ self declaration cPOUName.
]

{ #category : #accessing }
PLC_TextualPOUCall >> declaration [
	
	^ declaration
]

{ #category : #accessing }
PLC_TextualPOUCall >> declaration: anObject [
	
	declaration := anObject
]

{ #category : #accessing }
PLC_TextualPOUCall >> inOutAssignments [
	
	^ inOutAssignments
]

{ #category : #accessing }
PLC_TextualPOUCall >> inOutAssignments: anObject [
	
	inOutAssignments := anObject
]

{ #category : #'initialize-release' }
PLC_TextualPOUCall >> initialize [
	"Inicializaciones"

	self inputAssignments: OrderedCollection new.
	self inOutAssignments: OrderedCollection new.
	self outputAssignments: OrderedCollection new.
]

{ #category : #accessing }
PLC_TextualPOUCall >> inputAssignments [
	
	^ inputAssignments
]

{ #category : #accessing }
PLC_TextualPOUCall >> inputAssignments: anObject [
	
	inputAssignments := anObject
]

{ #category : #compilation }
PLC_TextualPOUCall >> instanceName [
	"Devuelve el nombre de la Instancia de la POU"
	
	^ self instanceOperand identifier.
]

{ #category : #accessing }
PLC_TextualPOUCall >> instanceOperand [
	
	^ instanceOperand
]

{ #category : #accessing }
PLC_TextualPOUCall >> instanceOperand: anObject [
	
	instanceOperand := anObject
]

{ #category : #accessing }
PLC_TextualPOUCall >> outputAssignments [
	
	^ outputAssignments
]

{ #category : #accessing }
PLC_TextualPOUCall >> outputAssignments: anObject [
	
	outputAssignments := anObject
]

{ #category : #compilation }
PLC_TextualPOUCall >> pouName [
	"Devuelve el identificador de la POU"
	
	^ self declaration identifier.
]
