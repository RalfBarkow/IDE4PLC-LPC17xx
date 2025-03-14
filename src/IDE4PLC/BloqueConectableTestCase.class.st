"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A BloqueConectableTestCase is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #BloqueConectableTestCase,
	#superclass : #TestCase,
	#category : #'IDE4PLC-tests'
}

{ #category : #'tests iniciales' }
BloqueConectableTestCase >> testEjemplo [
	"un ejemplito"

	| leftRail cont1 |
	leftRail := PLC_ConnectableBlock newWithElement: 
		(PLC_Element LeftPowerRail).

	cont1 := PLC_ConnectableBlock newWithElement: 
		(PLC_Element Contact).

	leftRail output: 1 connectTo: cont1 input: 1." 'Conexion exitosa'"
	
	self assert: ((leftRail outputs at: 1) connected ).
	self assert: ((leftRail outputs at: 1) connection inputPin block ) equals: cont1.

]

{ #category : #'tests iniciales' }
BloqueConectableTestCase >> testEricPoneteMediaPilaConLosTests [
	"hace mas de estos!!"


]
