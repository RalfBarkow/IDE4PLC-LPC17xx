"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Identifier is xxxxxxxxx.

Instance Variables
	identifier:		<Object>

identifier
	- xxxxx

"
Class {
	#name : #'PLC_Identifier',
	#superclass : #Object,
	#instVars : [
		'identifier'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'as yet unclassified' }
PLC_Identifier class >> validatePLCIdentifier: aString [
	"Valida si el string aString es un nombre de identificador, si es así lo devuelve, si no, lanza un error."

	| identifier |
	
	identifier := self new.
	
	( identifier isValidStringForIdentifier: aString )
		ifTrue: [
			^ aString.
			] 
		ifFalse: [
			self error: 'Identificador no válido. Cierre esta ventana y asigne un identificador según IEC 61131-3 : 2002.'.
			]
]

{ #category : #testing }
PLC_Identifier >> doNotContainALastUnderlineCharacter: aString [
	"Responde true si NO contiene un guion bajo como ultimo caracter."

	aString ifEmpty: [^false].
	
	^( aString last = $_) not.

	"Si da flase deberia mostrar este mensaje de error"	
	"'Entidad de PLC no válida. No puede terminar con guion bajo.'"
]

{ #category : #testing }
PLC_Identifier >> doNotContainConsecutiveUnderlines: aString [
	"Responde true si NO contiene guiones bajos consecutivos en el string"

	aString size > 1
		ifTrue: [
			^(1 to: aString size - 1) allSatisfy: [ :idx | 
				( ((aString at: idx) = $_) and:
					((aString at: (idx +1)) = $_) ) not 
				]. 
			]
		ifFalse: [ 
			^ true.
			]
]

{ #category : #accessing }
PLC_Identifier >> identifier [
	^ identifier
]

{ #category : #accessing }
PLC_Identifier >> identifier: anObject [
	identifier := anObject
]

{ #category : #'initialize-release' }
PLC_Identifier >> initialize [
	"Inicializaciones del identificador"

	self identifier: 'id'
	
]

{ #category : #testing }
PLC_Identifier >> isValidStringContentForIdentifier: aString [
	"Responde si el string contiene solo letras, dígitos y guiones bajos. 
	Además chequea que no contenga 2 o mas guiones bajos 
	consecutivos para utilizarse como nombre de identificador."

	^ ( aString allSatisfy: [ :each | each isLetter or: [ each isDigit or: [ each = $_ ] ] ] )  
	and: [
		( self underlineCorrectsForIdentifier: aString )
		and: [
			self isValidStringFirstCharacterForIdentifier: aString.
			].
		].		
			
	"Si da flase deberia mostrar este mensaje de error"
	"'Identificador No válido. Debe comenzar con una letra o guion bajo y luego puede contener letras, digitos o guiones bajos no consecutivos.'"
]

{ #category : #testing }
PLC_Identifier >> isValidStringFirstCharacterForIdentifier: aString [
	"Responde si el string contiene una letra o guion bajo como primer caracter para utilizarse como nombre de identificador."

	^ aString first isLetter or: [ aString first = $_ ].

	"Si da flase deberia mostrar este mensaje de error"	
	"'Identificador No válido. Debe comenzar con una letra o guion bajo y luego puede contener letras, digitos o guiones bajos.'"
]

{ #category : #testing }
PLC_Identifier >> isValidStringForIdentifier: aString [
	"Responde si el string es un nombre de identificador válido."

	^ (self isValidStringSizeForIdentifier: aString) and: 
		(self isValidStringContentForIdentifier: aString)
]

{ #category : #testing }
PLC_Identifier >> isValidStringSizeForIdentifier: aString [
	"Responde si el string tiene el largo valido para utilizarse como nombre de identificador."

	^ aString size <= 31.

	"Si da flase deberia mostrar este mensaje de error"
	" 'Identificador No válido. Puede tener como máximo 31 caracteres.'"
]

{ #category : #testing }
PLC_Identifier >> underlineCorrectsForIdentifier: aString [
	"Responde true si el string no contiene caracteres guiones bajos consecutivos y
	NO contiene un guion bajo como ultimo caracter."

	^ (self doNotContainConsecutiveUnderlines: aString) and:
		[self doNotContainALastUnderlineCharacter: aString ].
]
