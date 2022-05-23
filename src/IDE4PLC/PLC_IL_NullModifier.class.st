"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_IL_NullModifier is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_IL_NullModifier',
	#superclass : #'PLC_IL_Modifiers',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #compile }
PLC_IL_NullModifier >> cCompile [
	"Devuelve el string del código IL del modificador"

	^ 'NullModifier'.
]

{ #category : #compile }
PLC_IL_NullModifier >> ilCompile [
	"Devuelve el string del código IL del modificador"

	^ ''.
]

{ #category : #testing }
PLC_IL_NullModifier >> isNullModifier [
	"Devuelve True si es un modificador Nulo "

	^ true.
]
