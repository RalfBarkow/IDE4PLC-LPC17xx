"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Reals is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Reals',
	#superclass : #'PLC_ElementaryDataType',
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #types }
PLC_Reals >> acceptValue: aValue [
	"Devuelve un booleano que indica si el tipo de datos acepta la constante que se le queire asignar"

	aValue isFloat 
		ifTrue: [ ^ aValue abs between: 0.0 and: self maxPositiveValue.] 
		ifFalse: [ ^ false ].
	
	
"Estrictamente seria:

^ aValue abs between: self minPositiveValue and: self maxPositiveValue.
"
]

{ #category : #types }
PLC_Reals >> initialValue [
	"Devuelve el valor inicial del tipo de dato."
	
	^ PLC_Literal newWithDataType: self andDataValue: 0.0.
]

{ #category : #types }
PLC_Reals >> maxNegativeValue [
	"Valor máximo negativo permitido del tipo de dato."
	
	^ self maxPositiveValue negated.
]

{ #category : #types }
PLC_Reals >> minNegativeValue [
	"Valor mínimo negativo permitido del tipo de dato."
		
	^ self minPositiveValue negated.
]

{ #category : #types }
PLC_Reals >> range [
	"Devuelve el rango de representacion del tipo de dato."

	^ self maxNegativeValue asString , ' a ' , self minNegativeValue asString , ' y de ' , self minPositiveValue asString , ' a ' , self maxPositiveValue asString.
]
