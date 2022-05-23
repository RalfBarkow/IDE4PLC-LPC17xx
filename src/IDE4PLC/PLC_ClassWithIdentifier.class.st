"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_ClassWithIdentifier is xxxxxxxxx.

Instance Variables
	identifier:		<Object>

identifier
	- xxxxx

"
Class {
	#name : #'PLC_ClassWithIdentifier',
	#superclass : #Object,
	#instVars : [
		'identifier'
	],
	#classVars : [
		'invalidIdentifiers',
		'repeatableIdentifiers'
	],
	#category : #'IDE4PLC-Compilation-Program'
}

{ #category : #'class initialization' }
PLC_ClassWithIdentifier class >> initialize [
	"inicializacion de la clase"

	self invalidIdentifiers: OrderedCollection new.
	self invalidIdentifiers add: 'Isertar_Identificador'.
	
	self repeatableIdentifiers: OrderedCollection new.
	
	self repeatableIdentifiers add: 'EN'.
	self repeatableIdentifiers add: 'ENO'.
	
	self repeatableIdentifiers add: 'IN'.
	self repeatableIdentifiers add: 'IN0'.
	self repeatableIdentifiers add: 'IN1'.
	self repeatableIdentifiers add: 'IN2'.
	self repeatableIdentifiers add: 'IN3'.
	self repeatableIdentifiers add: 'IN4'.
	self repeatableIdentifiers add: 'IN5'.
	
	self repeatableIdentifiers add: 'OUT'.
	self repeatableIdentifiers add: 'OUT0'.
	self repeatableIdentifiers add: 'OUT1'.
	self repeatableIdentifiers add: 'OUT2'.
	self repeatableIdentifiers add: 'OUT3'.
	self repeatableIdentifiers add: 'OUT4'.
	self repeatableIdentifiers add: 'OUT5'.
	
	self repeatableIdentifiers add: 'RetVal'.
	self repeatableIdentifiers add: 'N'.
	self repeatableIdentifiers add: 'G'.
	self repeatableIdentifiers add: 'K'.
	self repeatableIdentifiers add: 'MN'.
	self repeatableIdentifiers add: 'MX'.
	
	self repeatableIdentifiers add: 'Q'.
	self repeatableIdentifiers add: 'Q1'.
	self repeatableIdentifiers add: 'QU'.
	self repeatableIdentifiers add: 'QD'.
	self repeatableIdentifiers add: 'S'.
	self repeatableIdentifiers add: 'S1'.
	self repeatableIdentifiers add: 'R'.
	self repeatableIdentifiers add: 'R1'.
	self repeatableIdentifiers add: 'LD'.
	self repeatableIdentifiers add: 'CLK'.
	self repeatableIdentifiers add: 'CU'.
	self repeatableIdentifiers add: 'CD'.
	self repeatableIdentifiers add: 'CV'.
	self repeatableIdentifiers add: 'PV'.
	self repeatableIdentifiers add: 'PT'.
	self repeatableIdentifiers add: 'ET'.
	
	
	
	
]

{ #category : #accessing }
PLC_ClassWithIdentifier class >> invalidIdentifiers [
	^ invalidIdentifiers
]

{ #category : #accessing }
PLC_ClassWithIdentifier class >> invalidIdentifiers: anObject [
	invalidIdentifiers := anObject
]

{ #category : #'instance creation' }
PLC_ClassWithIdentifier class >> newWithName: aString [
	"Crea una nueva instancia con el nombre aString"

	| temp |
	
	temp := self new.
	temp identfier: aString.
	
	self invalidIdentifiers add: aString.
	
	^ temp.
]

{ #category : #accessing }
PLC_ClassWithIdentifier class >> repeatableIdentifiers [
	^ repeatableIdentifiers
]

{ #category : #accessing }
PLC_ClassWithIdentifier class >> repeatableIdentifiers: anObject [
	repeatableIdentifiers := anObject
]

{ #category : #accessing }
PLC_ClassWithIdentifier >> identifier [

	identifier
		ifNil: [
			^ 'Insertar_Identificador'
			] 
		ifNotNil: [
			^ identifier.
			].
]

{ #category : #accessing }
PLC_ClassWithIdentifier >> identifier: aString [

	| oldIdentifier |



	identifier := aString.






	"oldIdentifier := self identifier."
	
	"Chequeo que no sea un identificador repetido."

	"( self class invalidIdentifiers includes: aString )
		ifTrue: [
			self error: 'Identificador utilizado, elija otro.'
			] 
		ifFalse: ["
			
			"Valido el identificador"
			"identifier := ( PLC_Identifier validatePLCIdentifier: aString )."
	
			"Aca toco la clase. Ver si está bien."
			"( oldIdentifier =  'Isertar_Identificador' )
				ifFalse: [
					self class invalidIdentifiers remove: oldIdentifier. 
					]. ""Remuevo el viejo identificador de los identificadores ya utilizados"
			
			"(self class repeatableIdentifiers includes: aString )
				ifFalse: [
					self class invalidIdentifiers add: aString."" Añado el nuevo identificador de los identificadores ya utilizados"
				"	].
			]."
	


]
