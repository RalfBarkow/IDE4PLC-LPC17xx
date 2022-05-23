"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VariableCategoryDecl is xxxxxxxxx.

Instance Variables
	declarations:		<Object>
	scope:		<Object>

declarations
	- xxxxx

scope
	- xxxxx

"
Class {
	#name : #'PLC_VariableCategoryDecl',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'declarations',
		'scope'
	],
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> compilerVarDecls [
	"Devuelve una instancia de Declaraciones de variable internas declaradas 
	por el compilador de lenguaje gráfico. Se usa para VL_struct, 
	FyFBcableada_struc que crea el compilador de Ladder.
	
	VAR
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Var new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> constantVarDecls [
	"Devuelve una instancia de Declaraciones de variable de Salida
	
	VAR CONSTANT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Constant new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> externVarDecls [
	"Devuelve una instancia de Declaraciones de variable externas
	
	VAR_EXTERN
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Extern new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> funInstVarDecls [
	"Devuelve una instancia de Declaraciones de variable internas
	
	VAR
		...
	END_VAR
	
	"
	
	"CATEGORIA PARCHE"
	
	^ PLC_VC_funInstVar new.
	
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> globalVarDecls [
	"Devuelve una instancia de Declaraciones de variable Globales
	
	VAR_GLOBAL
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Global new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> inOutVarDecls [
	"Devuelve una instancia de Declaraciones de variable de Entrada-Salida
	
	VAR_IN_OUT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_InOut new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> inputVarDecls [
	"Devuelve una instancia de Declaraciones de variable de Entrada
	
	VAR_INPUT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Input new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> outputVarDecls [
	"Devuelve una instancia de Declaraciones de variable de Salida
	
	VAR_OUTPUT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Output new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> outputWiredVarDecl [
	"Devuelve una instancia de Declaraciones de variable de Salida que acepta cable 
	(puede haber una única salida que acepta cable por POU).
	
	VAR_OUTPUT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_OutputWired new.

	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> returnVarDecl [
	"Devuelve una instancia de Declaraciones de variable de Salida
	
	VAR_OUTPUT
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Return new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> tempVarDecls [
	"Devuelve una instancia de Declaraciones de variable internas temporales
	
	VAR_TEMP
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Temp new.
	
	^ varDecls.
]

{ #category : #'instance creation' }
PLC_VariableCategoryDecl class >> varDecls [
	"Devuelve una instancia de Declaraciones de variable internas
	
	VAR
		...
	END_VAR
	
	"
	
	| varDecls |
	
	varDecls := PLC_VC_Var new.
	
	^ varDecls.
]

{ #category : #'formal parameter check' }
PLC_VariableCategoryDecl >> acceptLiteral [
	"Devuelve true si acepta asignar literales."
	
	^ true.
]

{ #category : #'declarations check' }
PLC_VariableCategoryDecl >> acceptLocatedVarDecl [
	"Responde true si la ctegoría de variables acepta Declaraciones de Variables Localizadas"

	^ false.
]

{ #category : #'formal parameter check' }
PLC_VariableCategoryDecl >> acceptWire [
	"Responde true si la categoría de variables puede cablear su variable 
	en un lenguaje gráfico si es utilizado como pin de una POU.
	Esto se combina con el >>acceptWire de tipo de datos para definir si
	un pin permite cable en una declaracion de variable.
	No riene sentido en los lenguajes textuales. "

	^ false
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> add: aVarDecl [
	"Añade una declaración de variable"

	aVarDecl variableCategory: self.

	^ self declarations add: aVarDecl.	

]

{ #category : #declarations }
PLC_VariableCategoryDecl >> at: index [
	"Devuelve una declaración de variable en la posicion index"

	^ self declarations at: index.
]

{ #category : #compilation }
PLC_VariableCategoryDecl >> cCompile [
	"Compila la declaración de variable a C

	Devuelve:
	
	tipoDeDatos NombreVariable = ValorInicial ;	
	tipoDeDatos NombreVariable = ValorInicial ;	
	tipoDeDatos NombreVariable = ValorInicial ;
	...
	
	o un String vacio si no posee ninguna varDec
	
	"
	| decls |
	
	decls := ''.
			
	self declarations  do: [ :each |
		decls := decls , '		' , each cCompile , ';
' .
		].
	
	^ decls.
]

{ #category : #compilation }
PLC_VariableCategoryDecl >> cCompileWithoutInitialValue [
	"Compila la declaración de variable a C sin valores iniciales de las variables

	Devuelve:
	
	tipoDeDatos NombreVariable ;	
	tipoDeDatos NombreVariable ;
	tipoDeDatos NombreVariable ;
	...
	
	o un String vacio si no posee ninguna varDec
	
	"
	| decls |
	
	decls := ''.
			
	self declarations  do: [ :each |
		decls := decls , '		' , each cCompileWithoutInitialValue , ';
' .
		].
	
	^ decls.
]

{ #category : #'argument check' }
PLC_VariableCategoryDecl >> canBeRead [
	"Devuelve true si acepta ser leida. Esto es, si una declaración de variable
	en esta categoría acpeta ser asignada como argumento a un parámetro 
	formal del tipo VAR_INPUT o VAR_IN_OUT los cuales necesitan leer la 
	variable asignada."
	
	^ true.
]

{ #category : #'argument check' }
PLC_VariableCategoryDecl >> canBeWrite [
	"Devuelve true si acepta ser escrita. Esto es, si una declaración de variable
	en esta categoría acpeta ser asignada como argumento a un parámetro 
	formal del tipo VAR_OUTPUT o VAR_IN_OUT los cuales necesitan leer la 
	variable asignada."
	
	^ true.
]

{ #category : #accessing }
PLC_VariableCategoryDecl >> declarations [
	"Declarations son declaraciones de variables, que pueden ser simbolicas o de estructura"

	^ declarations
]

{ #category : #accessing }
PLC_VariableCategoryDecl >> declarations: anObject [
	declarations := anObject
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> do: aBlock [
	"Envia do con el bloque aBlock a su coleccion interna"

	self declarations do: aBlock.
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> first [
	"Devuelve una declaración de variable en la posicion 1"

	^ self at: 1
]

{ #category : #compilation }
PLC_VariableCategoryDecl >> ilCompile [
	"Compila la declaración de variable a IL

	Devuelve:
	
	VAR
		varDec
		varDec
		...
	END_VAR;
	
	o un String vacio si no posee ninguna varDec
	
	"
	| varDecl |
	
	( self declarations size = 0 )
		ifTrue: [
			^ ''.
			] 
		ifFalse: [
			varDecl := '			VAR	', self varType , '
'.
			self declarations do: [ :each |
				varDecl := varDecl , '				' , each ilCompile , ';
' .
				].
		
			varDecl := varDecl , '			END_VAR
'.
			^ varDecl.
			].
	

]

{ #category : #compilation }
PLC_VariableCategoryDecl >> ilCompileWithoutInitialValue [
	"Compila la declaración de variable a IL sin valores iniciales de las variables

	Devuelve:
	
	VAR
		varDec
		varDec
		...
	END_VAR;
	
	o un String vacio si no posee ninguna varDec
	
	"
	| varDecl |
	
	( self declarations size = 0 )
		ifTrue: [
			^ ''.
			] 
		ifFalse: [
			varDecl := '	VAR	', self varType , '
'.
			self declarations do: [ :each |
				varDecl := varDecl , '		' , each ilCompileWithoutInitialValue , ';
' .
				].
		
			varDecl := varDecl , '	END_VAR
'.
			^ varDecl.
			].
	

]

{ #category : #find }
PLC_VariableCategoryDecl >> includeVarDeclWithIdentifier: aVariableIdentifier [
	"Busca si tiene en alguna de sus declaraciones una delaracion 
	de variable con el identificador aVariableIdentifier"

	^ self declarations 
		detect: [ :each |
			each identifier = aVariableIdentifier
			 ] 
		ifNone: [
			^ nil.	"DECIA false en lugar de nil, ver si la sociedad no se desmorona por esto"
			]. 
]

{ #category : #'initialize-release' }
PLC_VariableCategoryDecl >> initialize [
	"Inicializaciones. 
	varType es el TIPO DE VARIABLE, es decir, la categoría de variable, por ejemplo, _INPUT"

	self declarations: OrderedCollection new.
	
	"self varType: ''."
	
	"self acceptWire: false."
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> last [
	"Devuelve una declaración de variable en la posicion 1"

	^ self at: self declarations size.
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> remove: aVarDecl [
	"Remueve una declaración de variable"

	^ self declarations remove: aVarDecl ifAbsent: [].
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> removeAt: index [
	"Remueve una declaración de variable"

	^ self declarations removeAt: index.
]

{ #category : #accessing }
PLC_VariableCategoryDecl >> scope [
	"scope es la variable de instancia que se engancha con unas declaraciones de 
	POU , declaraciones de Configuración o declaraciones de Recurso. Cada una de
	estas modela unámbito o scope en ingles."
	
	^ scope
]

{ #category : #accessing }
PLC_VariableCategoryDecl >> scope: anObject [
	
	scope := anObject
]

{ #category : #declarations }
PLC_VariableCategoryDecl >> size [
	"Devuelve la cantidad de elementos que tiene en su OC"

	^ self declarations size.
]

{ #category : #compilation }
PLC_VariableCategoryDecl >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ ''.
]

{ #category : #'category name' }
PLC_VariableCategoryDecl >> varType [
	
	^ ''
]
