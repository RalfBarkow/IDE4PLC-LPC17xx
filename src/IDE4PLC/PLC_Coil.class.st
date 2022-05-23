"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Coil is xxxxxxxxx.

Instance Variables
	modifier:		<Object>
	morph:		<Object>

modifier
	- xxxxx

morph
	- xxxxx

"
Class {
	#name : #'PLC_Coil',
	#superclass : #'PLC_Element',
	#instVars : [
		'modifier',
		'morph'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #connectableBlocks }
PLC_Coil >> actualArgumentFor: aPLC_ConnectableBlock [
	"Devuelve el actualArgument que en este caso es una variable simbolica simple"
			
	^ ( self connectableBlockActualArgumentFor: aPLC_ConnectableBlock ) element actualArgument
]

{ #category : #connectableBlocks }
PLC_Coil >> connectableBlockActualArgumentFor: aPLC_ConnectableBlock [
	"Devuelve el actualArgument"
			
	^ (aPLC_ConnectableBlock blockConnectedToOutput: 2).
]

{ #category : #connectableBlocks }
PLC_Coil >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ aPLC_ConnectableBlock connectedAtOutput: 1.
	
	"Hacer que compruebe aquí si puede conectar o no el elemento nuevo pidiendole a los bloques de sus extremos si lo permiten"
	
	"SI NO PERMITEN DEVUELVEN NIL"
]

{ #category : #compilation }
PLC_Coil >> generateCodeIn: aProgramAccumulator for: aPLC_ConnectableBlock [
	"Agrega los objetos que genera a aObjectProgram.
	Como es una instancia única debo pasarle como parámetro el bloque para el cual quiero que compile
	para que pueda leer sus entradas y salidas."
	
	| instruction |
	
	
	PLC_CPU firstCheckFlag_BORRAME
		ifTrue: [
			
			"Genero: LD true - Para comenzar con el CR en 1 en el caso que la bobina 
			o bloque de funcion este conectado directamente a la barra izquieda"
			
			instruction := PLC_LD_Instruction new.	
			instruction modifiers add: PLC_IL_Modifiers NullModifier. 
			instruction operands add: (PLC_Literal newWithDataType: PLC_DataType Bool andDataValue: true).	
				
			"Agrego los objetos generados, estos deben entende ilCompile y cCompile"
			aProgramAccumulator add: instruction.		
			].
	PLC_CPU firstCheckFlag_BORRAME: false.
		
	
	instruction := PLC_ST_Instruction new.
		
	instruction modifiers add: self modifier.
	
	instruction operands add: (self actualArgumentFor: aPLC_ConnectableBlock).
			
	"Agrego los objetos generados, estos deben entende ilCompile y cCompile"
	aProgramAccumulator add: instruction.
	
	(aPLC_ConnectableBlock blockConnectedToOutput: 1) generateCodeIn: aProgramAccumulator.
]

{ #category : #'graphic element' }
PLC_Coil >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."
		
	"Esto esta feo, es casi igual a preguntar por al clase"
	( self modifier isNullModifier )
		ifTrue: [
			^ PLC_CoilMorph newFromConnectableBlock: aConnectableBlock.
			] 
		ifFalse: [
			^ PLC_NCoilMorph newFromConnectableBlock: aConnectableBlock.
			].
]

{ #category : #'initialize-release' }
PLC_Coil >> initialize [
	"Inicializaciones"

	super initialize.
	
	self addInput.
	self addOutput.
	self addOutput.
]

{ #category : #testing }
PLC_Coil >> isCoil [
	"Devuelve true si el elemento es una Bobina."

	^ true.
]

{ #category : #accessing }
PLC_Coil >> modifier [
	^ modifier
]

{ #category : #accessing }
PLC_Coil >> modifier: anObject [
	modifier := anObject
]

{ #category : #accessing }
PLC_Coil >> morph [
	^ morph
]

{ #category : #accessing }
PLC_Coil >> morph: anObject [
	morph := anObject
]
