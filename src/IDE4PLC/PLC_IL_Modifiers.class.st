"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_IL_Modifiers is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_IL_Modifiers',
	#superclass : #Object,
	#classVars : [
		'Instances',
		'InstancesCreated'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> CModifier [
	"Devuelve la única instancia de CModifier"
	
	InstancesCreated ifFalse: [self createInstances].
	
	^ Instances at: #CModifier

]

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> NModifier [
	"Devuelve la única instancia de NModifier"
	
	InstancesCreated ifFalse: [self createInstances].
	
	^ Instances at: #NModifier

]

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> NullModifier [
	"Devuelve la única instancia de NullModifier"
	
	InstancesCreated ifFalse: [self createInstances].
	
	^ Instances at: #NullModifier
]

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> ParenthesisModifier [
	"Devuelve la única instancia de ParenthesisModifier"
	
	InstancesCreated ifFalse: [self createInstances].
	
	^ Instances at: #ParenthesisModifier

]

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> clearInstances [
	"Borra las instancias únicas creadas."

	Instances := Dictionary new.
	InstancesCreated := false.
	
]

{ #category : #'instance creation' }
PLC_IL_Modifiers class >> createInstances [
	"Crea las instancias únicas."

	Instances := Dictionary new.
	
	Instances at: #NullModifier put: PLC_IL_NullModifier new.
	Instances at: #NModifier put: PLC_IL_NModifier new.
	Instances at: #CModifier put: PLC_IL_CModifier new.
	Instances at: #ParenthesisModifier put: PLC_IL_ParenthesisModifier new.

	InstancesCreated := true.
]

{ #category : #'class initialization' }
PLC_IL_Modifiers class >> initialize [

	super initialize.
	InstancesCreated ifNil: [
		InstancesCreated := false
		].
]

{ #category : #testing }
PLC_IL_Modifiers >> isNullModifier [
	"Devuelve True si es un modificador Nulo "

	^ false.
]
