"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ProgramAccumulator_POU is xxxxxxxxx.

Instance Variables
	compiledBody:		<Object>
	compilerDataTypesDecls:		<Object>
	compilerVarDecls:		<Object>

compiledBody
	- xxxxx

compilerDataTypesDecls
	- xxxxx

compilerVarDecls
	- xxxxx

"
Class {
	#name : #'PLC_ProgramAccumulator_POU',
	#superclass : #Object,
	#instVars : [
		'compilerDataTypesDecls',
		'compilerVarDecls',
		'compiledBody'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #add }
PLC_ProgramAccumulator_POU >> add: anObject [
	"Agrega a su OC compiledBody un objeto.
	Este mensaje lo usan los elementos de programa gráfico 
	para insetar su lista de elementos IL generados."

	self compiledBody add: anObject.
]

{ #category : #add }
PLC_ProgramAccumulator_POU >> addDataTypeDecl: anObject [ 
	"Agrega a su OC compilcompilerDataTypesDecls un objeto.
	Este mensaje lo usan los elementos de programa gráfico 
	VL y llamado a F o FB para insetar sus declaraciones de 
	tipos de datos generados, por ejemplo para variables cableadas."

	self compilerDataTypesDecls add: anObject.
]

{ #category : #add }
PLC_ProgramAccumulator_POU >> addVarDecl: anObject [ 
	"Agrega a su OC compilcompilerVarDecls un objeto.
	Este mensaje lo usan los elementos de programa gráfico 
	VL y llamado a F o FB para insetar sus declaraciones de 
	variables generadas, por ejemplo para variables struct 
	cableadas."

	self compilerVarDecls add: anObject.
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compiledBody [
	
	^ compiledBody
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compiledBody: anObject [
	
	compiledBody := anObject
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compilerDataTypesDecls [
	^ compilerDataTypesDecls
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compilerDataTypesDecls: anObject [
	compilerDataTypesDecls := anObject
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compilerVarDecls [
	^ compilerVarDecls
]

{ #category : #accessing }
PLC_ProgramAccumulator_POU >> compilerVarDecls: anObject [
	compilerVarDecls := anObject
]

{ #category : #'initialize-release' }
PLC_ProgramAccumulator_POU >> initialize [
	"Inicializo las colecciones de objetos de programa"

	"Declaraciones de tipos de datos typeDef"
	self compilerDataTypesDecls: PLC_Objects new.
	
	"Declaraciones de variables"
	self compilerVarDecls: PLC_VariableCategoryDecl tempVarDecls.
	
	"Cuerpo de programa"
	self compiledBody: PLC_Objects new.
	
]
