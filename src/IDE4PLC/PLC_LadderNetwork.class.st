"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_LadderNetwork is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_LadderNetwork',
	#superclass : #'PLC_ConnectableBlocksNetwork',
	#category : #'IDE4PLC-Networks'
}

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addCoil: aPLC_ElementCoil onConnection: aPLC_Connection [
	"Crea y añade una Bobina."

	| connectableBlockActualArgumentWriter connectableBlockCoil |

	"Creo los Bloques Conectables"	
	connectableBlockCoil := PLC_ConnectableBlock newWithElement: aPLC_ElementCoil.
	connectableBlockActualArgumentWriter := PLC_ConnectableBlock newWithElement: PLC_Element ActualArgumentWriter.

	"Conecto los 2 bloques conectables que forman el Elemento. 
	Esta conexion no está representada por ningun Morph."
	connectableBlockCoil output: 2 connectTo: connectableBlockActualArgumentWriter input: 1.
	
	"Agrego los Bloques Conectables a la Network de Bloques Conectables"
	self addBlock: connectableBlockCoil.
	self addBlock: connectableBlockActualArgumentWriter.	
	
	"Conecto el nuevo elemento a los Bloques Conectables entre los cuales estaba la conexion donde agrego el nuevo elemento."
	aPLC_Connection replaceConnectionByConnectingToInputPin: connectableBlockCoil inputs first andOutputPin:  connectableBlockCoil outputs first.
	
	
	^ connectableBlockCoil.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addContact: aPLC_ElementContact onConnection: aPLC_Connection [
	"Crea y añade un Contacto."

	| connectableBlockActualArgumentReader connectableBlockContact |

	"Creo los Bloques Conectables"	
	connectableBlockContact := PLC_ConnectableBlock newWithElement: aPLC_ElementContact.
	connectableBlockActualArgumentReader := PLC_ConnectableBlock newWithElement: PLC_Element ActualArgumentReader.

	"Conecto los 2 bloques conectables que forman el Elemento. 
	Esta conexion no está representada por ningun Morph."
	connectableBlockActualArgumentReader output: 1 connectTo: connectableBlockContact input: 2.
	
	"Agrego los Bloques Conectables a la Network de Bloques Conectables"
	self addBlock: connectableBlockContact.
	self addBlock: connectableBlockActualArgumentReader.	
	
	"Conecto el nuevo elemento a los Bloques Conectables entre los cuales estaba la conexion donde agrego el nuevo elemento."
	aPLC_Connection replaceConnectionByConnectingToInputPin: connectableBlockContact inputs first andOutputPin:  connectableBlockContact outputs first.
	
	^ connectableBlockContact.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addFunctionBlockCall: aPLC_Element onConnection: aPLC_Connection [
	"Crea y añade un Llamado a Instancia de Bloque de Función."

	| connectableBlockActualArgumentReader connectableBlockActualArgumentWriter connectableBlockFunction |

	"Creo el Bloque Conectables del Bloque de Función"	
	connectableBlockFunction := PLC_ConnectableBlock newWithElement: aPLC_Element.

	"Agrego el Bloque Conectable del LLamado a Función a la Network de Bloques Conectables"
	self addBlock: connectableBlockFunction.
	
	"Creo y conecto los bloques conectables de los Acrual Argument Reader
	de sus salidas y entrada-salidas y agrego los Actual Argument Reader a
	la Network de Bloques Conectables."
	(2 to: aPLC_Element inputs size ) do: [ :index |
		connectableBlockActualArgumentReader := PLC_ConnectableBlock 
			newWithElement: PLC_Element ActualArgumentReader.
		connectableBlockActualArgumentReader 
			output: 1 
			connectTo: connectableBlockFunction 
			input: index.	
		self addBlock: connectableBlockActualArgumentReader.
		].
	
	"Creo y conecto los bloques conectables de los Acrual Argument Writer 
	de sus salidas y entrada-salidas y agrego los Actual Argument Writer a
	la Network de Bloques Conectables."
	(2 to: aPLC_Element outputs size ) do: [ :index |
		connectableBlockActualArgumentWriter := PLC_ConnectableBlock 
			newWithElement: PLC_Element ActualArgumentWriter.
		connectableBlockFunction 
			output: index 
			connectTo: connectableBlockActualArgumentWriter 
			input: 1.	
		self addBlock: connectableBlockActualArgumentWriter.	
		].
	
	"Conecto el nuevo elemento a los Bloques Conectables entre los 
	cuales estaba la conexion donde agrego el nuevo elemento."
	aPLC_Connection 
		replaceConnectionByConnectingToInputPin: connectableBlockFunction inputs first 
		andOutputPin: connectableBlockFunction outputs first.
	
	^ connectableBlockFunction.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addFunctionCall: aPLC_Element onConnection: aPLC_Connection [
	"Crea y añade un Llamado a Función."

	| connectableBlockActualArgumentReader connectableBlockActualArgumentWriter connectableBlockFunction |

	"Creo el Bloques Conectables de la Función"	
	connectableBlockFunction := PLC_ConnectableBlock newWithElement: aPLC_Element.

	"Agrego el Bloque Conectable del LLamado a Función a la Network de Bloques Conectables"
	self addBlock: connectableBlockFunction.
	
	"Creo y conecto los bloques conectables de los Acrual Argument Reader
	de sus salidas y entrada-salidas y agrego los Actual Argument Reader a
	la Network de Bloques Conectables."
	(2 to: aPLC_Element inputs size ) do: [ :index |
		connectableBlockActualArgumentReader := PLC_ConnectableBlock 
			newWithElement: PLC_Element ActualArgumentReader.
		connectableBlockActualArgumentReader 
			output: 1 
			connectTo: connectableBlockFunction 
			input: index.	
		self addBlock: connectableBlockActualArgumentReader.
		].
	
	"Creo y conecto los bloques conectables de los Acrual Argument Writer 
	de sus salidas y entrada-salidas y agrego los Actual Argument Writer a
	la Network de Bloques Conectables."
	(2 to: aPLC_Element outputs size ) do: [ :index |
		connectableBlockActualArgumentWriter := PLC_ConnectableBlock 
			newWithElement: PLC_Element ActualArgumentWriter.
		connectableBlockFunction 
			output: index 
			connectTo: connectableBlockActualArgumentWriter 
			input: 1.	
		self addBlock: connectableBlockActualArgumentWriter.	
		].
	
	"Conecto el nuevo elemento a los Bloques Conectables entre los 
	cuales estaba la conexion donde agrego el nuevo elemento."
	aPLC_Connection 
		replaceConnectionByConnectingToInputPin: connectableBlockFunction inputs first 
		andOutputPin: connectableBlockFunction outputs first.
	
	^ connectableBlockFunction.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addLeftPowerRail [
	"Crea y añade el Riel de Potencia Izquiedo. Solo debe existir uno por Network."

	| connectableBlockLeftPowerRail |

	"Creo el Bloque Conectable"	
	connectableBlockLeftPowerRail := PLC_ConnectableBlock newWithElement: PLC_Element LeftPowerRail.

	"Agrego el Bloque Conectable a la Network de Bloques Conectables"
	self addBlock: connectableBlockLeftPowerRail.

	 "Le agrego el primer pin de salida"
	connectableBlockLeftPowerRail addOutput.
	
	^ connectableBlockLeftPowerRail.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> addRightPowerRailConnectedTo: aPLC_ConnectableBlock output: anOutputNumber [
	"Crea y añade un Riel Derecho y lo conecta a la salida numero anOutputNumber 
	del Bloque Conectable aPLC_ConnectableBlock."

	| connectableBlockRightPowerRail |

	"Creo el Bloque Conectable"	
	connectableBlockRightPowerRail := PLC_ConnectableBlock newWithElement: PLC_Element RightPowerRail.

	"Agrego el Bloque Conectable a la Network de Bloques Conectables"
	self addBlock: connectableBlockRightPowerRail.
	
	"Conecto el Bloque Conectable en la Network de Bloques Conectables."	
	aPLC_ConnectableBlock output: anOutputNumber connectTo: connectableBlockRightPowerRail input: 1.
	
	^ connectableBlockRightPowerRail.
]

{ #category : #checks }
PLC_LadderNetwork >> checkIfFunctionAreInAParallelBranch: aPLC_ConnectableBlockF [
	"Chequeo si se encuentra en una rama paralela"

	| connectableBlockOutputPinNumber lprOrVl |
		
	lprOrVl := aPLC_ConnectableBlockF.
	
	"Busco a través de la Funcion hacia su entrada hasta encontrar un elemento que sea un Vertical Link o
	Left Power Rail  y también guardo por cual número de pin de salida llego."

	[ lprOrVl element isVerticalLink or: [  lprOrVl element isLeftPowerRail ] ]
		whileFalse: 
			[ connectableBlockOutputPinNumber := lprOrVl outputPinNumberConnectedToInput: 1.
			lprOrVl := lprOrVl blockConnectedToInput: 1. ].
	
	^ lprOrVl element isVerticalLink and: [ connectableBlockOutputPinNumber > 1 ].
]

{ #category : #checks }
PLC_LadderNetwork >> checkShortCircuitIfConnect: connectableBlockOutputPin To: connectableBlockInputPin [
	"Chequeo que no se forme un cortocircuito si conecto connectableBlockOutputPin 
	con connectableBlockInputPin. Si no hay problema los conecto. Si se forma un corto
	Borro los pines de los VL o LPR que lo forman y no conecto los pines. Cuando Borro 
	pines debo ver que queden VL o LPR validos.
	
	AGREGAR CHEQUEO DE QUE NO HAYA SOLO BOBINAS O BLOQUES EN LAS RAMAS SERIES DE LA RAMA PARALELA 
	EN BOBINA Y BLOQUE
	
	Evita el caso al eliminar un contacto por ejejmplo:
	
	       	c1	  			   		c1 			NO PUEDE QUEDAR ASI 
	-----+-----|  |----+-----		-----+-----|  |-----+-----	DEBE REEMPLAZAR LOS 2 
		|	c2	   |		==>	|		   |		VL POR HORIZONTAL LINKS
	     +-----|  |----+		           +-------------+		
											
	"
	| connectableBlockInput connectableBlockOutput  
	 VLorLPRinput VLOutput 
	 adequateInputPin locationForNewOutputPin outputToDisappear newOutputPin inputPinToConnect 
  	 adequateOutputPin locationForNewInputPin inputToDisappear newInputPin outputPinToConnect | 
	
	connectableBlockInput := connectableBlockOutputPin block.
	connectableBlockOutput := connectableBlockInputPin block.
	
	VLorLPRinput := connectableBlockInput.
	VLOutput := connectableBlockOutput.
	
	
	adequateInputPin := connectableBlockInputPin.
	
	"Si da true entonces se formaria un cortocircuito y hay que evitarlo"
	
	connectableBlockOutput element isVerticalLink
		ifTrue: [
			connectableBlockInput element isLeftPowerRail
				ifTrue: [					
					
					"Chequeo si el VL no tiene pines de entrada. Si esto es asi el LPR debe 'absorver' al VLOutput
					
					Ejemplo:							
			
					| p1	     p2  p3			|			
					|-----|  |-----+----			|-----   p3		
					|		   |		==>	|		
					|		  +----			|-----   p4 	
					|		   p4 			|	
											
					LPR 	VL 			     LPR
								
					"	
					( VLOutput inputs size = 1 )
						ifTrue: [
							"Agrego los pines de salida del VLOutput al Left Power Rail."
							"VLorLPRinput outputs addAll: VLOutput outputs."
	
							"el input que hay que enchufarle al output es otro, 
							  porque el VLOutput va a desaparecer"
							adequateInputPin := VLOutput outputs first connection inputPin.
							adequateInputPin disconnect.
							"reconecto cada uno de los conectados con el VLOutput a nuevos pines en el LPRinput"
							locationForNewOutputPin := connectableBlockOutputPin.
							(2 to: VLOutput outputs size) do: [ :n |
								outputToDisappear := VLOutput outputs at: n.
								VLorLPRinput addOutputPinAfter: locationForNewOutputPin.
								newOutputPin := VLorLPRinput outputPinAfter: locationForNewOutputPin.
								VLorLPRinput element addOutput.   "no se para que es esto!!"
								inputPinToConnect := outputToDisappear connection inputPin.
								inputPinToConnect disconnect.
								newOutputPin connectTo: inputPinToConnect.
								locationForNewOutputPin := newOutputPin.
							 ].
							"version de Eric"
							"outputPin := connectableBlockOutputPin.
							VLOutput outputs do: [ :each | 
								each block: VLorLPRinput.
								VLorLPRinput addOutputPin: each after: outputPin.
								outputPin := each.															
								]."
							"Remuevo el VLOutput de la network de bloques conectables."
							self removeBlock: VLOutput.			
							"esto lo repito porque hay un return abajo que no entiendo, pero que dejo por las dudas. Ufa."
							connectableBlockOutputPin connectTo: adequateInputPin.
						] 
						ifFalse: [ 
							"Remuevo la salida del elemento del VL o LPR - NO ANDABA ANTES PORQUE NO HACIA ESTO"
							VLOutput element inputs removeAt: ( VLOutput inputs indexOf: connectableBlockInputPin ).
							"Remuevo el pin obtenido del Bloque Conectable LPR o VL"
							VLOutput inputs remove: connectableBlockInputPin.

							"Remuevo la salida del elemento del VL o LPR - NO ANDABA ANTES PORQUE NO HACIA ESTO"
							VLorLPRinput element outputs removeAt: ( VLorLPRinput outputs indexOf: connectableBlockOutputPin ).
							"Remuevo el pin obtenido del Bloque Conectable LPR o VL"
							VLorLPRinput outputs remove: connectableBlockOutputPin.						
						].
						
					].
				
			VLorLPRinput element isVerticalLink
				ifTrue: [
					
					"Chequeo si el VLorLPRinput tiene un solo pin de salida. Si esto es asi debe 'absorver' al VLOutput
						
					Ejemplo 1:												Ejemplo 2:
			
						    p5    p6	 											    p5     p6
					p1 ---+----|  |----+--- p3 			p1 ---+--- p3			p1 ---+----|  |----+--- p4 			p1 ---+--- p4
						   |		    |			==>		   |						   |		    | 			==>		   |
					p2 ---+		   +--- p4			p2 ---+--- p4			p2 ---+		    |					p2 ---+
																						    |						   |
						VL1 	VL2 					VL1							  p3---+ 				p3 ---+

																				VL1 	VL2 					VL1
					p = Pin "
					
						
					( VLOutput inputs size = 1 )
						ifTrue: [
							" esto es lo mismo - lo mismo que esta en el caso 
							  VLOutput isVerticalLink -- VLorLPRinput isLeftPowerRail - VLorLPRinput output size = 1.
							  Refactorizar si este proyecto sigue vivo."
							"el input que hay que enchufarle al output es otro, 
							  porque el VLOutput va a desaparecer"
							adequateInputPin := VLOutput outputs first connection inputPin.
							adequateInputPin disconnect.
							"reconecto cada uno de los conectados con el VLOutput a nuevos pines en el LPRinput"
							locationForNewOutputPin := connectableBlockOutputPin.
							(2 to: VLOutput outputs size) do: [ :n |
								outputToDisappear := VLOutput outputs at: n.
								VLorLPRinput addOutputPinAfter: locationForNewOutputPin.
								VLorLPRinput element addOutput.   "no se para que es esto!!"
								newOutputPin := VLorLPRinput outputPinAfter: locationForNewOutputPin.
								inputPinToConnect := outputToDisappear connection inputPin.
								inputPinToConnect disconnect.
								newOutputPin connectTo: inputPinToConnect.
								locationForNewOutputPin := newOutputPin.
							 ].
							"aca se termina la parte copiada de otro caso "
							"version de Eric"
							"Agrego los pines de entrada y salida del VLOutput al VLorLPRinput"
							"VLorLPRinput inputs addAll: VLOutput inputs.
							VLorLPRinput outputs addAll: VLOutput outputs."
											
							"Remuevo el VLOutput de la network de bloques conectables."
							self removeBlock: VLOutput.					
							"esto lo repito porque hay un return abajo que no entiendo, pero que dejo por las dudas. Ufa."
							connectableBlockOutputPin connectTo: adequateInputPin.
						]
						ifFalse: [ 				
							( VLorLPRinput outputs size = 1 )
							ifTrue: [  
								" esto es dual a los casos con codigo repetido, cambiando input por output.
								  Refactorizar si este proyecto sigue vivo."
								"el output que hay que enchufarle al input es otro, 
								  porque el VLorLPRinput va a desaparecer"
								adequateOutputPin := VLorLPRinput inputs first connection outputPin.
								adequateOutputPin disconnect.
								"reconecto cada uno de los conectados con el VLOutput a nuevos pines en el LPRinput"
								locationForNewInputPin := connectableBlockInputPin.
								(2 to: VLorLPRinput inputs size) do: [ :n |
									inputToDisappear := VLorLPRinput inputs at: n.
									VLOutput addInputPinAfter: locationForNewInputPin.
									VLOutput element addInput.   "no se para que es esto!!"
									newInputPin := VLOutput inputPinAfter: locationForNewInputPin.
									outputPinToConnect := inputToDisappear connection outputPin.
									outputPinToConnect disconnect.
									newInputPin connectTo: outputPinToConnect.
									locationForNewInputPin := newInputPin.
								 ].
								"aca se termina la parte copiada de otro caso "
											
								"Remuevo el VLOutput de la network de bloques conectables."
								self removeBlock: VLorLPRinput.
								"esto lo repito porque hay un return abajo que no entiendo, pero que dejo por las dudas. Ufa."
								adequateOutputPin connectTo: connectableBlockInputPin.
							]
							ifFalse: [ 
								"Remuevo la salida del elemento del VL o LPR - NO ANDABA ANTES PORQUE NO HACIA ESTO"
								VLOutput element inputs removeAt: ( VLOutput inputs indexOf: connectableBlockInputPin ).
								"Remuevo el pin obtenido del Bloque Conectable LPR o VL"
								VLOutput inputs remove: connectableBlockInputPin.
								"Remuevo la salida del elemento del VL o LPR - NO ANDABA ANTES PORQUE NO HACIA ESTO"
								VLorLPRinput element outputs removeAt: ( VLorLPRinput outputs indexOf: connectableBlockOutputPin ).
								"Remuevo el pin obtenido del Bloque Conectable LPR o VL"
								VLorLPRinput outputs remove: connectableBlockOutputPin.
							 ]
						].
						
					"Chequeo si el aConnectableBlockVL tiene una sola entrada y una sola salida.
					Si esto es asi entonces lo reemplazo por un Horizontal Link."
			
					self checkValidVerticalLink: VLorLPRinput.
	
					]
				ifFalse:[
					"Si entro aca entonces connectableBlockInput no es ni VL ni LPR, entonces 
					simplemente conecta, no tiene que absorber nada"
					
					"Conecto los pines que obtuve al principio para cerrar el circuito y retorno la nueva conexion"
					^ connectableBlockOutputPin connectTo: adequateInputPin.
					
					].
				
			"Chequeo si el aConnectableBlockVL tiene una sola entrada y una sola salida.
			Si esto es asi entonces lo reemplazo por un Horizontal Link."
			
			^ self checkValidVerticalLink: VLOutput.
			
			].
		
	
	"Conecto los pines que obtuve al principio para cerrar el circuito y retorno la nueva conexion"
	^ connectableBlockOutputPin connectTo: adequateInputPin.
]

{ #category : #accessing }
PLC_LadderNetwork >> checkValidRightPowerRailConnections [
	"Cheuquea que los RPR no esten conectados a contactos o VL si esto es así devuelve true."

	"LO PARCHIE"
	
	^ true.


	"^ self rightRailsBlocks allSatisfy: [:each | 
		((each blockConnectedToInput: 1) isContact or: [ (each blockConnectedToInput: 1) isVerticalLink ]) not.
		]
	"
]

{ #category : #checks }
PLC_LadderNetwork >> checkValidVerticalLink: aConnectableBlockVL [
	"Chequeo si el aConnectableBlockVL tiene una sola entrada y una sola salida.
	Si esto es asi entonces lo reemplazo por un Horizontal Link.
					
	Ejemplo, Borro c1:
					
	|	 c1					|							 c2
	|------|   |----+-->>		|-		  -+-->>			|------|   |------->>	
	|	 c2     |		==>	|	 c2	    |		==>
	|------|   |----+				|------|   |----+
	|						|
					
	"
					
	| connectableBlockOutputPin connectableBlockInputPin |
					
	( aConnectableBlockVL inputs size = 1 and: [ aConnectableBlockVL outputs size = 1 ] )
		ifTrue: [
			"Busco los pines conectados a entrada y salida del VL"
			connectableBlockOutputPin := ( aConnectableBlockVL connectedAtInput: 1) outputPin.
			connectableBlockInputPin := ( aConnectableBlockVL connectedAtOutput: 1) inputPin. 
			
			"Desconecto los pines obtenidos"
			connectableBlockOutputPin disconnect.
			connectableBlockInputPin disconnect.
			
			"Remuevo el bloque conectable VL de la Network de bloques conectables"
			self removeBlock: aConnectableBlockVL.
					
			"Conecto los pines que obtuve y retorno dicha conexion."
			^ connectableBlockOutputPin connectTo: connectableBlockInputPin.		
			]
		ifFalse: [
			^ aConnectableBlockVL.
			]
]

{ #category : #'commands copen-close Branch' }
PLC_LadderNetwork >> closeBranchFrom: aPLC_ConnectableBlockOrConnection to: aPLC_Connection [
	"Cierra una rama si se puede."
	
	( aPLC_ConnectableBlockOrConnection isConnectableBlock )
		ifTrue: [
			( aPLC_ConnectableBlockOrConnection element isRightPowerRail and: [ aPLC_Connection isConnection ] )
				ifTrue: [
					^ self closeBranchFromRPR: aPLC_ConnectableBlockOrConnection toHL: aPLC_Connection.
				].
		].
			
	( aPLC_ConnectableBlockOrConnection isConnection and: [ aPLC_Connection isConnection ] )
		ifTrue: [
			^ self closeBranchFromHL: aPLC_ConnectableBlockOrConnection toHL: aPLC_Connection.
			]	
		ifFalse: [
			^ 'No se puede Cerrar Rama.'.
			]
]

{ #category : #'commands copen-close Branch' }
PLC_LadderNetwork >> closeBranchFromHL: aPLC_Connection1 toHL: aPLC_Connection2 [
	"Cierra una Rama desde una Conexion hasta otra conexion, es decir, un Horizontal Link.
	
	---+----|  |-----==-----|  |--------           	 		---+----|  |------+-----|  |----------   
	    |		       				 	    ==>		    |		     	  |	
	   +----|  |-----==-----|  |---->>				  	   +----|  |------+-----|  |---->>	

	"

	| connectableBlock1 connectableBlockOutputPinNumber1 connectableBlock2 connectableBlockOutputPinNumber2 connectableBlockVL  |
	
	" 1 -  Chequeo que los bloques conectables conectados a ambas conexiones no sean LPR o VL.
	Si son VL o LPR, entonces no puedo Cerrar la Rama."
	
	"Busco los Bloques Conectables conectados a la entrada y salida de aPLC_Connection1"
	connectableBlock1 := aPLC_Connection1 connectedAtInput: 1.
	connectableBlock2 := aPLC_Connection1 connectedAtOutput: 1.
	
	"Analizo si son VL o LPR"
	( connectableBlock1 element isLeftPowerRail 
		or: [ connectableBlock1 element isVerticalLink 
			or: [ connectableBlock2 element isLeftPowerRail 
				or: [ connectableBlock2 element isVerticalLink ] 
				]
			 ] )
		ifTrue:  [
			^ 'No se puede Cerrar Rama.'
			].
		
	"Busco los Bloques Conectables conectados a la entrada y salida de aPLC_Connection2"
	connectableBlock1 := aPLC_Connection2 connectedAtInput: 1.
	connectableBlock2 := aPLC_Connection2 connectedAtOutput: 1.
	
	"Analizo si son VL o LPR"
	( connectableBlock1 element isLeftPowerRail 
		or: [ connectableBlock1 element isVerticalLink 
			or: [ connectableBlock2 element isLeftPowerRail 
				or: [ connectableBlock2 element isVerticalLink ] 
				]
			 ] )
		ifTrue:  [
			^ 'No se puede Cerrar Rama.'
			].
		
	" 2 -   Busco a través de la Conexion ( == ) aPLC_Connection1  hacia su entrada hasta 
	encontrar un elemento que sea un Vertical Link o Left Power Rail y también guardo por 
	cual número de pin de salida llego."

	connectableBlock1 := aPLC_Connection1 connectedAtInput: 1.

	[ ( connectableBlock1 element isLeftPowerRail or: [ connectableBlock1 element isVerticalLink ] ) ]
		whileFalse: 
			[ connectableBlockOutputPinNumber1 := connectableBlock1 outputPinNumberConnectedToInput: 1.
			connectableBlock1 := connectableBlock1 blockConnectedToInput: 1. ] .
		
	" 3 -   Busco a través de la Conexion ( == ) aPLC_Connection2 hacia su entrada hasta 
	encontrar un elemento que sea un Vertical Link o Left Power Rail y también guardo por 
	cual número de pin de salida llego."

	connectableBlock2 := aPLC_Connection2 connectedAtInput: 1.

	[ ( connectableBlock2 element isLeftPowerRail or: [ connectableBlock2 element isVerticalLink ] ) ]
		whileFalse: 
			[ connectableBlockOutputPinNumber2 := connectableBlock2 outputPinNumberConnectedToInput: 1.
			connectableBlock2 := connectableBlock2 blockConnectedToInput: 1. ] .

	" 4 -  Chequeo si los 2 bloques conectables a los cuales llego recorriendo hacia al entrada de
	de la Conexion aPLC_Connection1 y de la Conexion aPLC_Connection2 son el mismo Vertical 
	Link o Left Power Rail y también que el Numero de Pin al que llego por aPLC_Connection1 
	sea mayor en 1 al Numero de Pin al que llego por aPLC_Connection2. Si esto se cumple 
	entonces puedo Cerrar la rama creando asi una conexion en Paralelo.
	
				    3 
	-----+----|  |------==----|  |------->>		 		 -----+----|  |-------+-------|  |------->>	
	      |		    2 								 |		      |
	     +----|  |------==----|  |------->>		==>		+----|  |-------+-------|  |------->>
	      |		    1 								 |
	     +----|  |------==----|  |------->>					+----|  |----------------|  |------->>
			
	Puedo Cerrar Rama en los casos:
		aPLC_Connection1 = 1 y aPLC_Connection2 = 2
		aPLC_Connection1 = 2 y aPLC_Connection2 = 3
	"
	
	( connectableBlock1= connectableBlock2 and: [ (connectableBlockOutputPinNumber1 - connectableBlockOutputPinNumber2) = 1 ] )
		ifTrue: [
			
			"Si llego a este punto entonces puedo Cerrar la rama creando así una conexion en paralelo.
			
			5 -  Reemplazo ambas conexiones por un nuevo Vertical Link."
			
			"Creo lel Vertical Link y le agrego 2 entradas y 2 salidas."
			connectableBlockVL := PLC_ConnectableBlock newWithElement: PLC_Element VerticalLink.
			connectableBlockVL 
						addOutput;
						addOutput;
						addInput;
						addInput.
						
			"Agrego el Bloque Conectable a la Network de Bloques Conectables"
			self addBlock: connectableBlockVL.
					
			"Conecto el Vertical Link donde estaban las conexiones."
			aPLC_Connection2 replaceConnectionByConnectingToInputPin: connectableBlockVL inputs first andOutputPin:  connectableBlockVL outputs first.
			aPLC_Connection1 replaceConnectionByConnectingToInputPin: connectableBlockVL inputs last andOutputPin:  connectableBlockVL outputs last.
			
			]
		
		ifFalse: [
			^ 'No se puede Cerrar Rama.'
			].

]

{ #category : #'commands copen-close Branch' }
PLC_LadderNetwork >> closeBranchFromRPR: aPLC_ConnectableBlockRightPowerRail toHL: aPLC_Connection [
	"Cierra una Rama desde un Riel de Potencia Derecho hacia una conexion, es decir, un Horizontal Link.
	
	|----|  |---------(  )----|            	|----|  |----+----(  )----|        
	|					==>	|	       |
	|----|  |---->>					|----|  |----+
	
	
	VER SI HACE FLATA DETECTAR QUE EL RPR NO ESTE CONECTADO A BOBINA

	
	"

	| connectableBlock1 connectableBlockOutputPinNumber1 connectableBlock2 connectableBlockOutputPinNumber2 connectableBlockLPRorVL connectableBlockOutputPin |
	
	" 1 -  Chequeo si el primer bloque conectado a la entrada del Right Power Rail ( -->> ) es un Vertical Link
	o Left Power Rail, si esto es así entonces no puedo Cerrar la Rama pues genero un cortocircuito.
	
	---+----|  |----==  			     -----+----|  |----+-----      NO SE PUEDE, CORTOCIRCUITO.
	    |				   ==>		     |		      |
	   +->>						    +-----------+ 
	
	debe haber un elemento entre el VL y el RPR.
	( == ) es el Horizontal Link hacia el cual quiero Cerrar la Rama."
	

	"Busco el Bloque Conectable conectado a la entrada 1 del Right Power Rail."
	connectableBlock2 := aPLC_ConnectableBlockRightPowerRail blockConnectedToInput: 1.
	
	"Analizo si es un VL o LPR"
	( connectableBlock2 element isLeftPowerRail or: [ connectableBlock2 element isVerticalLink ] )
		ifTrue: [
			^ '1 - No se puede hacer cortocircuitos.'
			].
		
	" 2 -  Busco a través del Right Power Rail ( -->> ) hacia su entrada hasta encontrar un
	 elemento que sea un Vertical Link o Left Power Rail y también guardo por cual número 
	de pin de salida llego."

	[ ( connectableBlock2 element isLeftPowerRail or: [ connectableBlock2 element isVerticalLink ] ) ]
		whileFalse: 
			[ connectableBlockOutputPinNumber2 := connectableBlock2 outputPinNumberConnectedToInput: 1.
			connectableBlock2 := connectableBlock2 blockConnectedToInput: 1. ] .
			
	" 3 -   Chequeo si el primer bloque conectado a la entrada del Horizontal Link ( == ) es el mismo bloque
	que obtuve en 2. Si esto es así entonces no puedo Cerrar la Rama pues genero un cortocircuito.
	
	     a	 	     b 					   a		 		     b
	----|  |----+==----|  |-------  			     ----|  |----+-----------+----|  |-------     NO SE PUEDE, CORTOCIRCUITO.
		      |	c			   ==>		    	     |	     c	 |
		     +----|  |----->>					    +----|  |----+ 
	
	debe haber un elemento entre los VL.
	( == ) es el Horizontal Link hacia el cual quiero Cerrar la Rama desde el Right Power Rail."
	
	"Busco el Bloque Conectable conectado a la entrada 1 de la Conexion."
	connectableBlock1 := aPLC_Connection blockConnectedToInput: 1.
	
	"Analizo si los bloques conectables obtenidos son iguales"
	( connectableBlock1 = connectableBlock2 )
		ifTrue: [
			^ '3 - No se puede hacer cortocircuitos.'
			].
		
	" 4 -   Busco a través de la Conexion ( == ) hacia su entrada hasta encontrar un
	 elemento que sea un Vertical Link o Left Power Rail y también guardo por cual número 
	de pin de salida llego."

	[ ( connectableBlock1 element isLeftPowerRail or: [ connectableBlock1 element isVerticalLink ] ) ]
		whileFalse: 
			[ connectableBlockOutputPinNumber1 := connectableBlock1 outputPinNumberConnectedToInput: 1.
			connectableBlock1 := connectableBlock1 blockConnectedToInput: 1. ] .

	" 5 -  Chequeo si los 2 bloques conectables a los cuales llego recorriendo hacia al entrada de
	de la Conexion ( == ) y del Right Power Rail ( -->> ) son el mismo Vertical Link o Left Power Rail 
	y también que el Numero de Pin al que llego por el RPR sea mayor al Numero de Pin al que llego 
	por la Conexion. Si esto se cumple entonces puedo Cerrar la rama creando asi una conexion 
	en Paralelo.
										           1
	Output Pin N° 1  -----+----|  |-----------------------==-------------|  |-----            	 	 
						 |				   2
	Output Pin N° 2 	+----|  |----------|  |----==-->>	3
						 |	
	Output Pin N°3 		+----|  |---------------->> 4
			
	Puedo Cerrar Rama en los casos:
		3 con 1
		4 con 1
		4 con 2
	"
	( connectableBlock1= connectableBlock2 and: [ connectableBlockOutputPinNumber2 > connectableBlockOutputPinNumber1 ] )
		ifTrue: [
			
			"Si llego a este punto entonces puedo Cerrar la rama creando así una conexion en paralelo.
			
			6 -  Elimino el Right Power Rail."
			
			"Busco el Pin de salida conectado al  Conectable"
			connectableBlockOutputPin := (aPLC_ConnectableBlockRightPowerRail connectedAtInput: 1) outputPin.
					
			"Desconecto el Right Power Rail"
			(aPLC_ConnectableBlockRightPowerRail connectedAtInput: 1) disconnect.
			
			"Elimino el Right Power Rail de la Network de Bloques Conectables "
			self blocks remove: aPLC_ConnectableBlockRightPowerRail.			
			
			"7 -  Chequeo si primer elemento conectado a entrada de la conexion ( == ) es un Vertical 
			Link. Si esto se cumple entonces en lugar de crear un nuevo Vertical Link le agrego un 
			Pin  de entrada a dicho Vertical Link. CREO QUE ESTE CHEQUEO ME LO FILTRA MAS ARRIBA.
			
		 	 -----+----|  |-----+--==----      	 	 -----+----|  |-----+-----    ASI SI 	 
				 |		   |						 |		   |	
	 			+----|  |-----+			==>		+----|  |-----+	
				 |								 |		   |	
				+----|  |-------->> 					+----|  |-----+	


		 	 -----+----|  |-----+--==----      	 	 -----+----|  |-----+------+-----     ASI NO	 	 
				 |		   |						 |		    |	      |
	 			+----|  |-----+			==>		+----|  |-----+	      |
				 |								 |		   	      |
				+----|  |-------->> 					+----|  |-------------+

			"
			
			"Busco el Bloque Conectable a la Entrada del la Conexion."
			connectableBlockLPRorVL := aPLC_Connection connectedAtInput: 1.
			
			"Analizo si es un VL. Si es verdadero le agrego una Entrada."
			( connectableBlockLPRorVL element isVerticalLink )
				ifTrue: [
					 connectableBlockLPRorVL addInput.
					].
				
			"8 -  Chequeo si primer elemento conectado a Salida de la conexion ( == ) es un Vertical 
			Link. Si esto se cumple entonces en lugar de crear un nuevo Vertical Link le agrego un 
			Pin  de entrada a dicho Vertical Link.
			
		 	 -----+----|  |------==------+----|  |-----+-----   		 	 -----+----|  |-----+----|  |-----+-----     ASI SI			
				 |		 		   |		      |					 |		   |		      |	
	 			+----|  |----->> 	  +----|  |-----+		  ==>		+----|  |-----+----|  |-----+
								   |		      |							   |		      |	
								  +----|  |-----+							  +----|  |-----+	


		 	 -----+----|  |------==------+----|  |-----+-----   		 	 -----+-----|  |------+-----+-----|  |-----+-----     ASI NO			
				 |		 		   |		      |					 |		     |       |	 	     |	
	 			+----|  |----->> 	  +----|  |-----+		  ==>		+-----|  |------+     +-----|  |-----+
								   |		      |								       |		     |	
								  +----|  |-----+								      +-----|  |-----+	

			"
			
			"Busco el Bloque Conectable a la Salida del la Conexion."
			connectableBlockLPRorVL := aPLC_Connection connectedAtOutput: 1.
			
			"Analizo si es un VL. Si es verdadero le agrego una Entrada."
			( connectableBlockLPRorVL element isVerticalLink )
				ifTrue: [
					 connectableBlockLPRorVL addInput.
					]
				ifFalse: [
					
					"9 -  Creo un nuevo Vertical Link y conecto sus primeras entradas y 
					salidas donde se encontraba la Conexion."					
					
					"Creo lel Vertical Link y le agrego 2 entradas y 1 salida."
					connectableBlockLPRorVL := PLC_ConnectableBlock newWithElement: PLC_Element VerticalLink.
					connectableBlockLPRorVL addOutput;
						addInput;
						addInput.
						
					"Agrego el Bloque Conectable a la Network de Bloques Conectables"
					self addBlock: connectableBlockLPRorVL.
					
					"Conecto el nuevo elemento a los Bloques Conectables entre los cuales 
					estaba la conexion donde agrego el nuevo elemento."
					aPLC_Connection replaceConnectionByConnectingToInputPin: connectableBlockLPRorVL inputs first andOutputPin:  connectableBlockLPRorVL outputs first.
					
					].
				
			"10 -  Conecto el pin de salida del Bloque Conectable que estaba conectado el 
			Right Power Rail al ultimo pin de Entrada del connectableBlockLPRorVL."
			
			connectableBlockOutputPin connectTo: connectableBlockLPRorVL inputs last.
			
			^ connectableBlockLPRorVL.
			
			]
		ifFalse: [
			^ 'No se puede Cerrar Rama.'
			].
]

{ #category : #compilation }
PLC_LadderNetwork >> generateCodeIn: aProgramAccumulator [
	"Compila su programa a objetos que lo forman. Estos pueden dar su código C o IL."

	| varDecl |

	self checkValidRightPowerRailConnections 
		ifTrue: [
			
			"Reseteo los objetos generados por los elementos"
			self resetCompiledObjectsInElements.	
			
			
			
			"Creo la declaración de variable FLUX que la usan los llamados graficos a F y FB"
			varDecl := PLC_SymbolicVariableDecl 
				newWithDataType: PLC_DataType Bool
				andInitialValue: nil 
				andIdentifier: 'FLUX'. 
			
			"La agrego a las variables declaradas por el compilador"		
			aProgramAccumulator addVarDecl: varDecl.
			
			"Le asigno la categoría temp asi no pone el pxPOU-> en C"
			varDecl variableCategory: PLC_VariableCategoryDecl tempVarDecls.
			

			
			"Comienzo la compilacion en el bloque conectable left power rail"
			self leftPowerRailBlock generateCodeIn: aProgramAccumulator.			
			
			"Guardo los objetos generados por los Vertical Links"
			self veriticalLinkBlocks do: [ :block |
				aProgramAccumulator addVarDecl: block element objectVarDec.
				aProgramAccumulator addDataTypeDecl: block element objectTypeDec.
				].		

			]
		ifFalse:[
			
			self error: 'No se puede compilar'.
			
			]
		
	
	

]

{ #category : #'initialize-release' }
PLC_LadderNetwork >> initialize [
	"Inicializacion de la Network de Bloques Conectables"
	
	super initialize.
	
	"Agrego el Left Power Rail y el Right Power Rail en la Network de Bloques Conectables quedando el modelo inicial:
	
	|
	|-------------------------------------------------------------|
	|
	
	"
	self addRightPowerRailConnectedTo: self addLeftPowerRail output: 1.
	
]

{ #category : #blocks }
PLC_LadderNetwork >> leftPowerRailBlock [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un riel derecho."

	^ (self blocks select: [ : each | each element isLeftPowerRail ]) first.
]

{ #category : #'commands copen-close Branch' }
PLC_LadderNetwork >> openBranchOnConnection: aPLC_Connection [
	"Abre una rama sobre una conexion (==).
	
	|----|  |----==---(  )----|             	|----|  |----+----(  )----|        
	|							|	       |
	|							|            +->>	
	
	
	CASOS:
	
	1 -  Si abro rama sobre el horizontal link cuya entrada esta conectada a un 
	VL o LPR entonces debe agregarle un pin de salida al VL o LPR y ahi 
	conectarle el RPR.
	
	|----|  |-----+==--(  )----|			|----|  |-----+----(  )----|
	|		  |						|		  |	
	|		 +------(  )----|   			|		 +->>
									|		  |
									|		 +----(  )----|  			 
		
	2 -  Si abro rama sobre el horizontal link cuya salida esta conectada a un 
	VL entonces debe agregarle un pin de salida al VL y ahi 
	conectarle el RPR.
							
	Si quiero abrir rama sobre el HL entre el contacto y el VL entonces tiene 
	que agregarle un pin de salida al VL y agregarle ahi el RPR.
	
	|----|  |----==-+----(  )----|			|----|  |-----+----(  )----|
	|	 	      |					|		  |	
	|		     +----(  )----|   			|		 +----(  )----|  
									|		  |
									|	 	 +->>	
												
	3 -  Si abro rama sobre en un horizontal link NO conectado a un VL o LPR 
	entonces debo agregarle en su lugar un nuevo Vertical Link y conectarle 
	en su segunda salida un Right Power Rail..
	
	|----|  |----==---(  )----|             	|----|  |----+----(  )----|        
	|							|	       |
	|							|            +->>	
	
	"
	
	| connectableBlockLPRorVLInput connectableBlockVLOutput
	connectableBlockLPRorVL outputPin connectableBlockRightPowerRail |

	"Busco el Bloque Conectable a la Entrada del la conexion, puede ser un LPR, VL u otro."
	connectableBlockLPRorVLInput := aPLC_Connection connectedAtInput: 1.
	
	"Busco el Bloque Conectable a la Salida del la conexion, nunca va a poder ser un LPR."
	connectableBlockVLOutput := aPLC_Connection connectedAtOutput: 1.	
	
	
	"Chequeo si la conexion ya estaba conectada a un Left Power Rail o 
	Vertical Link a su entrada o salida. Si esto es verdadero, le agrego al 
	LPR o VL una salida y le conecto un Right Power Rail. Nunca se va a dar 
	el caso simultaneo que la conexión esté conectada a izquierda y
	derecha a VLs o LPRs en simultaneo ya que sino deberían haber sido 
	absorbidos durante un borrado.
	
	Si es falso Debo crear Primero un Vertical Link y luego agregar 
	una salida conectada a un RPR."
	
	
	"Prueba si el bloque conectable de entrada de la conexion es LPR o VL"
	( connectableBlockLPRorVLInput element isLeftPowerRail 
	or: [ connectableBlockLPRorVLInput element isVerticalLink ] )
		ifTrue: [
			connectableBlockLPRorVL := connectableBlockLPRorVLInput.
			"Seteo el pin luego del cual debe agregarse el nuevo pin"
			outputPin := aPLC_Connection outputPin.	
			].
		
	"Prueba si el bloque conectable de salida de la conexion es VL"	
	( connectableBlockVLOutput element isVerticalLink )
		ifTrue: [
			connectableBlockLPRorVL := connectableBlockVLOutput.
			"Seteo el pin luego del cual debe agregarse el nuevo pin"
			outputPin := connectableBlockLPRorVL outputs last.	
			].
	

	"Si ni el bloque conectable a la entrada de la conexion, ni el de salida 
	son LPR oVL, entonces tiene que crear un VL"	
	connectableBlockLPRorVL
		ifNil: [
			"Creo lel Vertical Link y le agrego una entrada y una salida."
			connectableBlockLPRorVL := PLC_ConnectableBlock 
				newWithElement: PLC_Element VerticalLink.
			connectableBlockLPRorVL 
				addInput;
				addOutput.
				
			"Agrego el Bloque Conectable a la Network de Bloques Conectables"
			self addBlock: connectableBlockLPRorVL.
			
			"Conecto el nuevo elemento a los Bloques Conectables entre los 
			cuales estaba la conexion donde agrego el nuevo elemento."
			aPLC_Connection 
				replaceConnectionByConnectingToInputPin: connectableBlockLPRorVL inputs first 
				andOutputPin:  connectableBlockLPRorVL outputs first.
				
			"Seteo el pin luego del cual debe agregarse el nuevo pin"
			outputPin := connectableBlockLPRorVL outputs first.
			].
		
		
	"Le agrego una salida al Left Power Rail o Vertical Linkl"
	connectableBlockLPRorVL addOutputAfter: outputPin.
		
	"Le conecto un nuevo Right Power Rail"
	connectableBlockRightPowerRail := self 
		addRightPowerRailConnectedTo: connectableBlockLPRorVL 
		output: ( connectableBlockLPRorVL outputs indexOf: outputPin ) + 1.
	
	"Agrego el Right Power Rail a la Network de Bloques Conectables"
	self addBlock: connectableBlockRightPowerRail.
	
	^ connectableBlockLPRorVL.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> removeCloseBranch: aPLC_ConnectableBlockVerticalLink [
	"Remueve en un Vertical Link solo la parte que cierrar rama paralela."

	| connectableBlockOutputPin inputConnectableBlock |
	
	"Solo puedo borrar el Close Branch si tiene mas de un pin de entrada"
	( aPLC_ConnectableBlockVerticalLink inputs size > 1 )
		ifTrue: [
			
			( 2 to: aPLC_ConnectableBlockVerticalLink inputs size ) 
				do: [ :index |
					
					"Busco el bloque conectable conectado a la entrada numero index del VL"
					inputConnectableBlock := aPLC_ConnectableBlockVerticalLink blockConnectedToInput: index.	
						
					"Busco el pin del bloque conectable conectado a la entrada numero index del VL"	
					connectableBlockOutputPin := ( aPLC_ConnectableBlockVerticalLink connectedAtInput: index) outputPin.
					
					"Desconecto el Pin obtenido"
					connectableBlockOutputPin disconnect.
					
					"Le agrego un RPR conectado al pin"
					self addRightPowerRailConnectedTo: inputConnectableBlock output: index.
					
					"Borro el pin de entrada numero index del VL"
					aPLC_ConnectableBlockVerticalLink inputs removeAt: index.
					
					].
			
			"Chequeo que al final del borrado de pines de entrada resulte un VL valido."	
			^ self checkValidVerticalLink: aPLC_ConnectableBlockVerticalLink.
			
			].
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> removeCoil: aPLC_ConnectableBlockCoil [
	"Remueve una Bobina."

	| connectableBlockActualArgumentWriter connectableBlockOutputPin connectableBlockInputPin |

	"Busco los pines de los bloques conectables conectados a la primer entrada y salida de la bobina"	
	connectableBlockOutputPin := ( aPLC_ConnectableBlockCoil connectedAtInput: 1) outputPin.
	connectableBlockInputPin := ( aPLC_ConnectableBlockCoil connectedAtOutput: 1) inputPin.
	
	"Busco el Actual Argument  Writer de la bobina"	
	connectableBlockActualArgumentWriter := aPLC_ConnectableBlockCoil blockConnectedToOutput: 2.
	
	"Desconecto el Actual Argument  Writer de la bobina"
	( connectableBlockActualArgumentWriter connectedAtInput: 1 ) disconnect.
	
	"Desconecto la bobina"
	( aPLC_ConnectableBlockCoil connectedAtInput: 1) disconnect.
	( aPLC_ConnectableBlockCoil connectedAtOutput: 1) disconnect.
	
	"Remuevo los bloques conectables de la Network de bloques conectables"
	self removeBlock: aPLC_ConnectableBlockCoil.
	self removeBlock: connectableBlockActualArgumentWriter.
	
	"Conecto los pines obtenidos y realizo los chequeos pertinentes a LPR y VL"
	^ self checkShortCircuitIfConnect: connectableBlockOutputPin To: connectableBlockInputPin.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> removeContact: aPLC_ConnectableBlockContact [
	"Remueve un Contacto."

	| connectableBlockActualArgumentReader connectableBlockOutputPin connectableBlockInputPin VLInput VLOutput |

	"Busco los pines de los bloques conectables conectados a la primer entrada y salida del Contacto"	
	connectableBlockOutputPin := ( aPLC_ConnectableBlockContact connectedAtInput: 1) outputPin.
	connectableBlockInputPin := ( aPLC_ConnectableBlockContact connectedAtOutput: 1) inputPin.
	
	"Busco el Actual Argument  Writer del Contacto"	
	connectableBlockActualArgumentReader := aPLC_ConnectableBlockContact blockConnectedToInput: 2.
	
	"Desconecto el Actual Argument  Writer del Contacto"
	( connectableBlockActualArgumentReader connectedAtOutput: 1 ) disconnect.
	
	"Desconecto el Contacto"
	( aPLC_ConnectableBlockContact connectedAtInput: 1) disconnect.
	( aPLC_ConnectableBlockContact connectedAtOutput: 1) disconnect.
	
	"Remuevo los bloques conectables de la Network de bloques conectables"
	self removeBlock: aPLC_ConnectableBlockContact.
	self removeBlock: connectableBlockActualArgumentReader.
	
	"Conecto los pines obtenidos y realizo los chequeos pertinentes a LPR y VL"
	^ self checkShortCircuitIfConnect: connectableBlockOutputPin To: connectableBlockInputPin.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> removeFunctionCall: aPLC_ConnectableBlockFunctionCall [
	"Elimina un Llamado a Función."
	
	| connectableBlock connectableBlockOutputPin connectableBlockInputPin pou |

	"Busco los pines de los bloques conectables conectados a la primer entrada y salida del Llamado a Función"	
	connectableBlockOutputPin := ( aPLC_ConnectableBlockFunctionCall connectedAtInput: 1) outputPin.
	connectableBlockInputPin := ( aPLC_ConnectableBlockFunctionCall connectedAtOutput: 1) inputPin.
	
	
	"Desconecto y borro las entradas según que tenga conectado"
	(2 to: aPLC_ConnectableBlockFunctionCall inputs size ) do: [ :index |
	
		"Busco el Bloque Conectable conectado a la entrada número index"	
		connectableBlock := aPLC_ConnectableBlockFunctionCall blockConnectedToInput: index.
	
		"Chequeo si es un Actual Argument Reader"
		connectableBlock element isActualArgumentReader
			ifTrue: [
				"Si es Actual Argument lo desconecta y lo remueve"
				
				"Desconecto el Actual Argument Reader"
				( connectableBlock connectedAtOutput: 1 ) disconnect.
		
				"Remuevo bloques conectable de la Network de bloques conectables"
				self removeBlock: connectableBlock.
				] 
			ifFalse: [
				"Si No es Actual Argument le crea y conecta un RPR"
				
				"Desconecto el Elemento"
				( connectableBlock connectedAtOutput: 1 ) disconnect.
				
				"Creo y conecto un RPR"
				self addRightPowerRailConnectedTo: connectableBlock output: 1.
				
				].
		].


	"Siempre es un Actual Argument Writer a la salida. Se descoenectan y borran."	
	(2 to: aPLC_ConnectableBlockFunctionCall outputs size ) do: [ :index |	
		
		"Busco el Actual Argument Writer a la salida número index"	
		connectableBlock := aPLC_ConnectableBlockFunctionCall blockConnectedToOutput: index.		
		
		"Desconecto el Actual Argument Writer"
		( connectableBlock connectedAtInput: 1 ) disconnect.
		
		"Remuevo bloques conectable de la Network de bloques conectables"
		self removeBlock: connectableBlock.

		].
			
			
	"Desconecto el bloque conectable Llamado a Función"
	( aPLC_ConnectableBlockFunctionCall connectedAtInput: 1) disconnect.
	( aPLC_ConnectableBlockFunctionCall connectedAtOutput: 1) disconnect.	
	

	
	"PARCHE: ELIMINO LA INSTANCIA AL ELIMINAR EL F O FB"
	pou := aPLC_ConnectableBlockFunctionCall element network pouBody pou.
	( pou pouType = 'FUNCTION' )
		ifTrue: [ 
			"ES F"
			pou funInstVarDecls remove: aPLC_ConnectableBlockFunctionCall element instance. 
			] 
		ifFalse: [ 
			"ES FB"
			pou varDecls remove: aPLC_ConnectableBlockFunctionCall element instance. 
			].
		
		
	"Remuevo el bloque conectable Llamado a Función de la Network de bloques conectables"
	self removeBlock: aPLC_ConnectableBlockFunctionCall.
	
	"Conecto los pines obtenidos y realizo los chequeos pertinentes a LPR y VL"
	^ self checkShortCircuitIfConnect: connectableBlockOutputPin To: connectableBlockInputPin.
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> removeRightPowerRail: aPLC_ConnectableBlockRPR [
	"Remueve un Right Power Rail."

	| connectableBlockOutputPin VLorLPRInput |
	
	"Busco el bloque conectable conectado a la entrada del RPR"
	VLorLPRInput := aPLC_ConnectableBlockRPR blockConnectedToInput: 1.
	
	"Solo puedo borrar el RPR si esta conectado a un VL o LPR sino lo retorno"
	( VLorLPRInput element isLeftPowerRail or: [ VLorLPRInput element isVerticalLink ] )
		ifTrue: [
			
			"Solo puedo borrar el RPR si el LPR o VL tiene mas de una salida."
			( VLorLPRInput outputs size > 1 )
				ifTrue: [
						
					"Busco el pin del bloque conectable conectado a la primer entrada del RPR"	
					connectableBlockOutputPin := ( aPLC_ConnectableBlockRPR connectedAtInput: 1) outputPin.
							
							
					"Remuevo la salida del elemento del VL o LPR - NO ANDABA ANTES PORQUE NO HACIA ESTO"
					VLorLPRInput element outputs removeAt: ( VLorLPRInput outputs indexOf: connectableBlockOutputPin ).
					"Remuevo el pin obtenido del Bloque Conectable LPR o VL"
					VLorLPRInput outputs remove: connectableBlockOutputPin.

							
					"Desconecto el RPR"
					( aPLC_ConnectableBlockRPR connectedAtInput: 1) disconnect.
	
					"Remuevo el bloque conectable de la Network de bloques conectables"
					self removeBlock: aPLC_ConnectableBlockRPR.
					
					"Si el LPR o VL es un VL entonces debo chuequear que quede un VL valido"
					VLorLPRInput element isVerticalLink
						ifTrue: [
							^ self checkValidVerticalLink: VLorLPRInput.
							].
						
					^ VLorLPRInput.
							
					] 
			] .
]

{ #category : #'commands add-remove Elements' }
PLC_LadderNetwork >> replaceAcrualArgumentReaderFor: aPLC_Element inFunction: aPLC_ConnectableBlockF input: anInputNumber [
	"Reemplaza un Lector de Argumento Real por un contacto en la entrada  anInputNumber de la funcion aPLC_ConnectableBlockF."

	| connectableBlockOutputPinNumber lpr maxInput oc connection connectableBlockActualArgument |
	
	"Chequeo que tenga un actual argument reader en esa entrada"
	( ( aPLC_ConnectableBlockF blockConnectedToInput: anInputNumber ) element isActualArgumentReader and: [ aPLC_Element isCoil or: aPLC_Element isContact] )
		ifTrue: [	
			"Chequeo si se encuentra en una rama paralela. Si es verdadero no puedo agregar contacto."
			(self checkIfFunctionAreInAParallelBranch: aPLC_ConnectableBlockF)
				ifFalse: [
					"Chequeo que la entrada anInputNumber sea INPUT y BOOL y sea una entrada mayor a 1"
					( ( aPLC_ConnectableBlockF element inputs size >= anInputNumber and: [ anInputNumber > 1 ] )
						and: [ (aPLC_ConnectableBlockF element inputs at: anInputNumber) dataType acceptType:  PLC_DataType Bool ] ) 
						
						ifTrue: [
							"Si se cumple todo entonces reemplazo el Actual Argument Reader por un contacto"
							
							"1 - Busco el mayor numero de  entrada cableada por arriba de anInputNumber"
							maxInput := self moreWiredInputFor: aPLC_ConnectableBlockF until: anInputNumber.
							
							"2 - Busco el primer VL o LPR a la derecha yendo por maxInput"
							lpr := aPLC_ConnectableBlockF blockConnectedToInput: maxInput.
							connectableBlockOutputPinNumber := aPLC_ConnectableBlockF outputPinNumberConnectedToInput: maxInput.
							

							"Busco a través de la Funcion hacia su entrada hasta encontrar un elemento que sea un Vertical Link o
							Left Power Rail  y también guardo por cual número de pin de salida llego."

							[ lpr element isLeftPowerRail ]
								whileFalse: 
									[ maxInput :=self moreWiredInputFor: lpr.
									connectableBlockOutputPinNumber := lpr outputPinNumberConnectedToInput: maxInput.
									lpr := lpr blockConnectedToInput: maxInput. ].
	
							"Si llego aca es porque seguro llegue al LPR. Me fijo si tengo que agregar el pin o hacer lugar y agregar"
							lpr outputs size > connectableBlockOutputPinNumber
								ifTrue: [
									oc :=  lpr outputs copyFrom: connectableBlockOutputPinNumber + 1 to: lpr outputs size.
									lpr outputs: (lpr outputs copyFrom: 1 to: connectableBlockOutputPinNumber).
									lpr addOutput.
									lpr outputs: lpr outputs , oc.
									]
								ifFalse:[
									lpr addOutput.
									].

								"Busco el Actual Argument "	
								connectableBlockActualArgument := aPLC_ConnectableBlockF blockConnectedToInput: anInputNumber.
								"Desconecto el Actual Argument"
								( connectableBlockActualArgument connectedAtOutput: 1 ) disconnect.
								"Lo borro de la Network de bloques conectables"
								self removeBlock: connectableBlockActualArgument.
																
								"Conecto entre el nuevo pin y el bloque"
								lpr disconnectOutput:  connectableBlockOutputPinNumber + 1.
								lpr output: connectableBlockOutputPinNumber + 1 connectTo: aPLC_ConnectableBlockF input: anInputNumber.
								connection := lpr connectedAtOutput: connectableBlockOutputPinNumber + 1.						
								
								"Agrego el contacto o bobina"
								aPLC_Element isContact
									ifTrue: [ self addContact: aPLC_Element onConnection: connection ]. 
								aPLC_Element isCoil
									ifTrue: [ self addCoil: aPLC_Element onConnection: connection ]. 							
							
							].
					].
			].
		
	^ 'No se puede agregar contacto.'.
]

{ #category : #compilation }
PLC_LadderNetwork >> resetCompiledObjectsInElements [.
	"Reseteo todo para la proxima compilacion"

	"Reseteo los objetos de compilacion generados por los Vertical Links"
	self veriticalLinkBlocks do: [ :block |
		block element objectVarDecl: nil.
		block element objectTypeDecl: nil.
		block element numberOfCompiledImputs: 0.
		].


]

{ #category : #blocks }
PLC_LadderNetwork >> rightRailsBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un riel derecho."

	^ self blocks select: [ : each | each element isRightPowerRail ].	"VER SI VA SELECT O COLLECT"
]

{ #category : #blocks }
PLC_LadderNetwork >> veriticalLinkBlocks [
	"Retorna una coleccion de bloques conectables cuyo elemento sea un vertical link."

	^ self blocks select: [ : each | each element isVerticalLink ].	"VER SI VA SELECT O COLLECT"
]
