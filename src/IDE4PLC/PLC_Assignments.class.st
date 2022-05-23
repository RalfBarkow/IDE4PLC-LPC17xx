"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Assignments is xxxxxxxxx.

Instance Variables
	actualArgument:		<Object>
	formalParameter:		<Object>
	pouCall:		<Object>

actualArgument
	- xxxxx

formalParameter
	- xxxxx

pouCall
	- xxxxx

"
Class {
	#name : #'PLC_Assignments',
	#superclass : #Object,
	#instVars : [
		'pouCall',
		'formalParameter',
		'actualArgument'
	],
	#category : #'IDE4PLC-Operands'
}

{ #category : #'instance creation' }
PLC_Assignments class >> newWithFormalParameter: aFormalParameter andActtualArgument: anActualArgument [ 
	"Crea una nueva instancia con los 2 operandos pasados como parametros"

	| assignment |
	
	assignment := self new.
	
	assignment formalParameter: aFormalParameter.
	assignment actualArgument: anActualArgument.
	
	^ assignment.
]

{ #category : #'instance creation' }
PLC_Assignments class >> newWithFormalParameter: aFormalParameter andActtualArgument: anActualArgument andPouCall: aPouCall [
	"Crea una nueva instancia con los 3 parametros"

	| assignment |
	
	assignment := self new.
	
	assignment formalParameter: aFormalParameter.
	assignment actualArgument: anActualArgument.
	assignment pouCall: aPouCall.
	
	^ assignment.
]

{ #category : #accessing }
PLC_Assignments >> actualArgument [
	^ actualArgument
]

{ #category : #accessing }
PLC_Assignments >> actualArgument: anObject [
	actualArgument := anObject
]

{ #category : #accessing }
PLC_Assignments >> formalParameter [
	^ formalParameter
]

{ #category : #accessing }
PLC_Assignments >> formalParameter: anObject [
	formalParameter := anObject
]

{ #category : #accessing }
PLC_Assignments >> pouCall [
	^ pouCall
]

{ #category : #accessing }
PLC_Assignments >> pouCall: anObject [
	pouCall := anObject
]
