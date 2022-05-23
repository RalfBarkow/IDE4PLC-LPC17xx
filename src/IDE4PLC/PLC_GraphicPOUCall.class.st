"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicPOUCall is xxxxxxxxx.

Instance Variables
	declaration:		<Object>
	instance:		<Object>
	network:		<Object>
	numberOfCompiledImputs:		<Object>

declaration
	- xxxxx

instance
	- xxxxx

network
	- xxxxx

numberOfCompiledImputs
	- xxxxx

"
Class {
	#name : #'PLC_GraphicPOUCall',
	#superclass : #'PLC_Element',
	#instVars : [
		'declaration',
		'instance',
		'numberOfCompiledImputs',
		'network'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #parallel }
PLC_GraphicPOUCall >> acceptParallel [
	"Responde true si la POU a la que llama este llamado a POU acepta estar conectada en una rama paralela en Ladder.
		
	Quiero agregar un elemento llamado a POU en la conexión ==
	
	|	c1		 c2			b1
	|-----|  |----------|  |-----+-----(  )------|
	|				    |
	|	c3			    |
	|-----|  |---------==----+	
	|
	"

	"Se lo delega a la declaraion de POU que conoce"
	^ self declaration acceptParallel.
]

{ #category : #declaration }
PLC_GraphicPOUCall >> buildElementInputs [
	"Devuelve la Coleccion de Entradas del elemento la cual genera a partir su Declaracion.
	Corresponden a los pines de Entrada del bloque conectable ordenados según las 
	categorías de variables."

	inputs := self buildInputs. 
	inputs addAll: self buildInOuts. 
	inputs add: self instance.		

	^ inputs.
]

{ #category : #declaration }
PLC_GraphicPOUCall >> buildElementOutputs [
	"Devuelve la Coleccion de Salidas del elemento la cual genera a partir su Declaracion.
	Corresponden a los pines de Entrada del bloque conectable ordenados según las 
	categorías de variables."

	outputs := self buildOutputs. 
	outputs addAll: self buildInOuts. 
	outputs add: self instance.	
		
	^ outputs.

]

{ #category : #declaration }
PLC_GraphicPOUCall >> buildInOuts [
	"Devuelve las Entrada-Salidas de su declaración."

	| decls |

	decls := OrderedCollection new.
	decls addAll: self declaration inOutVarDecls.
	
	^ decls.
]

{ #category : #declaration }
PLC_GraphicPOUCall >> buildInputs [
	"Devuelve las Entradas de su declaración."

	| decls |

	decls := OrderedCollection new.
	decls addAll: self declaration inputVarDecls.
	
	^ decls.

]

{ #category : #declaration }
PLC_GraphicPOUCall >> buildOutputs [
	"Devuelve las Salidas de su declaración."

	| decls |

	decls := OrderedCollection new.
	decls addAll: self declaration outputVarDecls.
	
	^ decls.

]

{ #category : #declaration }
PLC_GraphicPOUCall >> declaration [
	"Devuelve la declaración asociada a su instancia"

	^ declaration.
]

{ #category : #accessing }
PLC_GraphicPOUCall >> declaration: anObject [
	
	declaration := anObject
]

{ #category : #'graphic element' }
PLC_GraphicPOUCall >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."

	^ PLC_BlockMorph newFromConnectableBlock: aConnectableBlock.
]

{ #category : #'initialize-release' }
PLC_GraphicPOUCall >> initialize [
	"Inicializaciones"

	"Inicio en 0 la variable que indica la cantidad de entradas cableadas compiladas"
	self numberOfCompiledImputs: 0.
]

{ #category : #accessing }
PLC_GraphicPOUCall >> instance [
	
	^ instance.
]

{ #category : #accessing }
PLC_GraphicPOUCall >> instance: anObject [
	
	instance := anObject
]

{ #category : #accessing }
PLC_GraphicPOUCall >> network [
	
	^ network.
]

{ #category : #accessing }
PLC_GraphicPOUCall >> network: anObject [
	
	network := anObject
]

{ #category : #accessing }
PLC_GraphicPOUCall >> numberOfCompiledImputs [
	
	^ numberOfCompiledImputs
]

{ #category : #accessing }
PLC_GraphicPOUCall >> numberOfCompiledImputs: anObject [
	
	numberOfCompiledImputs := anObject
]

{ #category : #compilation }
PLC_GraphicPOUCall >> numberOfWiredInputsFor: aPLC_ConnectableBlock [
	"Devuelve el numero de entradas cableadas sin contar la primera"

	| cont |	
		
	cont := 0.

	( 2 to: self inputs size ) do: [ :each |
		(aPLC_ConnectableBlock blockConnectedToInput: each) element isActualArgumentReader
			ifFalse: [
				cont := cont + 1.
				]. 		
		].
		
	
]
