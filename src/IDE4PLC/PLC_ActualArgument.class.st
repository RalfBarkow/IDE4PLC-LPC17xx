"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ActualArgument is xxxxxxxxx.

Instance Variables
	actualArgument:		<Object>

actualArgument
	- xxxxx

"
Class {
	#name : #'PLC_ActualArgument',
	#superclass : #'PLC_Element',
	#instVars : [
		'actualArgument'
	],
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #accessing }
PLC_ActualArgument >> actualArgument [
	^ actualArgument
]

{ #category : #accessing }
PLC_ActualArgument >> actualArgument: anObject [
	actualArgument := anObject
]

{ #category : #connectableBlocks }
PLC_ActualArgument >> addInput [
	"Agrega una entrada al elemento."

	self inputs add: PLC_VoidOpenad new.
]

{ #category : #connectableBlocks }
PLC_ActualArgument >> addOutput [
	"Agrega una salida al elemento."

	self outputs add: PLC_VoidOpenad new.
]

{ #category : #connectableBlocks }
PLC_ActualArgument >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	| connectableBlock |
	
	"Busco el contacto, bobina o bloque conectado al actual argument"
	connectableBlock := aPLC_ConnectableBlock blockConnectedToOutput: 1.
	
	"Le pido la conexion para añadirle un nuevo elemento"
	^ connectableBlock element connectionToAddElement: aPLC_ElemenMorph inBlock: connectableBlock.
]

{ #category : #'graphic element' }
PLC_ActualArgument >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."
	
	^ PLC_ActualArgumentMorph newWithText: self actualArgument identifier.
]

{ #category : #'initialize-release' }
PLC_ActualArgument >> initialize [
	"Inicializaciones"

	super initialize.
	
	self actualArgument: PLC_VoidOpenad new.

]

{ #category : #testing }
PLC_ActualArgument >> isActualArgumentReader [
	"Devuelve true si el elemento es una ActualArgumentReader."

	^ false.
]

{ #category : #testing }
PLC_ActualArgument >> isActualArgumentWriter [
	"Devuelve true si el elemento es una ActualArgumentWriter."

	^ false.
]

{ #category : #library }
PLC_ActualArgument >> keyword [
	"Devuelve el symbol del elemento"

	^ #ActualArgument
]
