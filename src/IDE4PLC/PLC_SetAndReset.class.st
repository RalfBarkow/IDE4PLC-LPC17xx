"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_SetAndReset is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_SetAndReset',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'as yet unclassified' }
PLC_SetAndReset >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	| cCode operand |
	
	self operands ifNotEmpty: [
		operand := (self operands first cCompile).
		].
	
	cCode := '		PLC_IL_' ,
		self operator ,
		 '( &(' , 
		operand , 
		') );		// ', 
		self ilCompile.

	^ cCode.
]

{ #category : #simulation }
PLC_SetAndReset >> executeOn: aPLC_CPU [
	"Ejecuta la instruccion en la CPU aPLC_CPU"
	
	aPLC_CPU currentResult: self operator. 
]
