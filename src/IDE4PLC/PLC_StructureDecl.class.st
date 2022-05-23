"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_StructureDecl is xxxxxxxxx.

Instance Variables
	declarations:		<Object>

declarations
	- xxxxx

"
Class {
	#name : #'PLC_StructureDecl',
	#superclass : #'PLC_DerivedDataType',
	#instVars : [
		'declarations'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_StructureDecl class >> newWithIdentifier: ident [ 
	"Nueva instancia con identificador ident."

	| struct |
	
	struct := self new.
	struct identifier: ident.
	
	^ struct.
]

{ #category : #collection }
PLC_StructureDecl >> add: varDecl [
	"Añade una declaracion de variable a su colecccion de declaraciones"

	self declarations add: varDecl.
]

{ #category : #collection }
PLC_StructureDecl >> at: aNumber [
	"Devuelve una declaracion de variable a su colecccion de declaraciones en la posicion aNumber"

	^ self declarations at: aNumber.

]

{ #category : #compilation }
PLC_StructureDecl >> cCompile [
	"Compila la declaración de tipo de dato estructurado a C como declaracion"

	^ self cCompileWithoutInitialValue.

]

{ #category : #compilation }
PLC_StructureDecl >> cCompileDataType [
	"Compila la declaración de tipo de dato estructurado a C como tipo de datos"
	
	^ self dataType.

]

{ #category : #compilation }
PLC_StructureDecl >> cCompileWithoutInitialValue [
	"Compila la declaración de tipo de dato estructurado a C como declaracion

	Devuelve:
	
	struct nombreEstructura{
		varDeclWithoutInitialValue ;
		varDeclWithoutInitialValue ;
		...
		}
	"

	| structDec |
	
	structDec := '', self dataType , '{
'.
		
	self declarations do: [ :each |
		structDec := structDec , '			' , each cCompileWithoutInitialValue , ';
'.
		].
		
	structDec := structDec , '		}'.
	
	^ structDec.

]

{ #category : #types }
PLC_StructureDecl >> dataType [
	"Devuelve su tipo de datos"
	
	^ 'struct ' , self identifier.

]

{ #category : #accessing }
PLC_StructureDecl >> declarations [
	^ declarations
]

{ #category : #accessing }
PLC_StructureDecl >> declarations: anObject [
	declarations := anObject
]

{ #category : #compilation }
PLC_StructureDecl >> identifierAt: aNumber [
	"Devuelve el identificador de la variable que contiene en el idice aNumber"

	^ (self declarations at: aNumber ) identifier.
]

{ #category : #compilation }
PLC_StructureDecl >> ilCompile [
	"Compila la declaración de tipo de dato estructurado a IL como declaracion

	Devuelve:
	
		NombreTipoStructura : 
			STRUCT
				varDecl ;
				varDecl ;
				...
			END_STRUCT
		
	"

	| strucTypeDec |
		
	strucTypeDec := '				STRUCT
'.
	
	self declarations do: [ :each |
		strucTypeDec := strucTypeDec , '					' , each ilCompile , ';
'.
		].
		
	strucTypeDec := strucTypeDec , '				END_STRUCT'.
	
	^ strucTypeDec.
]

{ #category : #compilation }
PLC_StructureDecl >> ilCompileDataType [
	"Compila la declaración de tipo de dato estructurado a IL como tipo de datos"
	
	^ self dataType.

]

{ #category : #compilation }
PLC_StructureDecl >> ilCompileWithoutInitialValue [
	"Compila la declaración de tipo de dato estructurado a IL como declaracion

	Devuelve:
	
		NombreTipoStructura : 
			STRUCT
				varDeclWithoutInitialValue ;
				varDeclWithoutInitialValue ;
				...
			END_STRUCT
		
	"

	| strucTypeDec |
		
	strucTypeDec := '		STRUCT
'.
	
	self declarations do: [ :each |
		strucTypeDec := strucTypeDec , '			' , each ilCompileWithoutInitialValue , ';
'.
		].
		
	strucTypeDec := strucTypeDec , '		END_STRUCT'.
	
	^ strucTypeDec.
]

{ #category : #compilation }
PLC_StructureDecl >> initialValue [
	"Devuelve el identificador de la variable que contiene en el idice aNumber"

	^ PLC_StructureInitialization newWithStructDecl: self.
]

{ #category : #compilation }
PLC_StructureDecl >> initialValue: aStructInitialization [
	"Devuelve el identificador de la variable que contiene en el idice aNumber"

	( 1 to: self declarations size ) do: [ :index |
		( self declarations at: index )
			 initialValue: ( aStructInitialization values at: index ).
		].
]

{ #category : #'initialize-release' }
PLC_StructureDecl >> initialize [
	"Inicializaciones
	
	declarations es una coleccion de objetos PLC_SimpleSymbolicVarDecl"

	super initialize.
	declarations := OrderedCollection new.
]

{ #category : #testing }
PLC_StructureDecl >> isDerivedDataType [
	"Devuelve un booleano respondiendo si es un tipo derivado"

	^ true.
]

{ #category : #testing }
PLC_StructureDecl >> isElementaryDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ false.
]

{ #category : #testing }
PLC_StructureDecl >> isGenericDataType [
	"Devuelve un booleano respondiendo si es un tipo genérico"

	^ false.
]

{ #category : #testing }
PLC_StructureDecl >> isStructDataType [
	"Devuelve un booleano respondiendo si es un tipo elemental"

	^ true.
]

{ #category : #types }
PLC_StructureDecl >> keyword [
	"Devuelve el keyword del tipo de dato."

	^ self identifier asSymbol.
]

{ #category : #collection }
PLC_StructureDecl >> remove: aSimpleSymbolicVarDecl [
	"Remueve una declaracion de variable a su colecccion de declaraciones"

	self declarations remove: aSimpleSymbolicVarDecl.
]
