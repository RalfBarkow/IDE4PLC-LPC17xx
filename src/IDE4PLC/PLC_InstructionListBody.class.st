"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_InstructionListBody is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_InstructionListBody',
	#superclass : #'PLC_POUBody',
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #compilation }
PLC_InstructionListBody >> addNetwork [
	"Añade un nuevo Network de Bloques Conectables programa Ladder."

	"HACERRRRRRRRRRRRRRRRRRRRRRRR"

	self networks add: 1.
]

{ #category : #test }
PLC_InstructionListBody >> language [
	"Devuelve el lenguaje del cuerpo de POU"

	^ 'INSTRUCTION LIST'
]

{ #category : #compilation }
PLC_InstructionListBody >> objectCompileIn: aObjectProgram [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."

	"DEBE CONVERTIR UN STRING DE INSTRUCCIONES IL EN OBJETOS IL"
]
