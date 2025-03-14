"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_InputAssignment is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_InputAssignment',
	#superclass : #'PLC_Assignments',
	#category : #'IDE4PLC-Operands'
}

{ #category : #compilation }
PLC_InputAssignment >> cCompile [
	"Compila la declaración de variable a C

	Devuelve por ejemplo:
	
	INST.IN = VAR
	
	"
	
	| cCode |
	
	
	"Chequeo que Tenga algo asignado sino no lo compilo"
	( self actualArgument dataType ~= PLC_DataType Void )
		ifTrue: [ 
			
			"Genero NombreInstancia"
			cCode := self pouCall instanceOperand cCompile.

			"Genero NombreInstancia.VarInterna"
			cCode := cCode , '.' , self formalParameter identifier.
	
			"Genero NombreInstancia.VarInterna = Argumento"
			cCode := cCode  , ' = ' , self actualArgument cCompile.
	
			^ cCode.
			
			]
		ifFalse: [ 
			^ ''.
			].


]

{ #category : #compilation }
PLC_InputAssignment >> ilCompile [
	"Compila la declaración de variable a IL

	Devuelve por ejemplo:
	
	IN := VAR
	
	"

	"Chequeo que Tenga algo asignado sino no lo compilo"
	( self actualArgument dataType ~= PLC_DataType Void )
		ifTrue: [ 
			^ self formalParameter identifier , ' := ' , self actualArgument ilCompile.
			]
		ifFalse: [ 
			^ ''.
			].
]

{ #category : #library }
PLC_InputAssignment >> keyword [
	"Devuelve el symbol del elemento"

	^ #InputAssignment 
]
