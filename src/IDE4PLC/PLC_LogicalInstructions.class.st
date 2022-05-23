"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LogicalInstructions is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LogicalInstructions',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'as yet unclassified' }
PLC_LogicalInstructions >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	| cCode operand operandDataType compiledModifiers |
	
	compiledModifiers := ''.
	self modifiers do: [ :each|
		compiledModifiers := compiledModifiers , each cCompile.
		].
	
	self operands ifNotEmpty: [
		operand := (self operands first cCompile).
		operandDataType := (self operands first dataType ilCompileDataType).
		].

	cCode := '		PLC_IL_' ,
		self operator ,
		 '( &(' , 
		operand , 
		'), ', 
		operandDataType , 
		', ' , 
		compiledModifiers , 
		');		// ', 
		self ilCompile.

	^ cCode.
]

{ #category : #simulation }
PLC_LogicalInstructions >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	aPLC_CPU currentResult: ( aPLC_CPU currentResult operateWith: self operator). 
]
