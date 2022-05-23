"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU_Declarations is xxxxxxxxx.

Instance Variables
	funInstVarDecls:		<Object>
	pouDecl:		<Object>
	userDataTypesDecls:		<Object>
	userVarDecls:		<Object>

funInstVarDecls
	- xxxxx

pouDecl
	- xxxxx

userDataTypesDecls
	- xxxxx

userVarDecls
	- xxxxx

"
Class {
	#name : #'PLC_POU_Declarations',
	#superclass : #Object,
	#instVars : [
		'pouDecl',
		'userDataTypesDecls',
		'userVarDecls',
		'funInstVarDecls'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_POU_Declarations class >> functionBlockDeclarationsWithPOUDeclaration: aPOUDecl [
	"Devuelve una nueva instancia con declaraciones de Bloque de Funcion"

	| decls |

	decls := self newWithUserVarDecls.
	
	"Declaraciones de Tipos de Datos"
	"decls compilerDataTypesDecls.
	decls userDataTypesDecls."
	
	"Declaraciones de Variables"
	"decls compilerVarDecls."
	decls userVarDecls add: PLC_VariableCategoryDecl tempVarDecls.
	
	decls pouDecl: aPOUDecl.
	
	^ decls.
]

{ #category : #'instance creation' }
PLC_POU_Declarations class >> functionDeclarationsWithPOUDeclaration: aPOUDecl [
	"Devuelve una nueva instancia con declaraciones de Funcion"

	| decls |

	decls := self newWithUserVarDecls.
	
	"Declaraciones de Variables"
	decls userVarDecls add: PLC_VariableCategoryDecl returnVarDecl.
	
	decls pouDecl: aPOUDecl.
	
	^ decls.
]

{ #category : #'instance creation' }
PLC_POU_Declarations class >> newWithUserVarDecls [
	"Devuelve una nueva instancia con declaraciones"
	
	| decls |

	decls := self new.
	
	"Declaraciones de Tipos de Datos"
	"decls compilerDataTypesDecls.
	decls userDataTypesDecls."
	
	"Declaraciones de Variables"
	
	decls userVarDecls add: PLC_VariableCategoryDecl inputVarDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl outputVarDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl inOutVarDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl varDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl constantVarDecls.

	^ decls.
]

{ #category : #'instance creation' }
PLC_POU_Declarations class >> programDeclarationsWithPOUDeclaration: aPOUDecl [
	"Devuelve una nueva instancia con declaraciones de programa"

	| decls |

	decls := self newWithUserVarDecls.
	
	"Declaraciones de Tipos de Datos"
	"decls userDataTypesDecls."
	
	"Declaraciones de Variables"
	decls userVarDecls add: PLC_VariableCategoryDecl tempVarDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl externVarDecls.
	
	decls pouDecl: aPOUDecl.
	
	^ decls.
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> constantVarDecls [
	"Devuelve sus declaraciones de variables Internas de valor Constante"

	^ self userVarDecls at: 5.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> externVarDecls [
	"Devuelve sus declaraciones de variables Internas"

	^ self userVarDecls at: 7.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #accessing }
PLC_POU_Declarations >> funInstVarDecls [
	
	^ funInstVarDecls
]

{ #category : #accessing }
PLC_POU_Declarations >> funInstVarDecls: anObject [
	
	funInstVarDecls := anObject
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> inOutVarDecls [
	"Devuelve sus declaraciones de variables de Entrada-Salida"

	^ self userVarDecls at: 3.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #find }
PLC_POU_Declarations >> includeVarDeclWithIdentifier: aVariableIdentifier [
	"Busca si tiene en alguna de sus declaraciones una delaracion 
	de variable con el identificador aVariableIdentifier"

	self userVarDecls do: [ :each |
		( each includeVarDeclWithIdentifier: aVariableIdentifier )
			ifNotNil: [ ^ each includeVarDeclWithIdentifier: aVariableIdentifier ].
		 ].
	
	^ nil.
]

{ #category : #'initialize-release' }
PLC_POU_Declarations >> initialize [
	"Inicializa las Colecciones de declaraciones de una POU"

	"Declaraciones de Tipos de Datos"
	userDataTypesDecls := OrderedCollection new.
	
	"Declaraciones de Variables"
	userVarDecls := OrderedCollection new.
	
	"PARCHEEEE DECLARCIONES OCULTAS DE INSTANCIAS DE F"
	funInstVarDecls := PLC_VariableCategoryDecl funInstVarDecls.
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> inputVarDecls [
	"Devuelve sus declaraciones de variables de Entrada"

	^ self userVarDecls at: 1.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> outputVarDecls [
	"Devuelve sus declaraciones de variables de Salida"

	^ self userVarDecls at: 2.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #accessing }
PLC_POU_Declarations >> pouDecl [
	
	^ pouDecl
]

{ #category : #accessing }
PLC_POU_Declarations >> pouDecl: anObject [
	
	pouDecl := anObject
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> returnVarDecl [
	"Devuelve su declaracion de variables de Return"

	^ self userVarDecls at: 6.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
returnVarDecl"
]

{ #category : #instance }
PLC_POU_Declarations >> structureDeclaration [
	"Declaracion de tipo de dato estructurado."

	| struct |

	struct := PLC_StructureDecl 
		newWithIdentifier: self structureDeclarationIdentifier.

	"AÑADO LAS VARIABLES A LA ESTRUCTURA"

	"Variables de Entrada"
	self inputVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables de Entrada-Salida"
	self inOutVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables de Salida"
	self outputVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables Internas"
	self varDecls do: [ :each |
		struct add: each.
		].
	
	self funInstVarDecls do: [ :each |
		struct add: each.
		].
	 
	
	^ struct.
]

{ #category : #instance }
PLC_POU_Declarations >> structureDeclarationIdentifier [
	"Identificador de tipo de dato estructurado."

	^ 'Struct_' , self pouDecl typedIdentifier.
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> tempVarDecls [
	"Devuelve sus declaraciones de variables Internas Temporales"

	^ self userVarDecls at: 6.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]

{ #category : #instance }
PLC_POU_Declarations >> typeDeclaration [
	"Declaracion de tipo de dato derivado."

	| type |

	type := PLC_TypeDecl 
		newWithDataType: self structureDeclaration
		andIdentifier: self typeDeclarationIdentifier.

	^ type.
]

{ #category : #instance }
PLC_POU_Declarations >> typeDeclarationIdentifier [
	"Identificador de tipo de dato estructurado."

	^ 'PLC_' , self pouDecl pouTypeAcronym , '_' , self structureDeclarationIdentifier.
]

{ #category : #accessing }
PLC_POU_Declarations >> userDataTypesDecls [
	^ userDataTypesDecls
]

{ #category : #accessing }
PLC_POU_Declarations >> userDataTypesDecls: anObject [
	userDataTypesDecls := anObject
]

{ #category : #accessing }
PLC_POU_Declarations >> userVarDecls [
	
	^ userVarDecls
]

{ #category : #accessing }
PLC_POU_Declarations >> userVarDecls: anObject [
	
	userVarDecls := anObject
]

{ #category : #'variable declarations' }
PLC_POU_Declarations >> varDecls [
	"Devuelve sus declaraciones de variables Internas"

	^ self userVarDecls at: 4.
	
"inputVarDecls
outputVarDecls
inOutVarDecls
varDecls
constantVarDecls
tempVarDecls
externVarDecls"
]
