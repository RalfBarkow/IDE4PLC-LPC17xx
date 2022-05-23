"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_RightPowerRail is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_RightPowerRail',
	#superclass : #'PLC_Element',
	#category : #'IDE4PLC-Elements-GraphicLanguages'
}

{ #category : #connectableBlocks }
PLC_RightPowerRail >> addInput [
	"Agrega una entrada al elemento."

	self inputs add: ( PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: nil 
		andIdentifier: 'IN' ).
]

{ #category : #connectableBlocks }
PLC_RightPowerRail >> connectionToAddElement: aPLC_ElemenMorph inBlock: aPLC_ConnectableBlock [
	"Devuelve la conexion para añadirle un nuevo elemento."

	^ aPLC_ConnectableBlock connectedAtInput: 1.
	
	"Hacer que compruebe aquí si puede conectar o no el elemento nuevo pidiendole a los bloques de sus extremos si lo permiten"
	
	"SI NO PERMITEN DEVUELVEN NIL"
]

{ #category : #compilation }
PLC_RightPowerRail >> generateCodeIn: aProgramAccumulator for: aPLC_ConnectableBlock [
	"Agrega los objetos que genera a aProgramAccumulator.
	Como es una instancia única debo pasarle como parámetro el bloque para el cual quiero que compile
	para que pueda leer sus entradas y salidas."
	
	"PLC_CPU firstCheckFlag_BORRAME: true."
	


]

{ #category : #'graphic element' }
PLC_RightPowerRail >> graphicElementFor: aConnectableBlock [
	"Devuelve el Elemento grafico (Morph)."
	
	^ PLC_RightPowerRailMorph new.
]

{ #category : #'initialize-release' }
PLC_RightPowerRail >> initialize [
	"Inicializaciones"

	super initialize.
	
	self addInput.
]

{ #category : #testing }
PLC_RightPowerRail >> isRightPowerRail [
	"Devuelve true si el elemento es un Riel Derecho"

	^ true.
]

{ #category : #library }
PLC_RightPowerRail >> keyword [
	"Devuelve el symbol del elemento"

	^ #RightPowerRail 
]
