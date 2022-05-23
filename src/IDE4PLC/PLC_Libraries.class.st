"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Libraries is xxxxxxxxx.

Instance Variables
	dataTypes:		<Object>
	funcionBlockDecls:		<Object>
	functionBlockList:		<Object>
	functionDecls:		<Object>
	functionList:		<Object>
	ilInstructions:		<Object>
	ladderElementList:		<Object>
	ladderElements:		<Object>
	programDecls:		<Object>
	programList:		<Object>
	stdFuncionBlocks:		<Object>
	stdFuncions:		<Object>

dataTypes
	- xxxxx

funcionBlockDecls
	- xxxxx

functionBlockList
	- xxxxx

functionDecls
	- xxxxx

functionList
	- xxxxx

ilInstructions
	- xxxxx

ladderElementList
	- xxxxx

ladderElements
	- xxxxx

programDecls
	- xxxxx

programList
	- xxxxx

stdFuncionBlocks
	- xxxxx

stdFuncions
	- xxxxx

"
Class {
	#name : #'PLC_Libraries',
	#superclass : #Object,
	#instVars : [
		'programDecls',
		'funcionBlockDecls',
		'functionDecls',
		'stdFuncionBlocks',
		'stdFuncions',
		'ilInstructions',
		'ladderElements',
		'dataTypes',
		'programList',
		'ladderElementList',
		'functionList',
		'functionBlockList'
	],
	#classVars : [
		'Instance'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_Libraries class >> clearInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNotNil: 
		[
		Instance := nil.
		].



]

{ #category : #'instance creation' }
PLC_Libraries class >> uniqueInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNil: 
		[
		Instance := self new.
		].
	
	^ Instance.
]

{ #category : #lists }
PLC_Libraries >> clearLists [
	
	functionList := nil.
	functionBlockList := nil.
	programList := nil.
	ladderElementList := nil.
]

{ #category : #library }
PLC_Libraries >> dataTypeLibrary [
	"Devuelve biblioteca de todos los tipos de datos.
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_DataType AllDataTypeNameStrings.
]

{ #category : #accessing }
PLC_Libraries >> dataTypes [
	
	^ dataTypes
]

{ #category : #accessing }
PLC_Libraries >> dataTypes: anObject [
	
	dataTypes := anObject
]

{ #category : #accessing }
PLC_Libraries >> funcionBlockDecls [
	
	^ funcionBlockDecls
]

{ #category : #lists }
PLC_Libraries >> functionBlockList [
	
	functionBlockList ifNil: [
		functionBlockList :=	PLC_ListSelector
			newWithLibrary: PLC_FunctionBlock StdFunctionBlocks
			andColor: PLC_GraphicElementProperties uniqueInstance functionBlockHeaderColor
			andBorderColor: PLC_GraphicElementProperties uniqueInstance functionBlockColor.
		].
	
	^ functionBlockList
]

{ #category : #lists }
PLC_Libraries >> functionBlockList: anObject [
	
	functionBlockList := anObject
]

{ #category : #accessing }
PLC_Libraries >> functionDecls [
	
	^ functionDecls
]

{ #category : #accessing }
PLC_Libraries >> functionDecls: anObject [
	
	functionDecls := anObject
]

{ #category : #lists }
PLC_Libraries >> functionList [
	"Devuelve el controlador de la lista de funciones"

	functionList ifNil: [
		functionList := PLC_ListSelector 
			newWithLibrary: PLC_Function StdFunctions
			andColor: PLC_GraphicElementProperties uniqueInstance functionHeaderColor
			andBorderColor: PLC_GraphicElementProperties uniqueInstance functionColor.
		].
	
	^ functionList
]

{ #category : #lists }
PLC_Libraries >> functionList: anObject [
	
	functionList := anObject
]

{ #category : #accessing }
PLC_Libraries >> ilInstructions [
	
	^ ilInstructions
]

{ #category : #accessing }
PLC_Libraries >> ilInstructions: anObject [
	
	ilInstructions := anObject
]

{ #category : #library }
PLC_Libraries >> ilInstructionsLibrary [ 
	"Devuelve la biblioteca de todos las Instrucciones del lenguaje IL.
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_DataType AllDataTypeNameStrings.
]

{ #category : #'initialize-release' }
PLC_Libraries >> initialize [ 
	"Inicializo las librerias"	
	
	"
	programDecls 
		funcionBlockDecls 
		functionDecls 
	stdFuncionBlocks 
	stdFuncions 
	
	ilInstructions 
	ladderElements
	dataTypes
	variableDeclarations
	variableTypes
	plcDevices
	literals
	"
]

{ #category : #library }
PLC_Libraries >> ladderElementLibrary [ 
	"Devuelve la biblioteca de todos los Elementos Ladder ( ej: contacto, bobina, VL)
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_DataType AllDataTypeNameStrings.

]

{ #category : #accessing }
PLC_Libraries >> ladderElementList [
	
	ladderElementList ifNil: [
		ladderElementList := PLC_ListSelector
			newWithLibrary: PLC_Function StdFunctions
			andColor: PLC_GraphicElementProperties uniqueInstance functionBlockHeaderColor
			andBorderColor: PLC_GraphicElementProperties uniqueInstance functionBlockColor.
		].
	
	^ ladderElementList
]

{ #category : #accessing }
PLC_Libraries >> ladderElements [
	
	^ ladderElements
]

{ #category : #accessing }
PLC_Libraries >> ladderElements: anObject [
	
	ladderElements := anObject
]

{ #category : #library }
PLC_Libraries >> programDeclationLibrary [ 
	"Devuelve la biblioteca de todos los Programas declarados
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_DataType AllDataTypeNameStrings.

	" Posibles bibliotecas:
	------------------------------
	
	funcionBlockDeclationLibrary
	functionDeclationLibrary
	standardFuncionBlockLibrary 
	standardFuncionLibrary 
	
	ilInstructionsLibrary 
	ladderElementLibrary 
	dataTypeLibrary 
	
	variableDeclarationLibrary 
	variableTypesLibrary 
	plcDevices
	literals"
]

{ #category : #accessing }
PLC_Libraries >> programDecls [
	
	^ programDecls
]

{ #category : #accessing }
PLC_Libraries >> programDecls: anObject [
	
	programDecls := anObject
]

{ #category : #accessing }
PLC_Libraries >> programList [

	programList ifNil: [
		programList :=	PLC_ListSelector
			newWithLibrary: PLC_Function StdFunctions
			andColor: PLC_GraphicElementProperties uniqueInstance programHeaderColor
			andBorderColor: PLC_GraphicElementProperties uniqueInstance programColor.
		].
	
	^ programList
]

{ #category : #library }
PLC_Libraries >> standardFuncionBlockLibrary [ 
	"Devuelve la biblioteca de todos los Bloques de Función estándar.
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_DataType AllDataTypeNameStrings.

]

{ #category : #library }
PLC_Libraries >> standardFuncionLibrary [ 
	"Devuelve la biblioteca de todos las Funciones  estándar.
	Esto es un array con todos los identificadores de los tipos de datos."

	^ PLC_Function StdFunctions.
]

{ #category : #accessing }
PLC_Libraries >> stdFuncionBlocks [
	
	^ stdFuncionBlocks
]

{ #category : #accessing }
PLC_Libraries >> stdFuncionBlocks: anObject [
	
	stdFuncionBlocks := anObject
]

{ #category : #accessing }
PLC_Libraries >> stdFuncions [
	
	^ stdFuncions
]

{ #category : #accessing }
PLC_Libraries >> stdFuncions: anObject [
	
	stdFuncions := anObject
]
