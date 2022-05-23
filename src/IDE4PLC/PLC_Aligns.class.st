"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Aligns is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Aligns',
	#superclass : #Object,
	#classVars : [
		'Aligns',
		'AlignsCreated'
	],
	#category : #'IDE4PLC-GraphicElementMorph-States'
}

{ #category : #'instance creation' }
PLC_Aligns class >> center [
	"Devuelve la única instancia de alineación central"
	
	AlignsCreated ifFalse: [self createAligns].
	
	^ Aligns at: #center
]

{ #category : #'instance creation' }
PLC_Aligns class >> clearAligns [
	"Borra las alineaciones"

	Aligns := Dictionary new.
	AlignsCreated := false.
	
]

{ #category : #'instance creation' }
PLC_Aligns class >> createAligns [
	"Crea las 3 instancias únicas de alineaciones"

	Aligns := Dictionary new.
	
	Aligns at: #left put: PLC_LeftAlign new.
	Aligns at: #center put: PLC_CenterAlign new.
	Aligns at: #right put: PLC_RightAlign new.

	AlignsCreated := true.
]

{ #category : #'class initialization' }
PLC_Aligns class >> initialize [

	super initialize.
	AlignsCreated ifNil: [
		AlignsCreated := false
		].
]

{ #category : #'instance creation' }
PLC_Aligns class >> left [
	"Devuelve la única instancia de alineación izquierda"
	
	AlignsCreated ifFalse: [self createAligns].
	
	^ Aligns at: #left
]

{ #category : #'instance creation' }
PLC_Aligns class >> right [
	"Devuelve la única instancia de alineación derecha"
	
	AlignsCreated ifFalse: [self createAligns].
	
	^ Aligns at: #right
]
