"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Function_Declarations is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Function_Declarations',
	#superclass : #'PLC_POU_Declarations',
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #instance }
PLC_Function_Declarations >> structureDeclaration [
	"Declaracion de tipo de dato estructurado."

	| struct |

	struct := PLC_StructureDecl 
		newWithIdentifier: self structureDeclarationIdentifier.

	"AÑADO LAS VARIABLES A LA ESTRUCTURA"

	"Variables de Entrada"
	self inputVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables de Entrada-Salida"
	self inOutVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables de Salida"
	self outputVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables Internas"
	self varDecls do: [ :each |
		struct add: each.
		].
	
	"Variable de Return"
	self returnVarDecl do: [ :each |
		struct add: each.
		].
	 
	
	^ struct.
]
