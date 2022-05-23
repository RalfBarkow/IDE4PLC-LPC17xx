"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_POU is xxxxxxxxx.

Instance Variables
	dataType:		<Object>
	declarations:		<Object>
	pouBody:		<Object>

dataType
	- xxxxx

declarations
	- xxxxx

pouBody
	- xxxxx

"
Class {
	#name : #'PLC_POU',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'pouBody',
		'declarations',
		'dataType'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_POU class >> newWithName: anIdentifier [ 
	"Nuevo con nombre"

	| pou |
	
	pou := self new.
	pou identifier: anIdentifier.
		
	^ pou.
]

{ #category : #'instance creation' }
PLC_POU class >> newWithName: anIdentifier andDataType: aPLC_DataType [
	"Nuevo con nombre y tipo de datos"

	| pou |
	
	pou := self newWithName: anIdentifier.
		
	pou dataType: aPLC_DataType.
		
	^ pou.
]

{ #category : #parallel }
PLC_POU >> acceptParallel [
	"Responde true si la POU acepta estar conectada en una rama paralela en Ladder.
		
	Quiero agregar un elemento llamado a POU en la conexión ==
	
	|	c1		 c2			b1
	|-----|  |----------|  |-----+-----(  )------|
	|				    |
	|	c3			    |
	|-----|  |---------==----+	
	|
	"

	"Se lo delega el llamado a esta declaraion de POU.
	Responden True solo un par de Funciones (las de comparación)"
	
	^ false.
]

{ #category : #'called POUs' }
PLC_POU >> addCalledPOUsIn: aCalledPOU [
	"Añade sus declaraciones de pou F y FB que llame en su cuerpo"

	^ self pouBody addCalledPOUsIn: aCalledPOU.

]

{ #category : #'variable declarations' }
PLC_POU >> addENDeclaration [
	"Añade la declaración de variable BOOLEANAde entrada EN"

	self inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: true 
			andIdentifier: 'EN' 
		).
			
]

{ #category : #'variable declarations' }
PLC_POU >> addENODeclaration [
	"Añade la declaración de variable BOOLEANA de salida ENO"

	self outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil
			andIdentifier: 'ENO' 
		).
]

{ #category : #compilation }
PLC_POU >> cCompilePrototype [
	"Prototipo de Función en C que implementa la POU
	
	Ejemplo:

	void ProgEj ( PLC_P_Struct_ProgEj *);"
	
	^ '
	void ' , self cPOUName , '( ' , self declarations typeDeclarationIdentifier , ' * );'
]

{ #category : #compilation }
PLC_POU >> cPOUName [
	"Devuelve el nombre en C de la POU"
	
	"Ejemplo: 
	
	PLC_F_ADD_INT"
	
	^ 'PLC_' , self pouTypeAcronym , '_' , self typedIdentifier.
]

{ #category : #'data types declarations' }
PLC_POU >> compilerDataTypesDecls [
	"Devuelve sus declaraciones de Tipos de datos declarados por el compilador
	de lenguaje grafico.
	Las conoce el object una vez que la POU fue compilada."

	^ self object compilerDataTypesDecls.
]

{ #category : #'variable declarations' }
PLC_POU >> compilerVarDecls [
	"Devuelve sus declaraciones de variables internas declaradas por el compilador. 
	Las conoce el object una vez que la POU fue compilada."

	^ self object compilerVarDecls.
]

{ #category : #connectableBlocks }
PLC_POU >> connectableBlockInputs [
	"Cantidad de entradas para el bloque conectable."

	^ self inputVarDecls size + self inOutVarDecls size.
]

{ #category : #connectableBlocks }
PLC_POU >> connectableBlockOutputs [
	"Cantidad de salidas para el bloque conectable."

	^ self outputVarDecls size + self inOutVarDecls size.
]

{ #category : #'variable declarations' }
PLC_POU >> constantVarDecls [
	"Devuelve sus declaraciones de variables Internas de valor Constante"

	^ self declarations constantVarDecls.
]

{ #category : #accessing }
PLC_POU >> dataType [
	
	^ dataType
]

{ #category : #accessing }
PLC_POU >> dataType: anObject [
	
	dataType := anObject
]

{ #category : #accessing }
PLC_POU >> declarations [
	^ declarations
]

{ #category : #accessing }
PLC_POU >> declarations: anObject [
	declarations := anObject
]

{ #category : #'variable declarations' }
PLC_POU >> funInstVarDecls [
	"Devuelve sus declaraciones de variables Internas de instancias de Funciones. ES UN PARCHASOOO ESTA CATEGORIA"

	^ self declarations funInstVarDecls.
]

{ #category : #compilation }
PLC_POU >> generateCode [
	"Genera el acumulador de programa y se lo pasa a sus declaraciones de POU y Cuerpo de POU para que lo llenen"
	
	| progAcc |
	
	"Creo el acumulador de objetos de programa."
	progAcc := PLC_ProgramAccumulator_POU new.

	"Le envio la petición al Cuerpo de POU de que se compile en el acumulador"
	self pouBody generateCodeIn: progAcc.
	
	^ progAcc.
	


]

{ #category : #'variable declarations' }
PLC_POU >> inOutVarDecls [
	"Devuelve sus declaraciones de variables de Entrada-Salida"

	^ self declarations inOutVarDecls.
]

{ #category : #'variable declarations' }
PLC_POU >> inputVarDecls [
	"Devuelve sus declaraciones de variables de Entrada"

	^ self declarations inputVarDecls.
]

{ #category : #instance }
PLC_POU >> instanceDecl [
	"Devuelve una nueva declaracion de variable de instancia de la declaración de Programa o Bloque de Función."

	^ self instanceDeclWithIdentifier: nil.
]

{ #category : #instance }
PLC_POU >> instanceDeclForForFBWithIdentifier: anIdentifier [
	"Devuelve una nueva variable de instancia de la declaración de Programa o Bloque de Función."

	| instance |
	
	anIdentifier 
		ifNil: [
			instance := PLC_SymbolicVariableDecl 
				newWithDataType: self typeDeclaration 
				andInitialValue: nil
				andIdentifier: self typedIdentifier , '_VAR'.
			]
		ifNotNil: [
			instance := PLC_SymbolicVariableDecl 
				newWithDataType: self typeDeclaration 
				andInitialValue: nil
				andIdentifier: anIdentifier.
			].

	^ instance.
]

{ #category : #instance }
PLC_POU >> instanceDeclWithIdentifier: anIdentifier [
	"Devuelve una nueva variable de instancia de la declaración de Programa o Bloque de Función."

	| instance |
	
	anIdentifier 
		ifNil: [
			instance := PLC_InstanceVariableDecl
				newWithDataType: self typeDeclaration 
				andInitialValue: nil
				andIdentifier: self typedIdentifier , '_VAR'.
			]
		ifNotNil: [
			instance := PLC_InstanceVariableDecl 
				newWithDataType: self typeDeclaration 
				andInitialValue: nil
				andIdentifier: anIdentifier.
			].

	^ instance.
]

{ #category : #test }
PLC_POU >> isUserDefined [
	"Responde True si su cuerpo de pou definido por el usuario. si es estandar responde false"

	^ self pouBody isUserDefined.
]

{ #category : #'variable declarations' }
PLC_POU >> outputVarDecls [
	"Devuelve sus declaraciones de variables de Salida"

	^ self declarations outputVarDecls.
]

{ #category : #accessing }
PLC_POU >> pouBody [
	^ pouBody
]

{ #category : #accessing }
PLC_POU >> pouBody: anObject [
	pouBody := anObject
]

{ #category : #instance }
PLC_POU >> structureDeclaration [
	"Declaracion de tipo de dato estructurado."
	
	^ self declarations structureDeclaration.
]

{ #category : #instance }
PLC_POU >> typeDeclaration [
	"Declaracion de tipo de dato derivado."
	
	^ self declarations typeDeclaration.
]

{ #category : #'typed identifier' }
PLC_POU >> typedIdentifier [
	"Devuelve su identificador con tipo de datos.
	
	Ejemplo: 
	
		ADD_INT
	"
	
	self dataType 
		ifNil: [ 
			^ self identifier.
			] 
		ifNotNil: [ 
			^ self identifier , '_' , self dataType ilCompile.
			].
]

{ #category : #'data types declarations' }
PLC_POU >> userDataTypesDecls [
	"Devuelve sus declaraciones de Tipos de datos declarados por el usuario"

	^ self declarations userDataTypesDecls.
]

{ #category : #'data types declarations' }
PLC_POU >> userVarDecls [
	"Devuelve sus declaraciones de Variables hechas por el usuario"

	^ self declarations userVarDecls.
]

{ #category : #'variable declarations' }
PLC_POU >> varDecls [
	"Devuelve sus declaraciones de variables Internas"

	^ self declarations varDecls.
]
