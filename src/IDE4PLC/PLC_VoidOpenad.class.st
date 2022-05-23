"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VoidOpenad is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_VoidOpenad',
	#superclass : #Object,
	#category : #'IDE4PLC-Operands'
}

{ #category : #compilation }
PLC_VoidOpenad >> cCompile [
	"Este objeto representa al operando vacio."

	^ self identifier.
]

{ #category : #compilation }
PLC_VoidOpenad >> dataType [
	"Devuelve el tipo de datos."

	^ PLC_DataType Void.
]

{ #category : #compilation }
PLC_VoidOpenad >> dataValue [
	
	^ PLC_Literal newWithDataType: self dataType andDataValue: '???'.
]

{ #category : #compilation }
PLC_VoidOpenad >> identifier [
	"Devuelve el identificador de su declaration"

	^ '<???>'.
]

{ #category : #compilation }
PLC_VoidOpenad >> ilCompile [
	"Este objeto representa al operando vacio."

	^ self identifier.
]

{ #category : #testing }
PLC_VoidOpenad >> isPLCLiteral [
	"Devuelve true si es literal"

	^ false.
]

{ #category : #testing }
PLC_VoidOpenad >> isStructItem [
	"Devuelve true si es StructItem"

	^ false.
]

{ #category : #testing }
PLC_VoidOpenad >> isVaraible [
	"Devuelve true pues es variable"

	^ false.
]

{ #category : #testing }
PLC_VoidOpenad >> isVoid [
	"Devuelve true si es void"

	^ true.
]
