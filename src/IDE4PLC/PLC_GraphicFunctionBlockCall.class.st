"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicFunctionBlockCall is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_GraphicFunctionBlockCall',
	#superclass : #'PLC_GraphicPOUCall',
	#classVars : [
		'numberOfInstances'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #'instance creation' }
PLC_GraphicFunctionBlockCall class >> initialize [
	"Inicializacion de la clase
	
	numberOfInstances guarda el numero de instancias del llamado a FB 
	para ponerle un numero distinto a cada instancia de llamado repetido."

	numberOfInstances := 0.
]

{ #category : #'instance creation' }
PLC_GraphicFunctionBlockCall class >> newWithDeclaration: pou andNetwork: aNet [
	"Crea una nueva instancia y le asigana la instancia pasada como parámetro."

	| pouCall |
	
	pouCall := self new.
	
	"Asigno la declaración."
	pouCall declaration: pou.
	pouCall network: aNet.
				
	"Asigno la declaración de instancia. La crea la Declaración. 
	En Funciones es única en Programas y FB se crea una nueva."	
	pouCall instance: (
		pou 
			instanceDeclForForFBWithIdentifier:
				pou typedIdentifier , 
				'_VAR_' , 
				numberOfInstances asString
		). "Le pongo una PLC_SymbolicVariableDecl en lugar de una 
		PLC_InstanceVariableDecl para que no agregue el static"
		 
	"AUMENTA EL NUMERO DE LLAMADOS A FB PARA NO PISAR EL NOMBRE DE INSTANCIA"	
	numberOfInstances := numberOfInstances + 1.	
		
	"AGREGO LA DECLARACION DE VARIABLE DE INSTANCIA A LAS DECLARACIONES VAR"
	aNet pouBody pou varDecls add: 
		pouCall instance.	
	
	"Construye sus entradas y salidas a partir de su declaración."
	pouCall buildElementInputs.
	pouCall buildElementOutputs.
	
	^ pouCall.
]

{ #category : #'instance creation' }
PLC_GraphicFunctionBlockCall class >> numberOfInstances [
	"numberOfInstances guarda el numero de instancias del llamado a FB 
	para ponerle un numero distinto a cada instancia de llamado repetido."

	^ numberOfInstances.
]

{ #category : #compilation }
PLC_GraphicFunctionBlockCall >> generateCodeIn: aProgramAccumulator for: aPLC_ConnectableBlock [
	"Agrega los objetos que genera a aObjectProgram.
	Como es una instancia única debo pasarle como parámetro el bloque para el cual quiero que compile
	para que pueda leer sus entradas y salidas."
	
	| instruction pouCall fluxVarDecl structItem |
	

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
	


	"Creo la declaración de variable FLUX que la usan los llamados graficos a F y FB"
	fluxVarDecl := PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'FLUX'. 
	"Le asigno la categoría temp asi no pone el pxPOU-> en C"
	fluxVarDecl variableCategory: PLC_VariableCategoryDecl tempVarDecls.

	
	

	"Creo un llamado textual a POU y le asigno la instancia"	
	pouCall := PLC_TextualFunctionBlockCall 
		newFromDeclaration: self declaration 
		andInstanceOperand: self instance operand.		"Instance debe ser un instance Operand"

					
	"Asigno la primer salida del llamado a pou a la variable FLUX"
	(pouCall outputAssignments at: 1) 
		actualArgument: fluxVarDecl operand.	
			
	"Asigno las entradas del llamado a pou a partir de la 2da"
	( 2 to: pouCall inputAssignments size ) do: [ :index |
		(pouCall inputAssignments at: index) 
			actualArgument: (
				self actualArgumentFor: aPLC_ConnectableBlock 
					atInput: index
			).
		].
	
	"Asigno las salidas del llamado a pou a partir de la 2da"
	( 2 to: pouCall outputAssignments size ) do: [ :index |
		(pouCall outputAssignments at: index) 
			actualArgument: (
				self actualArgumentFor: aPLC_ConnectableBlock 
					atOutput: index
			).
		].
	
	
	"pouCall returnAssignment explore."

"	Ver cual es la precedencia en:

	pxPOU -> ADD_INT_VAR . IN
	
	a - (pxPOU -> ADD_INT_VAR ) . IN
	b - pxPOU -> (ADD_INT_VAR . IN )
	
	es a Esta bien
"


	"Genero: ST EN"
	structItem := PLC_StructureItem
		newWithItem: self instance operand
		andItem: (
			PLC_SymbolicVariableDecl 
				newWithDataType:  (pouCall inputAssignments at: 1) formalParameter dataType
				andInitialValue: nil 
				andIdentifier: (pouCall inputAssignments at: 1) formalParameter identifier 
				andCategory: PLC_VariableCategoryDecl tempVarDecls
			) operand.	
	instruction := PLC_ST_Instruction new.
	instruction modifiers add: PLC_IL_Modifiers NullModifier.
	instruction operands add: structItem.

		
		
				
	"Agrego ST EN al Acumulador"
	aProgramAccumulator add: instruction.	

	"Agrego el llamado textual al Acumulador"
	aProgramAccumulator add: pouCall.	
		
		
		
		
	"Genero: LD FLUX - Restituyo el CR a partir de FLUX"
	instruction := PLC_LD_Instruction new.	
	instruction modifiers add: PLC_IL_Modifiers NullModifier. 
	instruction operands add: fluxVarDecl operand.	
		
				
	"Agrego LD FLUX al Acumulador"
	aProgramAccumulator add: instruction.

	
	
	"Le indico al siguiente elemento que genere código"
	(aPLC_ConnectableBlock blockConnectedToOutput: 1) generateCodeIn: aProgramAccumulator.
]

{ #category : #testing }
PLC_GraphicFunctionBlockCall >> isFunctionBlock [
	"Devuelve true si el elemento es un llamado grafico a Bloque de Funcion."

	^ true.
]
