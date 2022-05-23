"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_NOT_Instruction is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_NOT_Instruction',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'as yet unclassified' }
PLC_NOT_Instruction >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	| cCode operandDataType |
	
	self operands ifNotEmpty: [
		operandDataType := (self operands first dataType ilCompileDataType).
		].

	cCode := '		PLC_IL_' ,
		self operator ,
		 '( ' , 
		operandDataType , 
		');		// ', 
		self ilCompile.

	^ cCode.
]

{ #category : #simulation }
PLC_NOT_Instruction >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	aPLC_CPU currentResult: self operator. 
]

{ #category : #'as yet unclassified' }
PLC_NOT_Instruction >> operator [
	"Operador de la instrucción"
	
	^ 'NOT'.
]

{ #category : #'as yet unclassified' }
PLC_NOT_Instruction >> semantics [
	"Semantica de la instrucción"
	
	^ 'Realiza la operación de negacion bit a bit: 
	currentResult := NOT currentResult'.
]
