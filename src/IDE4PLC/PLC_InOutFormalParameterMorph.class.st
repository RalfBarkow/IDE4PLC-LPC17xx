"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_InOutFormalParameterMorph is xxxxxxxxx.

Instance Variables
	inOutFPAssociated:		<Object>

inOutFPAssociated
	- xxxxx

"
Class {
	#name : #'PLC_InOutFormalParameterMorph',
	#superclass : #'PLC_FormalParameterMorph',
	#instVars : [
		'inOutFPAssociated'
	],
	#category : #'IDE4PLC-GraphicElementMorph'
}

{ #category : #drawing }
PLC_InOutFormalParameterMorph >> drawBackgroundOn: aCanvas [
	"Dibuja el fondo del elemento"
	
	aCanvas 
		fillRectangle: self inOutLine 
		color: self properties nonBooleanVariablePinColor; "self connectionStateLayer1 elementColor;" "DEBERIA PEDIRSELO A SU CONNECTION LAYER"
		
		fillRectangle: self underline
		fillStyle: ( self textAlign 
			underlineStyleWithColor: self userInteractionStateLayer1 blockBodyColor
			andOrigin: self position
			andDirection: self extent x @ 0 ). 
]

{ #category : #accessing }
PLC_InOutFormalParameterMorph >> inOutFPAssociated [
	
	^ inOutFPAssociated
]

{ #category : #accessing }
PLC_InOutFormalParameterMorph >> inOutFPAssociated: anObject [
	
	inOutFPAssociated := anObject
]

{ #category : #drawing }
PLC_InOutFormalParameterMorph >> inOutLine [ 
	"Morph que representa la linea que continua el pin del tag in out."
	
	^ self textAlign inOutLineFor: self
]

{ #category : #extent }
PLC_InOutFormalParameterMorph >> inOutLineExtent [
	"Ancho de la linea que continua el pin del tag in out."

	^ self extent x - self textLinesMaxWidth - self leftMargin - ( self properties scale x * 4 ).
]

{ #category : #drawing }
PLC_InOutFormalParameterMorph >> leftInOutLine [ 
	"Morph que representa la linea que continua el pin del tag in out."

	| inOutLine |
	
	inOutLine := Rectangle 
		origin: (0@0)
		corner: self inOutLineExtent @ (self properties scale y * 2).
		
	^ inOutLine align: inOutLine rightCenter with: self bounds rightCenter.
]

{ #category : #drawing }
PLC_InOutFormalParameterMorph >> rightInOutLine [ 
	"Morph que representa la linea que continua el pin del tag in out."

	| inOutLine |
	
	inOutLine := Rectangle 
		origin: (0@0)
		corner: self inOutLineExtent @ (self properties scale y * 2).
		
	^ inOutLine align: inOutLine leftCenter with: self bounds leftCenter.
]

{ #category : #position }
PLC_InOutFormalParameterMorph >> updateInputInOutFPAssociatedVerticalPosition [
	"Actualiza la posicion Vertical del elemento cuando se lo pide su inOutFPAssociated.
	Además Notifica a su owner que es un bloque para que se actualice."

	| oldBottom |
	
	oldBottom := self bottom.
	
	self bottom: ( self inOutFPAssociated bottom max: self bottom ).
	
	( oldBottom = self bottom )
		ifFalse: [
			self owner inputInOutFPVerticallyChanged: self.
			].
]

{ #category : #position }
PLC_InOutFormalParameterMorph >> updateOutputInOutFPAssociatedVerticalPosition [
	"Actualiza la posicion Vertical del elemento cuando se lo pide su inOutFPAssociated.
	Además Notifica a su owner que es un bloque para que se actualice."

	| oldBottom |
	
	oldBottom := self bottom.
	
	self bottom: ( self inOutFPAssociated bottom max: self bottom ).
	
	( oldBottom = self bottom )
		ifFalse: [
			self owner outputInOutFPVerticallyChanged: self.
			].
]
