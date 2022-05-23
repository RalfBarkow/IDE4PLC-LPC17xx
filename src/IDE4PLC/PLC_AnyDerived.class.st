"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_AnyDerived is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_AnyDerived',
	#superclass : #'PLC_GenericDataType',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_AnyDerived >> acceptedDataTypes [
	"Devuelve un Array que contiene la lista de los tipos aceptados.
	En este caso devuelve todos los tipos de datos creados por el
	uduario."

	^ PLC_DataType derivedDataTypes keys.
]

{ #category : #types }
PLC_AnyDerived >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #ANY_DERIVED.
]
