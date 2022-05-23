"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CPU is xxxxxxxxx.

Instance Variables
	currentResult:		<Object>
	programCounter:		<Object>
	stack:		<Object>
	stackPointer:		<Object>

currentResult
	- xxxxx

programCounter
	- xxxxx

stack
	- xxxxx

stackPointer
	- xxxxx

"
Class {
	#name : #'PLC_CPU',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'currentResult',
		'programCounter',
		'stackPointer',
		'stack'
	],
	#classVars : [
		'FirstCheckFlag_BORRAME'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #accessing }
PLC_CPU class >> firstCheckFlag_BORRAME [
	^ FirstCheckFlag_BORRAME
]

{ #category : #accessing }
PLC_CPU class >> firstCheckFlag_BORRAME: anObject [
	FirstCheckFlag_BORRAME := anObject
]

{ #category : #'instance creation' }
PLC_CPU class >> lpc1769 [
	"Devuelve una instancia de PLC PLeriC"

	| cpu |
	
	cpu := self new.	
	cpu identifier: 'NXP_LPC1769_Microcontroller'.
	
	^ cpu.
]

{ #category : #accessing }
PLC_CPU >> currentResult [
	^ currentResult
]

{ #category : #accessing }
PLC_CPU >> currentResult: anObject [
	currentResult := anObject
]

{ #category : #'initialize-release' }
PLC_CPU >> initialize [
	"Inicializaciones"
	
	stack := 0.
	stackPointer := 0.
	programCounter := 0.
	currentResult := 0.
]

{ #category : #accessing }
PLC_CPU >> programCounter [
	^ programCounter
]

{ #category : #accessing }
PLC_CPU >> programCounter: anObject [
	programCounter := anObject
]

{ #category : #accessing }
PLC_CPU >> stack [
	^ stack
]

{ #category : #accessing }
PLC_CPU >> stack: anObject [
	stack := anObject
]

{ #category : #accessing }
PLC_CPU >> stackPointer [
	^ stackPointer
]

{ #category : #accessing }
PLC_CPU >> stackPointer: anObject [
	stackPointer := anObject
]
