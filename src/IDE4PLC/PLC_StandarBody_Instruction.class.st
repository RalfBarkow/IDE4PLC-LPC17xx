"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_StandarBody_Instruction is xxxxxxxxx.

Instance Variables
	cCode:		<Object>

cCode
	- xxxxx

"
Class {
	#name : #'PLC_StandarBody_Instruction',
	#superclass : #'PLC_IL_Instruction',
	#instVars : [
		'cCode'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #accessing }
PLC_StandarBody_Instruction >> cCode [
	
	^ cCode
]

{ #category : #accessing }
PLC_StandarBody_Instruction >> cCode: anObject [
	
	cCode := anObject
]

{ #category : #compilation }
PLC_StandarBody_Instruction >> cCompile [
	"Devuelve el string del código C de la instrucción"
	
	^ self cCode.
	
]

{ #category : #compilation }
PLC_StandarBody_Instruction >> operator [
	"Operador de la instrucción"
	
	^ 'POU estandar, no se muestra su código.'.
]

{ #category : #compilation }
PLC_StandarBody_Instruction >> semantics [
	"Semantica de la instrucción"
	
	^ 'Instrucción que indica que es una POU estándar y por eso no se muestra su código.'.

]
