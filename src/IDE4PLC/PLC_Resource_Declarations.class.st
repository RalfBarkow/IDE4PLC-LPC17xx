"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Resource_Declarations is xxxxxxxxx.

Instance Variables
	resourceDecl:		<Object>
	userDataTypesDecls:		<Object>
	userVarDecls:		<Object>

resourceDecl
	- xxxxx

userDataTypesDecls
	- xxxxx

userVarDecls
	- xxxxx

"
Class {
	#name : #'PLC_Resource_Declarations',
	#superclass : #Object,
	#instVars : [
		'resourceDecl',
		'userDataTypesDecls',
		'userVarDecls'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_Resource_Declarations class >> newWithResourceDeclaration: aResourceDecl [
	"Devuelve una nueva instancia con el recurso que le llega como parametro"

	| decls |

	decls := self new.
	
	"Categorías de Declaraciones de Variables"
	decls userVarDecls add: PLC_VariableCategoryDecl globalVarDecls.
	decls userVarDecls add: PLC_VariableCategoryDecl externVarDecls.
	
	"Le agrego el Recurso"
	decls resourceDecl: aResourceDecl.
	
	^ decls.
]

{ #category : #'variable declarations' }
PLC_Resource_Declarations >> externVarDecls [
	"Devuelve sus declaraciones de variables VAR_EXTERN"

	^ self userVarDecls at: 2.
	
"globalVarDecls
externalVarDecls"
]

{ #category : #'variable declarations' }
PLC_Resource_Declarations >> globalVarDecls [
	"Devuelve sus declaraciones de variables VAR_GLOBAL"

	^ self userVarDecls at: 1.
	
"globalVarDecls
externalVarDecls"
]

{ #category : #find }
PLC_Resource_Declarations >> includeVarDeclWithIdentifier: aVariableIdentifier [
	"Busca si tiene en alguna de sus declaraciones una delaracion 
	de variable con el identificador aVariableIdentifier"

	^ self userVarDecls includeVarDeclWithIdentifier: aVariableIdentifier.
	
]

{ #category : #'initialize-release' }
PLC_Resource_Declarations >> initialize [
	"Inicializa las Colecciones de declaraciones de una POU"

	"Declaraciones de Tipos de Datos"
	userDataTypesDecls := OrderedCollection new.
	
	"Declaraciones de Variables"
	userVarDecls := OrderedCollection new.
]

{ #category : #accessing }
PLC_Resource_Declarations >> resourceDecl [
	
	^ resourceDecl
]

{ #category : #accessing }
PLC_Resource_Declarations >> resourceDecl: anObject [
	
	resourceDecl := anObject
]

{ #category : #instance }
PLC_Resource_Declarations >> structureDeclaration [
	"Declaracion de tipo de dato estructurado."

	| struct |

	struct := PLC_StructureDecl 
		newWithIdentifier: self structureDeclarationIdentifier.

	"AÑADO LAS VARIABLES A LA ESTRUCTURA"

	"Variables Globales"
	self globalVarDecls do: [ :each |
		struct add: each.
		].
	
	"Variables Externas"
	self externVarDecls do: [ :each |
		struct add: each.
		].	 
	
	^ struct.
]

{ #category : #instance }
PLC_Resource_Declarations >> structureDeclarationIdentifier [
	"Identificador de tipo de dato estructurado."

	^ 'Struct_' , self resourceDecl identifier.
]

{ #category : #instance }
PLC_Resource_Declarations >> typeDeclaration [
	"Declaracion de tipo de dato derivado."

	| type |

	type := PLC_TypeDecl 
		newWithDataType: self structureDeclaration
		andIdentifier: self typeDeclarationIdentifier.

	^ type.
]

{ #category : #instance }
PLC_Resource_Declarations >> typeDeclarationIdentifier [
	"Identificador de tipo de dato estructurado."

	^ 'PLC_' , self resourceDecl pouTypeAcronym , '_' , self structureDeclarationIdentifier.
]

{ #category : #accessing }
PLC_Resource_Declarations >> userDataTypesDecls [
	^ userDataTypesDecls
]

{ #category : #accessing }
PLC_Resource_Declarations >> userDataTypesDecls: anObject [
	userDataTypesDecls := anObject
]

{ #category : #accessing }
PLC_Resource_Declarations >> userVarDecls [
	
	^ userVarDecls
]

{ #category : #accessing }
PLC_Resource_Declarations >> userVarDecls: anObject [
	
	userVarDecls := anObject
]
