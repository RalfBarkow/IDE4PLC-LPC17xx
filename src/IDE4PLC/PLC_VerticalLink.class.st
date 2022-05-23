"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VerticalLink is xxxxxxxxx.

Instance Variables
	numberOfCompiledImputs:		<Object>
	objectTypeDecl:		<Object>
	objectVarDecl:		<Object>

numberOfCompiledImputs
	- xxxxx

objectTypeDecl
	- xxxxx

objectVarDecl
	- xxxxx

"
Class {
	#name : #'PLC_VerticalLink',
	#superclass : #'PLC_Element',
	#instVars : [
		'numberOfCompiledImputs',
		'objectTypeDecl',
		'objectVarDecl'
	],
	#classVars : [
		'numberOfInstances'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #'class initialization' }
PLC_VerticalLink class >> initialize [
	"Inicializacion de la clase"

	numberOfInstances := 0.
]

{ #category : #accesors }
PLC_VerticalLink class >> numberOfInstances [
	^ numberOfInstances
]

{ #category : #accesors }
PLC_VerticalLink class >> numberOfInstances: aNumber [
	numberOfInstances := aNumber.
]

{ #category : #connectableBlocks }
PLC_VerticalLink >> addInput [
	"Agrega una entrada al elemento."

	self inputs add: ( PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'IN' , ( self inputs size ) asString
		andCategory: PLC_VariableCategoryDecl tempVarDecls
		).

	"PLC_VariableCategoryDecl tempVarDecls      Es un parche para que compile bien"
]

{ #category : #connectableBlocks }
PLC_VerticalLink >> addOutput [
	"Agrega una salida al elemento Vertical Link."

	self outputs add: ( PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'OUT'
		andCategory: PLC_VariableCategoryDecl tempVarDecls
		).
		
	"PLC_VariableCategoryDecl tempVarDecls      Es un parche para que compile bien"
]

{ #category : #compilation }
PLC_VerticalLink >> createObjectTypeDec [
	"Devuelve el Objeto de programa Declaracion de tipos de datos que genera."
	
	| typeDecl |
	
	typeDecl := PLC_TypeDecl 
		newWithDataType: self objectStructDec 
		andIdentifier: ( self identifier , '_TYPE_STRUCT' ).
	
	typeDecl description: 'Estructura de Enlace Vertical.'.

	"Guarda y devuelve el Objeto de porgrama generado"
	self objectTypeDecl: typeDecl.
		
	^ typeDecl.
]

{ #category : #compilation }
PLC_VerticalLink >> createObjectVarDec [
	"Devuelve el Objeto de programa Declaracion de Variable que genera."
	
	| varDecl |
	
	"Genero una nueva declaracion de variable de tipo de dato estructurado"
	varDecl := PLC_SymbolicVariableDecl
		newWithDataType: self objectTypeDec 
		andInitialValue: nil 
		andIdentifier: self identifier , '_VAR_STRUCT'.
		
	" P A R C H E     le clavo una categoria para que haga bien lo de pxPOU->
	no hace falta este parche se lo pone el acumulador despues"	
	"varDecl variableCategory: PLC_VariableCategoryDecl tempVarDecls.	"
	
	"Guarda y devuelve el Objeto de porgrama generado"
	self objectVarDecl: varDecl.
	
	^ varDecl.
]

{ #category : #compilation }
PLC_VerticalLink >> generateCodeIn: aProgramAccumulator for: aPLC_ConnectableBlock [
	"Agrega los objetos que genera a aProgramAccumulator.
	Como es una instancia única debo pasarle como parámetro el bloque para el cual quiero que compile
	para que pueda leer sus entradas y salidas."
	
	| instruction |
	
	"Suma 1 a la cantidad de entradas que va guardando"
	self numberOfCompiledImputs: self numberOfCompiledImputs + 1.	
	
	( self numberOfCompiledImputs = self inputs size )
		ifTrue: [
		
			"Creo las instrucciones:
				OR NOMBREVL.VL_IN1
				OR NOMBREVL.VL_IN2
				...
				OR NOMBREVL.VL_INn-1
			
				NOTA: va ahasta n-1 pues el ultimo valor de entrada lo tiene almacenado en el CR"
					
			( 1 to:  (self inputs size - 1 ) ) do: [ :index |
				
				"Creo una nueva instrucción OR"
				instruction := PLC_OR_Instruction new.	
				instruction modifiers add: PLC_IL_Modifiers NullModifier.	
					
				"Aquí le creo de operando a la instrucion OR un objeto que cuando este 
				le pide que se compile da por ejemplo, NOMBREVARSTRUC.VARITEM"
				
				instruction operands add: (
					PLC_StructureItem 
						newWithItem: self objectVarOperand  
						andItem: ( self inputs at: index ) operand
					).	
				
				"Agrego los objetos generados, estos deben entender ilCompile y cCompile"
				
"self halt.
	
instruction cCompile."
				
				aProgramAccumulator add: instruction.	
						
"aProgramAccumulator compiledBody cCompile."
				
				].	
			
			"Si el VL tiene más de una salida debe almacenar el valor de esta para repetirlo en las demas"		
			( self outputs size > 1)
				ifTrue: [			
					"Creo la instruccion ST NOMBREVL.VL_OUT "	
							
					"Creo una nueva instrucción ST"
					instruction := PLC_ST_Instruction new.
					instruction modifiers add: PLC_IL_Modifiers NullModifier.
				
					"Aquí le creo de operando a la instrucion ST un objeto que cuando este 
					le pide que se compile da por ejemplo, NOMBREVARSTRUC.VARITEM"
					instruction operands add: (
						PLC_StructureItem 
							newWithItem: self objectVarOperand  
							andItem: self outputs first operand
						).
					
					"Agrego los objetos generados, estos deben entender ilCompile y cCompile"
				
"self halt.
	
instruction cCompile."

					aProgramAccumulator add: instruction.	
						
"aProgramAccumulator compiledBody cCompile."

						
								
					"Finalmente compilo todos los bloques conectables conectados a las salidas de este VL
					intercalando instrucciones LD NOMBREVL.VLOUT para darle al circuito siguiente el
					valor correcto de salida. Recordar que el VL repite su valor de salida en todas sus 
					salidas"
			
					"Creo la instruccion LD NOMBREVL.VL_OUT "	
							
					"Creo una nueva instrucción LD"
					instruction := PLC_LD_Instruction new.
					instruction modifiers add: PLC_IL_Modifiers NullModifier.
				
					"Aquí le creo de operando a la instrucion ST un objeto que cuando este 
					le pide que se compile da por ejemplo, NOMBREVARSTRUC.VARITEM"
					instruction operands add: (
						PLC_StructureItem 
							newWithItem: self objectVarOperand  
							andItem: self outputs first operand
						).
			
					"Compilo el bloque conectado a la primer salida"
					(aPLC_ConnectableBlock blockConnectedToOutput: 1) generateCodeIn: aProgramAccumulator.
			
					"Compilo los bloques conectados a partir de la segunda salida anteponiendo LD NOMBREVL.VL_OUT"
					(2 to: self outputs size) do: [ :each | 	
				
						"Agrego la instruccion LD NOMBREVL.VL_OUT "
				
"self halt.
	
instruction cCompile."

						aProgramAccumulator add: instruction.	
						
"aProgramAccumulator compiledBody cCompile."

							
						"Compilo el bloque conectado a la primer salida"
						(aPLC_ConnectableBlock blockConnectedToOutput: each) generateCodeIn: aProgramAccumulator.
						
						].
					]
				ifFalse: [
					
					"Si solo tiene una sola salida simplemente le digo al bloque conectado a 
					esa que genere sus objetos de porgrama"
					(aPLC_ConnectableBlock blockConnectedToOutput: 1) generateCodeIn: aProgramAccumulator.
					
					].
			] 
		
		ifFalse: [				
			"Creo una nueva instrucción ST"
			instruction := PLC_ST_Instruction new.	
			instruction modifiers add: PLC_IL_Modifiers NullModifier.
			
				
			"Aquí le creo de operando a la instrucion ST un objeto que cuando este 
			le pide que se compile da por ejemplo, NOMBREVARSTRUC.VARITEM"
			instruction  operands add: (
				PLC_StructureItem 
					newWithItem: self objectVarOperand  
					andItem: ( self inputs at: self numberOfCompiledImputs ) operand
				).
				
			"Agrego los objetos generados, estos deben entender ilCompile y cCompile"
				
"self halt.
	
instruction cCompile."
			aProgramAccumulator add: instruction.			
						
"aProgramAccumulator compiledBody cCompile."

			].
]

{ #category : #'graphic element' }
PLC_VerticalLink >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."
	
	^ PLC_VerticalLinkMorph newFromElement: self.
]

{ #category : #'initialize-release' }
PLC_VerticalLink >> initialize [
	"Inicializaciones"
	
	super initialize.
	
	"Genera el nombre único de cada VL"
	self identifier: 'VL' , self class numberOfInstances asString.
	self class numberOfInstances: self class numberOfInstances + 1.
	
	"Inicio a flase el flag que indica si tiene todas sus entradas"
	self numberOfCompiledImputs: 0.
	
	
]

{ #category : #testing }
PLC_VerticalLink >> isVerticalLink [
	"Devuelve true si el elemento es un Vertical Link."

	^ true.
]

{ #category : #library }
PLC_VerticalLink >> keyword [
	"Devuelve el symbol del elemento"

	^ #VerticalLink 
]

{ #category : #accessing }
PLC_VerticalLink >> numberOfCompiledImputs [
	^ numberOfCompiledImputs
]

{ #category : #accessing }
PLC_VerticalLink >> numberOfCompiledImputs: anObject [
	numberOfCompiledImputs := anObject
]

{ #category : #compilation }
PLC_VerticalLink >> objectStructDec [
	"Devuelve el Objeto de programa Declaracion de Variable que genera."
	
	| structDecl outVarDecl |
	
	"Genero una nueva declaracion de tipo de dato estructurado"
	structDecl := PLC_StructureDecl newWithIdentifier: ( self identifier , '_STRUCT' ).

	"Agrego al tipo las variables de entrada del VL. 
	No necesita la ultima pues cuando compila su valor viene en el CR"
	self inputs do: [ :each |
		
		" P A R C H E     le clavo una categoria para que haga bien lo de pxPOU->"	
		"each variableCategory: PLC_VariableCategoryDecl tempVarDecls.	"
		
		structDecl add: each. 
		].
	
	"Agrego al tipo la única variable de salida del VL pues en todas las salidas va el mismo valor"
	
	outVarDecl := self outputs first.
	
	" P A R C H E     le clavo una categoria para que haga bien lo de pxPOU->"	
	"outVarDecl variableCategory: PLC_VariableCategoryDecl tempVarDecls.	"
			
	structDecl add: outVarDecl.
	
		
	^ structDecl.
]

{ #category : #compilation }
PLC_VerticalLink >> objectTypeDec [
	"Devuelve el Objeto de programa Declaracion de tipos de datos que genera."
	
	self objectTypeDecl
		ifNil: [
			^ self createObjectTypeDec.
			]
		ifNotNil:  [
			^ self objectTypeDecl.
			]
]

{ #category : #accessing }
PLC_VerticalLink >> objectTypeDecl [
	^ objectTypeDecl
]

{ #category : #accessing }
PLC_VerticalLink >> objectTypeDecl: anObject [
	objectTypeDecl := anObject
]

{ #category : #compilation }
PLC_VerticalLink >> objectVarDec [
	"Devuelve el Objeto de programa Declaracion de Variable que genera."
	
	self objectVarDecl
		ifNil: [
			^ self createObjectVarDec.
			]
		ifNotNil:  [
			^ self objectVarDecl.
			]
]

{ #category : #accessing }
PLC_VerticalLink >> objectVarDecl [
	^ objectVarDecl
]

{ #category : #accessing }
PLC_VerticalLink >> objectVarDecl: anObject [
	objectVarDecl := anObject
]

{ #category : #compilation }
PLC_VerticalLink >> objectVarOperand [
	"Devuelve el Objeto de programa Operando de Variable."	
	
	^ self objectVarDec operand.
]
