"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ST_Instruction is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_ST_Instruction',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #simulation }
PLC_ST_Instruction >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	| cCode operand compiledModifiers |
	
	compiledModifiers := ''.
	self modifiers do: [ :each|
		compiledModifiers := compiledModifiers , each cCompile.
		].
	
	self operands ifNotEmpty: [
		operand := (self operands first cCompile).
		].
	
	cCode := '		PLC_IL_' ,
		self operator ,
		 '( &(' , 
		operand , 
		'), sizeof(', 
		operand , 
		'), ' , 
		compiledModifiers , 
		');		// ', 
		self ilCompile.

	^ cCode.
]

{ #category : #simulation }
PLC_ST_Instruction >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	self operator: aPLC_CPU currentResult.
]

{ #category : #'as yet unclassified' }
PLC_ST_Instruction >> operator [
	"Operador de la instrucción"
	
	^ 'ST'.
]

{ #category : #'as yet unclassified' }
PLC_ST_Instruction >> semantics [
	"Semantica de la instrucción"
	
	^ 'Almacena el resultado actual en la ubicación operando: 
			operand := currentResult'.
]
