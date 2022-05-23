"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_ConnectableBlock is xxxxxxxxx.

Instance Variables
	connectableBlocksNetwork:		<Object>
	element:		<Object>
	inputs:		<Object>
	outputs:		<Object>

connectableBlocksNetwork
	- xxxxx

element
	- xxxxx

inputs
	- xxxxx

outputs
	- xxxxx

"
Class {
	#name : #'PLC_ConnectableBlock',
	#superclass : #Object,
	#instVars : [
		'connectableBlocksNetwork',
		'element',
		'inputs',
		'outputs'
	],
	#category : #'IDE4PLC-ConnectableBlocks'
}

{ #category : #'instance creation' }
PLC_ConnectableBlock class >> newWithElement: aPLC_Element [

	| tempBlock |
	
	tempBlock := self new.
	tempBlock element: aPLC_Element.
	
	tempBlock buildInputs;
		buildOutputs.
	
	^ tempBlock.

]

{ #category : #simulacion }
PLC_ConnectableBlock >> SosBloqueDeSalida [
	
	^false.


]

{ #category : #simulacion }
PLC_ConnectableBlock >> SosBloqueDerivador [
	
	^false.


]

{ #category : #building }
PLC_ConnectableBlock >> addInput [
	"Añade un pin de entrada al Bloque Conectable y le añade una entrada a su elemento."
	
	"VER SI LE TENGO QUE PASAR COSAS POR PARAMETRO AL ELEMENTO COMO SER LA CATEGORIA DE SALIDA DE ENTRADA"

	self addInputPin.
	self element addInput.


]

{ #category : #building }
PLC_ConnectableBlock >> addInputPin [

	self inputs add: (PLC_ConnectableBlockPin InputFor: self).

]

{ #category : #building }
PLC_ConnectableBlock >> addInputPinAfter: aPin [
	"Añade un nuevo pin de salida al Bloque Conectable despues del pin de salida aPin."

	self inputs 
		add: (PLC_ConnectableBlockPin InputFor: self)
		after: aPin.
]

{ #category : #building }
PLC_ConnectableBlock >> addOutput [
	"Añade un pin de salida al Bloque Conectable y le añade una salida a su elemento."

	self addOutputPin.
	self element addOutput.


]

{ #category : #building }
PLC_ConnectableBlock >> addOutputAfter: aPin [
	"Añade un pin de salida al Bloque Conectable y le añade una salida a su elemento
	despues del pin de salida aPin."

	self addOutputPinAfter: aPin.
	self element addOutput.


]

{ #category : #building }
PLC_ConnectableBlock >> addOutputPin [

	self outputs add: (PLC_ConnectableBlockPin OutputFor: self).

]

{ #category : #building }
PLC_ConnectableBlock >> addOutputPin: pinToAdd after: aPin [
	"Añade el pin de salida pinToAdd al Bloque Conectable despues del pin de salida aPin."

	self outputs 
		add: pinToAdd
		after: aPin.
]

{ #category : #building }
PLC_ConnectableBlock >> addOutputPinAfter: aPin [
	"Añade un nuevo pin de salida al Bloque Conectable despues del pin de salida aPin."

	self outputs 
		add: (PLC_ConnectableBlockPin OutputFor: self)
		after: aPin.
]

{ #category : #connections }
PLC_ConnectableBlock >> blockConnectedToInput: anInputNumber [
	"Devuelve el bloque conectado a la entrada anInputNumber."
	
	| connection |
	
	self inputs size >= anInputNumber
		ifTrue: [
			connection := (self inputs at: anInputNumber) connection.
			connection
				ifNil: [
					^ nil.
					] 
				ifNotNil: [
					^ connection outputPin block.
					].
			]
		ifFalse: [
			^ nil.
			].
		
]

{ #category : #connections }
PLC_ConnectableBlock >> blockConnectedToOutput: anOutputNumber [
	"Devuelve el bloque conectado a la salida anInputNumber."
	
	| connection |
	
	self outputs size >= anOutputNumber
		ifTrue: [
			connection := (self outputs at: anOutputNumber) connection.
			connection
				ifNil: [
					^ nil.
					] 
				ifNotNil: [
					^ connection inputPin block.
					].
			]
		ifFalse: [
			^ nil.
			].
		
]

{ #category : #building }
PLC_ConnectableBlock >> buildInputs [
	"Construye las entradas del bloque conectable. Para lograrlo, añade todas las entradas preguntandole la cantidad a su Elemento."
	
	self inputs: OrderedCollection new.
	self element connectableBlockInputs timesRepeat: [self addInputPin].	

]

{ #category : #building }
PLC_ConnectableBlock >> buildOutputs [
	"Construye las salidas del bloque conectable. Para lograrlo, añade todas las salidas preguntandole la cantidad a su Elemento."

	self outputs: OrderedCollection new.
	self element connectableBlockOutputs timesRepeat: [self addOutputPin].
]

{ #category : #compilation }
PLC_ConnectableBlock >> cCompile [
	"Compila el bloque pidiendoselo a su elemento."

	| ilBlockCode |
	
	self element cCompileFor: self.
	
	
]

{ #category : #simulacion }
PLC_ConnectableBlock >> condicionInicial: unValor ParaLaSalida: unNumeroDeSalida [
	"Carga la condicion inicial unValor en la OrderedCollection salidas en la posicion que le paso en unNumeroDeSalida."

	self salidas at: unNumeroDeSalida put: unValor.
]

{ #category : #accessing }
PLC_ConnectableBlock >> conexionesDeEntrada [
	^ inputConnections
]

{ #category : #accessing }
PLC_ConnectableBlock >> conexionesDeEntrada: anObject [
	inputConnections := anObject
]

{ #category : #accessing }
PLC_ConnectableBlock >> connectableBlocksNetwork [
	
	^ connectableBlocksNetwork
]

{ #category : #accessing }
PLC_ConnectableBlock >> connectableBlocksNetwork: anObject [
	
	connectableBlocksNetwork := anObject
]

{ #category : #connections }
PLC_ConnectableBlock >> connectedAtInput: anInputNumber [
	"Devuelve la conexion a la entrada anInputNumber."
	
	self inputs size >= anInputNumber
		ifTrue: [
			^ (self inputs at: anInputNumber) connection.
			]
		ifFalse: [
			^ nil.
			].
		
]

{ #category : #connections }
PLC_ConnectableBlock >> connectedAtOutput: anOutputNumber [
	"Devuelve la conexion a la salida anOutputNumber."
	
	self outputs size >= anOutputNumber
		ifTrue: [
			^ (self outputs at: anOutputNumber) connection.
			]
		ifFalse: [
			^ nil.
			].
		
]

{ #category : #connections }
PLC_ConnectableBlock >> connectionToAddElement: aPLC_ElemenMorph [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ self element connectionToAddElement: aPLC_ElemenMorph inBlock: self
]

{ #category : #connections }
PLC_ConnectableBlock >> disconnectInput: anInputNumber [
	"Desconecta la entrada numero 'anInputNumber' del bloque al que le mando este mensaje."

	(self inputs at: anInputNumber) disconnect.
]

{ #category : #connections }
PLC_ConnectableBlock >> disconnectOutput: anOutputNumber [
	"Desconecta la entrada del bloque al que estaba conectado."

	(self outputs at: anOutputNumber) disconnect.
]

{ #category : #accessing }
PLC_ConnectableBlock >> element [
	^ element
]

{ #category : #accessing }
PLC_ConnectableBlock >> element: anObject [
	element := anObject
]

{ #category : #accessing }
PLC_ConnectableBlock >> entradas [
	^ inputs
]

{ #category : #accessing }
PLC_ConnectableBlock >> entradas: anObject [
	inputs := anObject
]

{ #category : #compilation }
PLC_ConnectableBlock >> generateCodeIn: aProgramAccumulator [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."
	"Compila el bloque pidiendoselo a su elemento. Se pasa como parámetro debido a
	que algunos elementos son únicos"
		
	self element generateCodeIn: aProgramAccumulator for: self.
]

{ #category : #drawing }
PLC_ConnectableBlock >> graphicElement [
	"Devuelve el elemento grafico (morph) de su elemento."

	^ self element graphicElementFor: self.
]

{ #category : #simulacion }
PLC_ConnectableBlock >> guardarValorDeEntrada: unValor [
	"Agrega el valor unValor a la OrderedCollection entradas."

	self entradas add: unValor.
]

{ #category : #compilation }
PLC_ConnectableBlock >> ilCompile [
	"Compila el bloque pidiendoselo a su elemento."

	| ilBlockCode |
	
	self element ilCompileFor: self.
	
	
]

{ #category : #connections }
PLC_ConnectableBlock >> input: anInputNumber connectTo: aConnectableBlock output: anOutputNumber [
	"Conecta la entrada numero anInputNumber del bloque al que le mando este mensaje con la salida numero anOutputNumber de aConnectableBlock."
	
	^ aConnectableBlock output: anOutputNumber connectTo: self input: anInputNumber.
]

{ #category : #connections }
PLC_ConnectableBlock >> inputPinAfter: unPin [
	"Devuelve el pin de salida posterior a unPin."
	
	^self inputs after: unPin ifAbsent: [ nil ] 
]

{ #category : #connections }
PLC_ConnectableBlock >> inputPinNumberConnectedToOutput: anOutputNumber [
	"Devuelve el Numero de pin de entrada que esta conectado al pin de salida anOutputNumber."
	
	| connection connectableBlock |
	
	self outputs size >= anOutputNumber
		ifTrue: [
			connection := (self outputs at: anOutputNumber) connection.
			connection
				ifNil: [
					^ nil.
					] 
				ifNotNil: [
					connectableBlock := connection inputPin block.
					^ connectableBlock inputs indexOf: connection inputPin.
					].
			]
		ifFalse: [
			^ nil.
			].
]

{ #category : #accessing }
PLC_ConnectableBlock >> inputs [
	^ inputs
]

{ #category : #accessing }
PLC_ConnectableBlock >> inputs: anObject [
	inputs := anObject
]

{ #category : #testing }
PLC_ConnectableBlock >> isConnectableBlock [
	"Devuelve true si es una instancia de la clase PLC_ConnectableBlock"

	^ true.
]

{ #category : #testing }
PLC_ConnectableBlock >> isConnection [
	"Devuelve siempre false. ESTE METODO ES UNA MUGRE PARA QUE FUNCIONE FACIL close branch"

	^ false.
]

{ #category : #testing }
PLC_ConnectableBlock >> isInputBlock [
	"Responde true si no tiene ninguna entrada"

	^ self inputs size == 0.
]

{ #category : #testing }
PLC_ConnectableBlock >> isOutputBlock [
	"Responde true si no tiene ninguna salida"

	^ self outputs size == 0.
]

{ #category : #simulacion }
PLC_ConnectableBlock >> leerEntradasEnTiempo: t [
	"Lee y almacena en la OrederedCollection entradas todas las salidas de otros bloques que tiene conectadas a sus entradas.
	(vector at: 1) devuelve un bloque.
	(vector at: 2) devuelve un numero que representa un numero de salida de dicho bloque"

	self conexionesDeEntrada do: [ :vector | self guardarValorDeEntrada: ((vector at: 1) salida: (vector at: 2) enTiempo: t) ].
]

{ #category : #connections }
PLC_ConnectableBlock >> output: anOutputNumber connectTo: aConnectableBlock input: anInputNumber [
	"Conecta la salida numero anOutputNumber del bloque al que le mando este mensaje con la entrada numero anInputNumber de aConnectableBlock."
	
	| outputPin inputPin |
	
	outputPin := self outputs at: anOutputNumber.
	inputPin := aConnectableBlock inputs at: anInputNumber.
			
	^ outputPin connectTo: inputPin.
]

{ #category : #connections }
PLC_ConnectableBlock >> outputPinAfter: unPin [
	"Devuelve el pin de salida posterior a unPin."
	
	^self outputs after: unPin ifAbsent: [ nil ] 
]

{ #category : #connections }
PLC_ConnectableBlock >> outputPinNumberConnectedToInput: anInputNumber [
	"Devuelve el Numero de pin de salida que esta conectado al pin de entrada anInputNumber."
	
	| connection connectableBlock |
	
	self inputs size >= anInputNumber
		ifTrue: [
			connection := (self inputs at: anInputNumber) connection.
			connection
				ifNil: [
					^ nil.
					] 
				ifNotNil: [
					connectableBlock := connection outputPin block.
					^ connectableBlock outputs indexOf: connection outputPin.
					].
			]
		ifFalse: [
			^ nil.
			].
]

{ #category : #accessing }
PLC_ConnectableBlock >> outputs [
	^ outputs
]

{ #category : #accessing }
PLC_ConnectableBlock >> outputs: anObject [
	outputs := anObject
]

{ #category : #building }
PLC_ConnectableBlock >> removeInputAt: aNumberOfInput [

	self inputs removeAt: aNumberOfInput.
]

{ #category : #building }
PLC_ConnectableBlock >> removeInputPinAt: aNumberOfInput [

	self inputs removeAt: aNumberOfInput.
]

{ #category : #building }
PLC_ConnectableBlock >> removeOutputAt: aNumberOfInput [

	self outputs removeAt: aNumberOfInput.
]

{ #category : #building }
PLC_ConnectableBlock >> removeOutputPinAt: aNumberOfInput [

	self outputs removeAt: aNumberOfInput.
]

{ #category : #simulacion }
PLC_ConnectableBlock >> resetearEntradas [ 
	"Apunta la variable entradas a una nueva OrderedCollection para perder los valores de entradas y 
	tener nuevamente su indice en cero para el proximo calculo de entradas."
	
	self entradas: self entradas removeAll. 
]

{ #category : #simulacion }
PLC_ConnectableBlock >> salida: unNumeroDeSalida [

	^self salidas at: unNumeroDeSalida.


]

{ #category : #simulacion }
PLC_ConnectableBlock >> salida: unNumeroDeSalida enTiempo: t [
	"Calcuala y devuelve la salida del bloque al que el mandan este mensaje para eltiempo t."

	self leerEntradasEnTiempo: t. 			"Lee sus entradas en el tiempo t. Este lee las entradas haciendo que 
											se ramifique hasta los bloques de entrada el flujo dle programa."
											
	self funcionEnTiempo: t. 				"Ejecuta las tareas del bloque. Este metodo se debe definir en las 
											subclases y debe escribir las salidas."
											
	self resetearEntradas.					"Reseteo las entradas."
						
	^ self salidas at: unNumeroDeSalida.	"Devuelve su salida en el tiempo t. Esta linea hace la magia de que 
											vuelva todo hacia la salida"
	
		



]

{ #category : #accessing }
PLC_ConnectableBlock >> salidas [
	^ outputs
]

{ #category : #accessing }
PLC_ConnectableBlock >> salidas: anObject [
	outputs := anObject
]
