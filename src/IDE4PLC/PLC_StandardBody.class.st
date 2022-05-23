"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_StandardBody is xxxxxxxxx.

Instance Variables
	cCode:		<Object>
	calledPOUs:		<Object>

cCode
	- xxxxx

calledPOUs
	- xxxxx

"
Class {
	#name : #'PLC_StandardBody',
	#superclass : #'PLC_POUBody',
	#instVars : [
		'cCode',
		'calledPOUs'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'called POUs' }
PLC_StandardBody >> addCalledPOUsIn: aCalledPOU [
	"Añade sus declaraciones de pou F y FB que llame en sus networks.
	
	LO USAN LOS TIMERS Y CONTADORES PARA AGREGAR SU DETECCIÓN DE FLANCO"
	
	"Añado las declaraciones de Bloques de Funcion estandar"
	aCalledPOU addStandardFunctionBlocks: self calledPOUs.
	
	^ aCalledPOU.
]

{ #category : #accessing }
PLC_StandardBody >> addNetwork [
	"Añade un nuevo Network de Bloques Conectables programa Ladder."

	"No hace nada al ser estandar"
]

{ #category : #accessing }
PLC_StandardBody >> cCode [
	
	^ cCode
]

{ #category : #accessing }
PLC_StandardBody >> cCode: anObject [
	
	cCode := anObject
]

{ #category : #accessing }
PLC_StandardBody >> calledPOUs [
	
	^ calledPOUs
]

{ #category : #accessing }
PLC_StandardBody >> calledPOUs: anObject [
	
	calledPOUs := anObject
]

{ #category : #compilation }
PLC_StandardBody >> generateCodeIn: aProgramAccumulator [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."
	"Este cuerpo de POU representa el Cuerpo de POU de las funciones estándar que ya vienen compiladas.
	Agrega una instrucción IL que en IL genera, ''Código no mostrado'' y en C devuelve todo el codigo"

	| instruction |
	
	instruction := PLC_StandarBody_Instruction new.
	
	instruction cCode: self cCode.
		
	instruction modifiers add: PLC_IL_Modifiers NullModifier. 

	aProgramAccumulator add: instruction.
	
	


]

{ #category : #test }
PLC_StandardBody >> isUserDefined [
	"Responde True si es un cuerpo de pou definido por el usuario. si es estandar responde false"

	^ false
]
