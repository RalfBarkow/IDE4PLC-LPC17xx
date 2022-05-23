"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Element is xxxxxxxxx.

Instance Variables
	inputs:		<Object>
	outputs:		<Object>

inputs
	- xxxxx

outputs
	- xxxxx

"
Class {
	#name : #'PLC_Element',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'inputs',
		'outputs'
	],
	#classVars : [
		'Elements',
		'ElementsCreated'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #'instance creation' }
PLC_Element class >> ActualArgumentReader [

	^ PLC_ActualArgumentReader new.
]

{ #category : #'instance creation' }
PLC_Element class >> ActualArgumentWriter [ 

	^ PLC_ActualArgumentWriter new.
]

{ #category : #elements }
PLC_Element class >> AllLadderElementNamesStrings [.

	^ self Elements keys.
]

{ #category : #'instance creation' }
PLC_Element class >> Coil [
	"Devuelve la única instancia del elemento NOCoil"
	
	ElementsCreated ifFalse: [self createElements].
	
	^ Elements at: #Coil
]

{ #category : #'instance creation' }
PLC_Element class >> LeftPowerRail [

	^ PLC_LeftPowerRail new.
]

{ #category : #'instance creation' }
PLC_Element class >> NCContact [
	"Devuelve la única instancia del elemento NCContact"
	
	ElementsCreated ifFalse: [self createElements].
	
	^ Elements at: #NCContact
]

{ #category : #'instance creation' }
PLC_Element class >> NCoil [
	"Devuelve la única instancia del elemento NCCoil"
	
	ElementsCreated ifFalse: [self createElements].
	
	^ Elements at: #NCoil
]

{ #category : #'instance creation' }
PLC_Element class >> NOContact [
	"Devuelve la única instancia del elemento NOContact"
	
	ElementsCreated ifFalse: [self createElements].
	
	^ Elements at: #NOContact
]

{ #category : #'instance creation' }
PLC_Element class >> RightPowerRail [

	^ PLC_RightPowerRail new.
]

{ #category : #'instance creation' }
PLC_Element class >> VerticalLink [

	^ PLC_VerticalLink new.
]

{ #category : #'instance creation' }
PLC_Element class >> clearElements [
	"Borra las instancias únicas creadas."

	Elements := Dictionary new.
	ElementsCreated := false.
	
]

{ #category : #'instance creation' }
PLC_Element class >> createElements [
	"Crea los elementos que son de instancia única."

	Elements := Dictionary new.
	
	"Contactos"
	
	Elements at: #NOContact put: PLC_Contact new.
	(Elements at: #NOContact) modifier: PLC_IL_Modifiers NullModifier. 
	(Elements at: #NOContact) morph: PLC_NOContactMorph. 
	
	Elements at: #NCContact put: PLC_Contact new.
	(Elements at: #NCContact) modifier: PLC_IL_Modifiers NModifier. 
	(Elements at: #NCContact) morph: PLC_NCContactMorph. 
	
	Elements at: #Coil put: PLC_Coil new.
	(Elements at: #Coil) modifier: PLC_IL_Modifiers NullModifier. 
	(Elements at: #Coil) morph: PLC_CoilMorph. 
	
	"Bobinas"
	
	Elements at: #NCoil put: PLC_Coil new.
	(Elements at: #NCoil) modifier: PLC_IL_Modifiers NModifier.
	(Elements at: #NCoil) morph: PLC_NCoilMorph.
	
	Elements at: #NCoil put: PLC_Coil new.
	(Elements at: #NCoil) modifier: PLC_IL_Modifiers NModifier.
	(Elements at: #NCoil) morph: PLC_NCoilMorph.

	ElementsCreated := true.
]

{ #category : #'class initialization' }
PLC_Element class >> initialize [

	super initialize.
	
	ElementsCreated ifNil: [
		ElementsCreated := false
		].
	
]

{ #category : #parallel }
PLC_Element >> acceptParallel [
	"Responde true si el elemento acepta estar conectado en una rama paralela en Ladder.
	
	|	c1		 c2			b1
	|-----|  |----------|  |-----+-----(  )------|
	|				    |
	|	c3			    |
	|-----|  |---------==----+	
	|
	
	Quiero agregar un elemento en la conexión ==
	
	"

	^ false.
]

{ #category : #connectableBlocks }
PLC_Element >> actualArgumentFor: aPLC_ConnectableBlock atInput: anInputNumber [
	"Devuelve el actualArgument, es decir, la variable o literal que contiene el elemento"
			
	^ (aPLC_ConnectableBlock blockConnectedToInput: anInputNumber) element actualArgument
]

{ #category : #connectableBlocks }
PLC_Element >> actualArgumentFor: aPLC_ConnectableBlock atOutput: anOutputNumber [
	"Devuelve el actualArgument, es decir, la variable o literal que contiene el elemento"
			
	^ (aPLC_ConnectableBlock blockConnectedToOutput: anOutputNumber) element actualArgument
]

{ #category : #connectableBlocks }
PLC_Element >> addInput [
	"Agrega una entrada al elemento."

	"| decl |
	
	decl := PLC_SimpleSymbolicVarDecl 
		newWithDataType: PLC_DataTypes Bool
		andInitialValue: nil 
		andIdentifier: 'IN' , ( self inputs size ) asString.

	self inputs add: ( PLC_SimpleSymbolicVar newWithDeclaration: decl andDataValue: nil )."
	
	
	self inputs add: ( PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'IN' , ( self inputs size ) asString
		).

]

{ #category : #connectableBlocks }
PLC_Element >> addOutput [
	"Agrega una salida al elemento."

	"| decl |
	
	decl := PLC_SimpleSymbolicVarDecl 
		newWithDataType: PLC_DataTypes Bool
		andInitialValue: nil 
		andIdentifier: 'OUT' , ( self outputs size ) asString.

	self outputs add: ( PLC_SimpleSymbolicVar newWithDeclaration: decl andDataValue: nil )."
	

	self outputs add: ( PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'OUT' , ( self outputs size ) asString ).
]

{ #category : #connectableBlocks }
PLC_Element >> connectableBlockInputs [
	"Cantidad de entradas para el bloque conectable."

	^ self inputs size.
]

{ #category : #connectableBlocks }
PLC_Element >> connectableBlockOutputs [
	"Cantidad de salidas para el bloque conectable."

	^ self outputs size.
]

{ #category : #connectableBlocks }
PLC_Element >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ aPLC_ConnectableBlock connectedAtOutput: 1.
	
	"Hacer que compruebe aquí si puede conectar o no el elemento nuevo pidiendole a los bloques de sus extremos si lo permiten"
	
	"SI NO PERMITEN DEVUELVEN NIL"
	

	"PISO ESTE METODO EN RightPowerRail "
]

{ #category : #'initialize-release' }
PLC_Element >> initialize [
	"Inicializaciones"

	self inputs: OrderedCollection new.
	self outputs: OrderedCollection new.
]

{ #category : #accessing }
PLC_Element >> inputs [
	
	^ inputs
]

{ #category : #accessing }
PLC_Element >> inputs: anObject [
	
	inputs := anObject
]

{ #category : #testing }
PLC_Element >> isActualArgumentReader [
	"Devuelve true si el elemento es una ActualArgumentReader."

	^ false.
]

{ #category : #testing }
PLC_Element >> isActualArgumentWriter [
	"Devuelve true si el elemento es una ActualArgumentWriter."

	^ false.
]

{ #category : #testing }
PLC_Element >> isCoil [
	"Devuelve true si el elemento es una Bobina."

	^ false.
]

{ #category : #testing }
PLC_Element >> isConnection [
	"Devuelve siempre false. ESTE METODO ES UNA MUGRE PARA QUE FUNCIONE FACIL close branch"

	^ false.
]

{ #category : #testing }
PLC_Element >> isContact [
	"Devuelve true si el elemento es un Contacto."

	^ false.
]

{ #category : #testing }
PLC_Element >> isFunction [
	"Devuelve true si el elemento es un llamado grafico a Funcion."

	^ false.
]

{ #category : #testing }
PLC_Element >> isFunctionBlock [
	"Devuelve true si el elemento es un llamado grafico a Bloque de Funcion."

	^ false.
	

]

{ #category : #testing }
PLC_Element >> isLeftPowerRail [
	"Devuelve true si el elemento es un Riel Izquierdo"

	^ false.
]

{ #category : #testing }
PLC_Element >> isRightPowerRail [
	"Devuelve true si el elemento es un Riel Derecho"

	^ false.
]

{ #category : #testing }
PLC_Element >> isVerticalLink [
	"Devuelve true si el elemento es un Vertical Link."

	^ false.
]

{ #category : #accessing }
PLC_Element >> outputs [
	
	^ outputs
]

{ #category : #accessing }
PLC_Element >> outputs: anObject [
	
	outputs := anObject
]
