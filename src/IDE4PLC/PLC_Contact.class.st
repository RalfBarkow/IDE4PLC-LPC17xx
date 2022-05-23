"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Contact is xxxxxxxxx.

Instance Variables
	modifier:		<Object>
	morph:		<Object>

modifier
	- xxxxx

morph
	- xxxxx

"
Class {
	#name : #'PLC_Contact',
	#superclass : #'PLC_Element',
	#instVars : [
		'modifier',
		'morph'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #parallel }
PLC_Contact >> acceptParallel [
	"Responde true si el elemento acepta estar conectado en una rama paralela en Ladder.
	
	|	c1		 c2			b1
	|-----|  |----------|  |-----+-----(  )------|
	|				    |
	|	c3			    |
	|-----|  |---------==----+	
	|
	
	Quiero agregar un elemento en la conexión ==
	
	"

	^ true.
]

{ #category : #conectableBlocks }
PLC_Contact >> actualArgumentFor: aPLC_ConnectableBlock [
	"Devuelve el actualArgument que en este caso es una variable simbolica simple"
			
	^ ( self connectableBlockActualArgumentFor: aPLC_ConnectableBlock ) element actualArgument
]

{ #category : #conectableBlocks }
PLC_Contact >> connectableBlockActualArgumentFor: aPLC_ConnectableBlock [
	"Devuelve el actualArgument"
			
	^ (aPLC_ConnectableBlock blockConnectedToInput: 2).
]

{ #category : #conectableBlocks }
PLC_Contact >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ aPLC_ConnectableBlock connectedAtOutput: 1.
	
	"Hacer que compruebe aquí si puede conectar o no el elemento nuevo pidiendole a los bloques de sus extremos si lo permiten"
	
	"SI NO PERMITEN DEVUELVEN NIL"
]

{ #category : #compilation }
PLC_Contact >> generateCodeIn: aProgramAccumulator for: aPLC_ConnectableBlock [
	"Agrega los objetos que genera a aObjectProgram.
	Como es una instancia única debo pasarle como parámetro el bloque para el cual quiero que compile
	para que pueda leer sus entradas y salidas."
	
	| instruction |
	
	PLC_CPU firstCheckFlag_BORRAME
		ifTrue: [
			instruction := PLC_LD_Instruction new.	
			] 
		ifFalse: [
			instruction := PLC_AND_Instruction new.	
			].
		
	PLC_CPU firstCheckFlag_BORRAME: false.

	instruction modifiers add: self modifier.
	
	instruction operands add: (self actualArgumentFor: aPLC_ConnectableBlock).	
			
	"Agrego los objetos generados, estos deben entende ilCompile y cCompile"
	aProgramAccumulator add: instruction.

	(aPLC_ConnectableBlock blockConnectedToOutput: 1) generateCodeIn: aProgramAccumulator.

]

{ #category : #'graphic element' }
PLC_Contact >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."
	
	"Esto esta feo, es casi igual a preguntar por al clase"
	( self modifier isNullModifier )
		ifTrue: [
			^ PLC_NOContactMorph newFromConnectableBlock: aConnectableBlock.
			] 
		ifFalse: [
			^ PLC_NCContactMorph newFromConnectableBlock: aConnectableBlock.
			].
	
	
]

{ #category : #'initialize-release' }
PLC_Contact >> initialize [
	"Inicializaciones"

	super initialize.
	
	self addInput.
	self addInput.
	self addOutput.
]

{ #category : #testing }
PLC_Contact >> isContact [
	"Devuelve true si el elemento es un Contacto."

	^ true.
]

{ #category : #accessing }
PLC_Contact >> modifier [
	^ modifier
]

{ #category : #accessing }
PLC_Contact >> modifier: anObject [
	modifier := anObject
]

{ #category : #accessing }
PLC_Contact >> morph [
	^ morph
]

{ #category : #accessing }
PLC_Contact >> morph: anObject [
	morph := anObject
]
