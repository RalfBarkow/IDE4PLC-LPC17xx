"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LadderBody is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LadderBody',
	#superclass : #'PLC_POUBody',
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'called POUs' }
PLC_LadderBody >> addCalledPOUsIn: aCalledPOU [
	"Añade sus declaraciones de pou F y FB que llame en sus networks."
	
	self networks do: [ :each |
		
		"Añado las declaraciones de Funciones definidas por el usuario"
		aCalledPOU addUserFunctions:  each calledUserFunctions.
		
		"Añado las declaraciones de Funciones estandar"
		aCalledPOU addStandardFunctions:  each calledStandardFunctions.
		
		"Añado las declaraciones de Bloques de Funcion definidos por el usuario"
		aCalledPOU addUserFunctionBlocks:  each calledUserFunctionBlocks.
				
		"Añado las declaraciones de Bloques de Funcion estandar"
		aCalledPOU addStandardFunctionBlocks:  each calledStandardFunctionBlocks.
		 ].
	
	^ aCalledPOU.
]

{ #category : #'add-remove Networks' }
PLC_LadderBody >> addNetwork [
	"Añade un nuevo Network de Bloques Conectables."

	| net |
	
	net := PLC_LadderNetwork new.

	net pouBody: self.

	self networks 
		add: net.
		
	
]

{ #category : #compilation }
PLC_LadderBody >> generateCodeIn: aProgramAccumulator [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."

	self networks do: [ :each | 
		each generateCodeIn: aProgramAccumulator.
		].
]

{ #category : #test }
PLC_LadderBody >> language [
	"Devuelve el lenguaje del cuerpo de POU"

	^ 'LADDER DIAGRAM'
]
