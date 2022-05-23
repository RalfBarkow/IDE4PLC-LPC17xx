"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_AnyInteger is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_AnyInteger',
	#superclass : #'PLC_GenericDataType',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_AnyInteger >> acceptedDataTypes [
	"Devuelve un Array que contiene la lista de los tipos aceptados"

	^	PLC_DataType SInt acceptedDataTypes , 		
		PLC_DataType Int acceptedDataTypes ,	
		PLC_DataType DInt acceptedDataTypes ,
		PLC_DataType LInt acceptedDataTypes ,
		PLC_DataType USInt acceptedDataTypes ,		
		PLC_DataType UInt acceptedDataTypes ,
		PLC_DataType UDInt acceptedDataTypes ,
		PLC_DataType ULInt acceptedDataTypes.
]

{ #category : #types }
PLC_AnyInteger >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ #ANY_INT.
]
