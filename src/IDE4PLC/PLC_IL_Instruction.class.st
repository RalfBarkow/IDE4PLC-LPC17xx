"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_IL_Instruction is xxxxxxxxx.

Instance Variables
	label:		<Object>
	modifiers:		<Object>
	operands:		<Object>

label
	- xxxxx

modifiers
	- xxxxx

operands
	- xxxxx

"
Class {
	#name : #'PLC_IL_Instruction',
	#superclass : #Object,
	#instVars : [
		'label',
		'modifiers',
		'operands'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #simulation }
PLC_IL_Instruction >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	
]

{ #category : #compilation }
PLC_IL_Instruction >> ilCompile [
	"Devuelve el string del código IL de la instrucción"
	
	| ilCode |
	
	self label = '' 
		ifTrue:[
			ilCode := '			' , self operator.			"Ej: 		 LD"
			]
		ifFalse: [
			 ilCode := '		' , self label , ' ' , self operator.	"Ej: 		LABEL: LD"
			]. 
	
	self modifiers do: [ :each|
		ilCode := ilCode , each ilCompile.
		].									"Ej: 		LABEL: LDN"
	
	self operands ifNotEmpty: [
		ilCode := ilCode , ' ' , (self operands first ilCompile).
		
		(2 to: operands size) do: [ :each|
			ilCode := ilCode , ', ' , (self operands at: each) ilCompile.
			].
		]..									"Ej: 		LABEL: LDN %I0.0"
	
	"ilCode := ilCode , ' ' , self comment."		"Ej: 		LABEL: LDN %I0.0    (* Comentario *)"
	
	ilCode := ilCode , '
'.
	
	^ ilCode.
]

{ #category : #'initialize-release' }
PLC_IL_Instruction >> initialize [
	"Inicializaciones"
	
	self label: ''.
	self modifiers: OrderedCollection new.
	self operands: OrderedCollection new.
	
]

{ #category : #accessing }
PLC_IL_Instruction >> label [
	^ label
]

{ #category : #accessing }
PLC_IL_Instruction >> label: anObject [
	label := anObject
]

{ #category : #accessing }
PLC_IL_Instruction >> modifiers [
	^ modifiers
]

{ #category : #accessing }
PLC_IL_Instruction >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
PLC_IL_Instruction >> operands [
	^ operands
]

{ #category : #accessing }
PLC_IL_Instruction >> operands: anObject [
	operands := anObject
]
