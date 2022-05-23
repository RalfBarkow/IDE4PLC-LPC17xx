"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Program is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_Program',
	#superclass : #'PLC_POU',
	#classVars : [
		'Programs'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_Program class >> Programs [
	"Devuelve el diccionario."
	
	^ Programs.
]

{ #category : #'instance creation' }
PLC_Program class >> addProgram: aProgramDecl [
	"Añade una declaración de Programa."
		
	Programs at: aProgramDecl typedIdentifier put: aProgramDecl.
]

{ #category : #'instance creation' }
PLC_Program class >> clearPrograms [
	"Borra el diccionario."
		
	Programs := Dictionary new.
]

{ #category : #compilation }
PLC_Program >> cCompile [
	"Definiciónn de Función en C que implementa la POU.
	
	Ejemplo:

	void ProgEj ( PLC_P_Struct_ProgEj * pxPOU )
	{
		// Cuerpo de POU
		
		PLC_IL_LD ( &( pxPOU -> Ent1 ), sizeof (pxPOU -> Ent1 ), BOOL , NullModifier ); // LD Ent1
		
		PLC_IL_AND ( &( pxPOU -> Ent2 ), BOOL , NullModifier ); // AND Ent2
		
		PLC_IL_ST ( &( pxPOU ->Sal), sizeof (pxPOU ->Sal), NullModifier ); // ST Sal
	}."
	
	| progAcc cCode |
	
	"Creo el acumulador de objetos de programa."
	progAcc := PLC_ProgramAccumulator_POU new.
	
	
	"
	LAS POU NO ADMITEN VAR_GLOBAL
	
	Dentro de la estructura de instancia:
	
	self declarations inputVarDecls
	self declarations outputVarDecls
	self declarations inOutVarDecls
	self declarations varDecls
	
	Dentro de la funcion de la POU en C:
	
	self declarations constantVarDecls 
	self declarations tempVarDecls 
	self declarations externVarDecls 
	
	progAcc compilerDataTypesDecls cCompile.
	progAcc compilerVarDecls cCompile.
	progAcc compiledBody	 cCompile.
	"	

	"Le envio la petición al Cuerpo de POU de que se compile en el acumulador"
	self pouBody generateCodeIn: progAcc.
	
	cCode := '
	void ' , self cPOUName , '( ' , self declarations typeDeclarationIdentifier , ' *pxPOU )
	{
	
		// Declaraciones de Tipos de datos del compilador
		
'.
		
	cCode := cCode , progAcc compilerDataTypesDecls cCompile , '
	
		// Declaraciones de variables del compilador
		
'.
		
	cCode := cCode , progAcc compilerVarDecls cCompile , '
	
		// Declaraciones de variables del usuario
		
',	
	self declarations constantVarDecls cCompile ,
	self declarations tempVarDecls cCompile ,
	self declarations externVarDecls cCompile.
	
	
	cCode := cCode , '
	
		// Cuerpo de POU
		
',	progAcc compiledBody cCompile.
	
	
	cCode := cCode, '	
	}'.
	
	^ cCode.
	
	
	

]

{ #category : #compilation }
PLC_Program >> ilCompile [
	"Definición de POU en IL.
	
	Ejemplo:

	PROGRAM ProgEj
	
		(* Declaraciones de POU *)

			VAR_INPUT
				Ent1 : BOOL ;
				Ent2 : BOOL ;
			END_VAR
			
			VAR_OUTPUT
				Sal : BOOL ;
			END_VAR
			
		(* Cuerpo de POU *)
		
			LD Ent1
			AND Ent2
			ST Sal
			
	END_PROGRAM
	
	"
	
	| progAcc ilCode |
	
	"Creo el acumulador de objetos de programa."
	progAcc := PLC_ProgramAccumulator_POU new.
	
	
	"
	LAS POU NO ADMITEN VAR_GLOBAL
	
	Dentro de la estructura de instancia:
	
	self declarations inputVarDecls
	self declarations outputVarDecls
	self declarations inOutVarDecls
	self declarations varDecls
	
	Dentro de la funcion de la POU en C:
	
	self declarations constantVarDecls 
	self declarations tempVarDecls 
	self declarations externVarDecls 
	
	progAcc compilerDataTypesDecls cCompile.
	progAcc compilerVarDecls cCompile.
	progAcc compiledBody	 cCompile.
	"	

	"Le envio la petición al Cuerpo de POU de que se compile en el acumulador"
	self pouBody generateCodeIn: progAcc.
	
	ilCode := '
	' , self pouType , ' ' , self identifier , '
	
		 (* Declaraciones de Tipos de datos del compilador *)
		
'.
		
	ilCode := ilCode , progAcc compilerDataTypesDecls ilCompile , '
		
		 (* Declaraciones de variables del compilador *)
		
'.
		
	ilCode := ilCode , progAcc compilerVarDecls ilCompile , '
	
		 (* Declaraciones de variables del usuario *)
		
',	self declarations inputVarDecls ilCompile ,
	self declarations outputVarDecls ilCompile ,
	self declarations inOutVarDecls ilCompile ,
	self declarations varDecls ilCompile ,
	self declarations constantVarDecls ilCompile ,
	self declarations tempVarDecls ilCompile ,
	self declarations externVarDecls ilCompile.
	
	ilCode := ilCode , '
	
		 (* Cuerpo de POU *)
		
',	progAcc compiledBody ilCompile.
	
	
	ilCode := ilCode, '
			
	END_' , self pouType.
	
	^ ilCode.
]

{ #category : #'initialize-release' }
PLC_Program >> initialize [.
	"Inicializo la declaración de Programa."

	super initialize.

	"Declaraciones de Variables y Tipos de Datos"
	self declarations: ( PLC_POU_Declarations programDeclarationsWithPOUDeclaration: self ).
]

{ #category : #'POU type' }
PLC_Program >> pouType [
	"Devuelve el tipo de POU que es."

	^ 'PROGRAM'
]

{ #category : #'POU type' }
PLC_Program >> pouTypeAcronym [
	"Devuelve las siglas del tipo de POU que es."

	^ 'P'
]

{ #category : #'variable declarations' }
PLC_Program >> tempVarDecls [
	"Devuelve sus declaraciones de variables Internas Temporales"

	^ self declarations tempVarDecls.
]
