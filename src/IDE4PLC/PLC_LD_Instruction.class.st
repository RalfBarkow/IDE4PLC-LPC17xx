"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LD_Instruction is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LD_Instruction',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #compilation }
PLC_LD_Instruction >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	| cCode operand operandDataType compiledModifiers |
	
	compiledModifiers := ''.
	self modifiers do: [ :each|
		compiledModifiers := compiledModifiers , each cCompile.
		].
	
	self operands ifNotEmpty: [
		operand := (self operands first cCompile).
		
		operandDataType := (self operands first dataType ilCompileDataType). "ACA VA ilCompileDataType SI NO COMPILA MAL POR LO QUE REQUIERE LA INSTRUCCION"
		].
	
	"Compila en C segun si es literal u otra cosa"
	self operands first isPLCLiteral 
		ifTrue: [ 
			"void PLC_IL_LD_BOOL_Literal( PLC_BOOL, PLC_EnumModifiers);
			void PLC_IL_LD_INT_Literal( PLC_INT, PLC_EnumModifiers);"
			cCode := '		PLC_IL_' ,
				self operator ,
				'_' ,
				operandDataType, 
				'_Literal( ', 
				operand , 
				', ', 
				compiledModifiers , 
				');		// ', 
				self ilCompile.
			]
		ifFalse: [
			"PLC_IL_LD( &varName, sizeof(varName), varType, modifier);
			Ejemplo:
			PLC_IL_LD( &sint1, sizeof(sint1), SINT, NullModifier);
			"			
			cCode := '		PLC_IL_' ,
				self operator ,
				 '( &(' , 
				operand , 
				'), sizeof(', 
				operand , 
				'), ' , 
				operandDataType , 
				', ' , 
				compiledModifiers , 
				');		// ', 
				self ilCompile.
			].

	^ cCode.

]

{ #category : #simulation }
PLC_LD_Instruction >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	aPLC_CPU currentResult: self operator. 
]

{ #category : #compilation }
PLC_LD_Instruction >> operator [
	"Operador de la instrucción"
	
	^ 'LD'.
]

{ #category : #compilation }
PLC_LD_Instruction >> semantics [
	"Semantica de la instrucción"
	
	^ 'Almacena el operando en el acumulador resultado actual: 
			currentResult := operand'.

]
