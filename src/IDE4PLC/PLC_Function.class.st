"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Function is xxxxxxxxx.

Instance Variables
	instance:		<Object>

instance
	- xxxxx

"
Class {
	#name : #'PLC_Function',
	#superclass : #'PLC_POU',
	#instVars : [
		'instance'
	],
	#classVars : [
		'StdFunctions',
		'StdFunctionsCreated',
		'UserFunctions'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_Function class >> StdFunctions [
	"Devuelve el diccionario."
		
	^ StdFunctions.
]

{ #category : #'instance creation' }
PLC_Function class >> UserFunctions [
	"Devuelve el diccionario."
		
	^ UserFunctions.
]

{ #category : #'instance creation' }
PLC_Function class >> addStdFunction: aFunctionDecl [
	"Añade una declaración de Función."
		
	StdFunctions at: aFunctionDecl typedIdentifier put: aFunctionDecl.
]

{ #category : #'instance creation' }
PLC_Function class >> addUserFunction: aFunctionDecl [
	"Añade una declaración de Función."
		
	UserFunctions at: aFunctionDecl typedIdentifier put: aFunctionDecl.
]

{ #category : #'instance creation' }
PLC_Function class >> clearFunctions [
	"Borra los diccionarios."
		
	self clearStdFunctions.
	self clearUserFunctions.
]

{ #category : #'instance creation' }
PLC_Function class >> clearStdFunctions [
	"Borra el diccionario."
		
	StdFunctions := Dictionary new.
	
	StdFunctionsCreated := false.
]

{ #category : #'instance creation' }
PLC_Function class >> clearUserFunctions [
	"Borra el diccionario."
		
	UserFunctions := Dictionary new.
]

{ #category : #'Std Arithmetic' }
PLC_Function class >> createAddFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar ADD_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'ADD'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).	
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 + pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Logical' }
PLC_Function class >> createAndFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar AND_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'AND'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 & pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			self return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'std functions' }
PLC_Function class >> createArithmeticFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones Aritméticas"
	
	"ADD"

	self createAddFunctionDeclarationWithType: PLC_DataType Int.
	self createAddFunctionDeclarationWithType: PLC_DataType DInt.
	self createAddFunctionDeclarationWithType: PLC_DataType USInt.
	self createAddFunctionDeclarationWithType: PLC_DataType UInt.
	self createAddFunctionDeclarationWithType: PLC_DataType SInt.
	self createAddFunctionDeclarationWithType: PLC_DataType UDInt.
	self createAddFunctionDeclarationWithType: PLC_DataType Real.
	self createAddFunctionDeclarationWithType: PLC_DataType LReal.
	self createAddFunctionDeclarationWithType: PLC_DataType Time.
	
	"SUB"

	self createSubFunctionDeclarationWithType: PLC_DataType Int.
	self createSubFunctionDeclarationWithType: PLC_DataType DInt.
	self createSubFunctionDeclarationWithType: PLC_DataType USInt.
	self createSubFunctionDeclarationWithType: PLC_DataType UInt.
	self createSubFunctionDeclarationWithType: PLC_DataType SInt.
	self createSubFunctionDeclarationWithType: PLC_DataType UDInt.
	self createSubFunctionDeclarationWithType: PLC_DataType Real.
	self createSubFunctionDeclarationWithType: PLC_DataType LReal.
	self createSubFunctionDeclarationWithType: PLC_DataType Time.
	
	"MUL"

	self createMulFunctionDeclarationWithType: PLC_DataType Int.
	self createMulFunctionDeclarationWithType: PLC_DataType DInt.
	self createMulFunctionDeclarationWithType: PLC_DataType USInt.
	self createMulFunctionDeclarationWithType: PLC_DataType UInt.
	self createMulFunctionDeclarationWithType: PLC_DataType SInt.
	self createMulFunctionDeclarationWithType: PLC_DataType UDInt.
	self createMulFunctionDeclarationWithType: PLC_DataType Real.
	self createMulFunctionDeclarationWithType: PLC_DataType LReal.
	self createMulFunctionDeclarationWithType: PLC_DataType Time.
	
	"DIV"

	self createDivFunctionDeclarationWithType: PLC_DataType Int.
	self createDivFunctionDeclarationWithType: PLC_DataType DInt.
	self createDivFunctionDeclarationWithType: PLC_DataType USInt.
	self createDivFunctionDeclarationWithType: PLC_DataType UInt.
	self createDivFunctionDeclarationWithType: PLC_DataType SInt.
	self createDivFunctionDeclarationWithType: PLC_DataType UDInt.
	self createDivFunctionDeclarationWithType: PLC_DataType Real.
	self createDivFunctionDeclarationWithType: PLC_DataType LReal.
	self createDivFunctionDeclarationWithType: PLC_DataType Time.
	
	"MOD (No permite Reales)"

	self createModFunctionDeclarationWithType: PLC_DataType Int.
	self createModFunctionDeclarationWithType: PLC_DataType DInt.
	self createModFunctionDeclarationWithType: PLC_DataType USInt.
	self createModFunctionDeclarationWithType: PLC_DataType UInt.
	self createModFunctionDeclarationWithType: PLC_DataType SInt.
	self createModFunctionDeclarationWithType: PLC_DataType UDInt.
	self createModFunctionDeclarationWithType: PLC_DataType Time.
	
]

{ #category : #'std functions' }
PLC_Function class >> createComparisonFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones de Comparación"
	
	"EQ - No tiene sentido comparar por igual en reales"

	self createEQFunctionDeclarationWithType: PLC_DataType Int.
	self createEQFunctionDeclarationWithType: PLC_DataType DInt.
	self createEQFunctionDeclarationWithType: PLC_DataType USInt.
	self createEQFunctionDeclarationWithType: PLC_DataType UInt.
	self createEQFunctionDeclarationWithType: PLC_DataType SInt.
	self createEQFunctionDeclarationWithType: PLC_DataType UDInt.
	self createEQFunctionDeclarationWithType: PLC_DataType Time.
	
	"NE - No tiene sentido comparar por distinto en reales"

	self createNEFunctionDeclarationWithType: PLC_DataType Int.
	self createNEFunctionDeclarationWithType: PLC_DataType DInt.
	self createNEFunctionDeclarationWithType: PLC_DataType USInt.
	self createNEFunctionDeclarationWithType: PLC_DataType UInt.
	self createNEFunctionDeclarationWithType: PLC_DataType SInt.
	self createNEFunctionDeclarationWithType: PLC_DataType UDInt.
	self createNEFunctionDeclarationWithType: PLC_DataType Time.
	
	"GT"

	self createGTFunctionDeclarationWithType: PLC_DataType Int.
	self createGTFunctionDeclarationWithType: PLC_DataType DInt.
	self createGTFunctionDeclarationWithType: PLC_DataType USInt.
	self createGTFunctionDeclarationWithType: PLC_DataType UInt.
	self createGTFunctionDeclarationWithType: PLC_DataType SInt.
	self createGTFunctionDeclarationWithType: PLC_DataType UDInt.
	self createGTFunctionDeclarationWithType: PLC_DataType Real.
	self createGTFunctionDeclarationWithType: PLC_DataType LReal.
	self createGTFunctionDeclarationWithType: PLC_DataType Time.
	
	"GE - No tiene sentido comparar por mayor o igual en reales"

	self createGEFunctionDeclarationWithType: PLC_DataType Int.
	self createGEFunctionDeclarationWithType: PLC_DataType DInt.
	self createGEFunctionDeclarationWithType: PLC_DataType USInt.
	self createGEFunctionDeclarationWithType: PLC_DataType UInt.
	self createGEFunctionDeclarationWithType: PLC_DataType SInt.
	self createGEFunctionDeclarationWithType: PLC_DataType UDInt.
	self createGEFunctionDeclarationWithType: PLC_DataType Time.
	
	"LT"

	self createLTFunctionDeclarationWithType: PLC_DataType Int.
	self createLTFunctionDeclarationWithType: PLC_DataType DInt.
	self createLTFunctionDeclarationWithType: PLC_DataType USInt.
	self createLTFunctionDeclarationWithType: PLC_DataType UInt.
	self createLTFunctionDeclarationWithType: PLC_DataType SInt.
	self createLTFunctionDeclarationWithType: PLC_DataType UDInt.
	self createLTFunctionDeclarationWithType: PLC_DataType Real.
	self createLTFunctionDeclarationWithType: PLC_DataType LReal.
	self createLTFunctionDeclarationWithType: PLC_DataType Time.
	
	"LE - No tiene sentido comparar por menor o igual en reales"

	self createLEFunctionDeclarationWithType: PLC_DataType Int.
	self createLEFunctionDeclarationWithType: PLC_DataType DInt.
	self createLEFunctionDeclarationWithType: PLC_DataType USInt.
	self createLEFunctionDeclarationWithType: PLC_DataType UInt.
	self createLEFunctionDeclarationWithType: PLC_DataType SInt.
	self createLEFunctionDeclarationWithType: PLC_DataType UDInt.
	self createLEFunctionDeclarationWithType: PLC_DataType Time.
]

{ #category : #'Std Arithmetic' }
PLC_Function class >> createDivFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar DIV_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'DIV'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 / pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createEQFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar EQ_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'EQ'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_EQ(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ');	
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createGEFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar GE_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'GE'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_GE(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ')		
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createGTFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar GT_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'GT'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_GT(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ')		
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createLEFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar LE_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'LE'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_LE(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ')		
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createLTFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar LT_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'LT'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_LT(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ')		
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Arithmetic' }
PLC_Function class >> createModFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar MOD_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'MOD'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 % pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Mov' }
PLC_Function class >> createMovFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar MOV_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'MOV'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN' 
		).	
					
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'std functions' }
PLC_Function class >> createMovFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones Mov"
	
	"MOV"

	self createMovFunctionDeclarationWithType: PLC_DataType Int.
	self createMovFunctionDeclarationWithType: PLC_DataType DInt.
	self createMovFunctionDeclarationWithType: PLC_DataType USInt.
	self createMovFunctionDeclarationWithType: PLC_DataType UInt.
	self createMovFunctionDeclarationWithType: PLC_DataType SInt.
	self createMovFunctionDeclarationWithType: PLC_DataType UDInt.
	self createMovFunctionDeclarationWithType: PLC_DataType Real.
	self createMovFunctionDeclarationWithType: PLC_DataType LReal.
	self createMovFunctionDeclarationWithType: PLC_DataType Time.
]

{ #category : #'Std Arithmetic' }
PLC_Function class >> createMulFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar MUL_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'MUL'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 * pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Comparison' }
PLC_Function class >> createNEFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar NE_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'NE'
		andDataType: aDataType
		andFunctionResultType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;

			// Cargo el valor de IN1 al CR // LD IN1
			PLC_IL_LD( &(pxPOU->IN1), sizeof(pxPOU->IN1), ' , pouDecl return dataType ilCompile , ', NullModifier);		
			
			// Hago la compración de IN2 contra el CR el resultado se guara en el CR // EQ IN2
			PLC_IL_NE(&(pxPOU->IN2), ' , pouDecl return dataType ilCompile , ')		
					
			// Almaceno el CR en OUT // ST OUT  // Las POU Funcion copian su valor de rerotno al CR, en este caso es al reves
			PLC_IL_ST( &(pxPOU->OUT), sizeof(pxPOU->OUT), NullModifier); 
		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'std functions' }
PLC_Function class >> createStandardFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones estandar"
	
	
	"MOV"
	self createMovFunctionDeclarations .
	
	"Aritméticas"
	self createArithmeticFunctionDeclarations.
	
	"Comparación"
	self createComparisonFunctionDeclarations.
	
]

{ #category : #'instance creation' }
PLC_Function class >> createStdFunctions [
	"Crea los Bloques de Función Estándar."
		
	StdFunctions := Dictionary new.
	
	self createTFStandardFunctionDeclarations. "Si la saco TF a este metodo crea todas sino crea solo con tipos INT y TIME"

	
	StdFunctionsCreated := true.
	
]

{ #category : #'Std Arithmetic' }
PLC_Function class >> createSubFunctionDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración de Función estándar SUB_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'SUB'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunction: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	pouDecl addENDeclaration.
	pouDecl addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
		
		
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		extern PLC_SymbolicRegister CR;

		// Chequeo EN / ENO
		if( pxPOU->EN )
		{
			// Hacer chequeo de si se paso del rango y si se paso poner ENO a 0

			// Si da bien el chequeo:
			pxPOU->ENO = true;
			pxPOU->OUT = pxPOU->IN1 - pxPOU->IN2;

			// Las POU Funcion copian su valor de rerotno al CR
			CR.VALUE.INT = pxPOU->OUT;
			CR.TYPE = ' , 
			pouDecl return dataType ilCompile , ';

		}
		else
		{
			pxPOU->ENO = pxPOU->EN;
		}
'.
		
	^ pouDecl.
]

{ #category : #'std functions' }
PLC_Function class >> createTFArithmeticFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones Aritméticas"
	
	"ADD"

	self createAddFunctionDeclarationWithType: PLC_DataType Int.
	"self createAddFunctionDeclarationWithType: PLC_DataType DInt.
	self createAddFunctionDeclarationWithType: PLC_DataType USInt.
	self createAddFunctionDeclarationWithType: PLC_DataType UInt.
	self createAddFunctionDeclarationWithType: PLC_DataType SInt.
	self createAddFunctionDeclarationWithType: PLC_DataType UDInt.
	self createAddFunctionDeclarationWithType: PLC_DataType Real.
	self createAddFunctionDeclarationWithType: PLC_DataType LReal."
	self createAddFunctionDeclarationWithType: PLC_DataType Time.
	
	"SUB"

	self createSubFunctionDeclarationWithType: PLC_DataType Int.
	"self createSubFunctionDeclarationWithType: PLC_DataType DInt.
	self createSubFunctionDeclarationWithType: PLC_DataType USInt.
	self createSubFunctionDeclarationWithType: PLC_DataType UInt.
	self createSubFunctionDeclarationWithType: PLC_DataType SInt.
	self createSubFunctionDeclarationWithType: PLC_DataType UDInt.
	self createSubFunctionDeclarationWithType: PLC_DataType Real.
	self createSubFunctionDeclarationWithType: PLC_DataType LReal."
	self createSubFunctionDeclarationWithType: PLC_DataType Time.
	
	"MUL"

	self createMulFunctionDeclarationWithType: PLC_DataType Int.
	"self createMulFunctionDeclarationWithType: PLC_DataType DInt.
	self createMulFunctionDeclarationWithType: PLC_DataType USInt.
	self createMulFunctionDeclarationWithType: PLC_DataType UInt.
	self createMulFunctionDeclarationWithType: PLC_DataType SInt.
	self createMulFunctionDeclarationWithType: PLC_DataType UDInt.
	self createMulFunctionDeclarationWithType: PLC_DataType Real.
	self createMulFunctionDeclarationWithType: PLC_DataType LReal."
	self createMulFunctionDeclarationWithType: PLC_DataType Time.
	
	"DIV"

	self createDivFunctionDeclarationWithType: PLC_DataType Int.
	"self createDivFunctionDeclarationWithType: PLC_DataType DInt.
	self createDivFunctionDeclarationWithType: PLC_DataType USInt.
	self createDivFunctionDeclarationWithType: PLC_DataType UInt.
	self createDivFunctionDeclarationWithType: PLC_DataType SInt.
	self createDivFunctionDeclarationWithType: PLC_DataType UDInt.
	self createDivFunctionDeclarationWithType: PLC_DataType Real.
	self createDivFunctionDeclarationWithType: PLC_DataType LReal."
	self createDivFunctionDeclarationWithType: PLC_DataType Time.
	
	"MOD (No permite Reales)"

	self createModFunctionDeclarationWithType: PLC_DataType Int.
	"self createModFunctionDeclarationWithType: PLC_DataType DInt.
	self createModFunctionDeclarationWithType: PLC_DataType USInt.
	self createModFunctionDeclarationWithType: PLC_DataType UInt.
	self createModFunctionDeclarationWithType: PLC_DataType SInt.
	self createModFunctionDeclarationWithType: PLC_DataType UDInt."
	self createModFunctionDeclarationWithType: PLC_DataType Time.
	
]

{ #category : #'std functions' }
PLC_Function class >> createTFComparisonFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones de Comparación"
	
	"EQ - No tiene sentido comparar por igual en reales"

	self createEQFunctionDeclarationWithType: PLC_DataType Int.
	"self createEQFunctionDeclarationWithType: PLC_DataType DInt.
	self createEQFunctionDeclarationWithType: PLC_DataType USInt.
	self createEQFunctionDeclarationWithType: PLC_DataType UInt.
	self createEQFunctionDeclarationWithType: PLC_DataType SInt.
	self createEQFunctionDeclarationWithType: PLC_DataType UDInt."
	self createEQFunctionDeclarationWithType: PLC_DataType Time.
	
	"NE - No tiene sentido comparar por distinto en reales"

	self createNEFunctionDeclarationWithType: PLC_DataType Int.
	"self createNEFunctionDeclarationWithType: PLC_DataType DInt.
	self createNEFunctionDeclarationWithType: PLC_DataType USInt.
	self createNEFunctionDeclarationWithType: PLC_DataType UInt.
	self createNEFunctionDeclarationWithType: PLC_DataType SInt.
	self createNEFunctionDeclarationWithType: PLC_DataType UDInt."
	self createNEFunctionDeclarationWithType: PLC_DataType Time.
	
	"GT"

	self createGTFunctionDeclarationWithType: PLC_DataType Int.
	"self createGTFunctionDeclarationWithType: PLC_DataType DInt.
	self createGTFunctionDeclarationWithType: PLC_DataType USInt.
	self createGTFunctionDeclarationWithType: PLC_DataType UInt.
	self createGTFunctionDeclarationWithType: PLC_DataType SInt.
	self createGTFunctionDeclarationWithType: PLC_DataType UDInt.
	self createGTFunctionDeclarationWithType: PLC_DataType Real.
	self createGTFunctionDeclarationWithType: PLC_DataType LReal."
	self createGTFunctionDeclarationWithType: PLC_DataType Time.
	
	"GE - No tiene sentido comparar por mayor o igual en reales"

	self createGEFunctionDeclarationWithType: PLC_DataType Int.
	"self createGEFunctionDeclarationWithType: PLC_DataType DInt.
	self createGEFunctionDeclarationWithType: PLC_DataType USInt.
	self createGEFunctionDeclarationWithType: PLC_DataType UInt.
	self createGEFunctionDeclarationWithType: PLC_DataType SInt.
	self createGEFunctionDeclarationWithType: PLC_DataType UDInt."
	self createGEFunctionDeclarationWithType: PLC_DataType Time.
	
	"LT"

	self createLTFunctionDeclarationWithType: PLC_DataType Int.
	"self createLTFunctionDeclarationWithType: PLC_DataType DInt.
	self createLTFunctionDeclarationWithType: PLC_DataType USInt.
	self createLTFunctionDeclarationWithType: PLC_DataType UInt.
	self createLTFunctionDeclarationWithType: PLC_DataType SInt.
	self createLTFunctionDeclarationWithType: PLC_DataType UDInt.
	self createLTFunctionDeclarationWithType: PLC_DataType Real.
	self createLTFunctionDeclarationWithType: PLC_DataType LReal."
	self createLTFunctionDeclarationWithType: PLC_DataType Time.
	
	"LE - No tiene sentido comparar por menor o igual en reales"

	self createLEFunctionDeclarationWithType: PLC_DataType Int.
	"self createLEFunctionDeclarationWithType: PLC_DataType DInt.
	self createLEFunctionDeclarationWithType: PLC_DataType USInt.
	self createLEFunctionDeclarationWithType: PLC_DataType UInt.
	self createLEFunctionDeclarationWithType: PLC_DataType SInt.
	self createLEFunctionDeclarationWithType: PLC_DataType UDInt."
	self createLEFunctionDeclarationWithType: PLC_DataType Time.
]

{ #category : #'std functions' }
PLC_Function class >> createTFMovFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones Mov"
	
	"MOV"

	self createMovFunctionDeclarationWithType: PLC_DataType Int.
	"self createMovFunctionDeclarationWithType: PLC_DataType DInt.
	self createMovFunctionDeclarationWithType: PLC_DataType USInt.
	self createMovFunctionDeclarationWithType: PLC_DataType UInt.
	self createMovFunctionDeclarationWithType: PLC_DataType SInt.
	self createMovFunctionDeclarationWithType: PLC_DataType UDInt.
	self createMovFunctionDeclarationWithType: PLC_DataType Real.
	self createMovFunctionDeclarationWithType: PLC_DataType LReal."
	self createMovFunctionDeclarationWithType: PLC_DataType Time.
]

{ #category : #'std functions' }
PLC_Function class >> createTFStandardFunctionDeclarations [
	"Crea y guarda en la biblioteca las funciones estandar"
	
	
	"MOV"
	self createTFMovFunctionDeclarations .
	
	"Aritméticas"
	self createTFArithmeticFunctionDeclarations.
	
	"Comparación"
	self createTFComparisonFunctionDeclarations.
	

]

{ #category : #'std functions' }
PLC_Function class >> createTestIntFunctionDeclaration [
	"Crea y devuelve una Declaración de Función estándar TEST_INT"

	| function |
	
	"Declaracion de funcionTEST_INT"

	function := PLC_Function
		newWithName: 'TEST'
		andDataType: PLC_DataType Int
		andFunctionResultType: PLC_DataType Int.
		
	PLC_Function addStdFunction: function.

	"Agrego una declaracion de variable de entrada 
	EN y una de salida ENO, ambas booleanas."
	function addENDeclaration.
	function addENODeclaration.
	
	"Agrego una declaracion de variable de entrada"
	function inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Int
			andInitialValue: nil 
			andIdentifier: 'IN1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	function inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Int
			andInitialValue: nil 
			andIdentifier: 'IN2' 
		).
			
	"Agrego una declaracion de variable de salida"
	function outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Int
			andInitialValue: nil 
			andIdentifier: 'OUT1' 
		).
			
	"Agrego una declaracion de variable de salida"
	function outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Int
			andInitialValue: nil 
			andIdentifier: 'OUT2' 
		).
			
	"Agrego una declaracion de variable de entrada-salida"
	function inOutVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'IOc vcv v cvxc vcxv xcvx cv vcxv' 
		).
			
	"Agrego una declaracion de variable de entrada-salida"
	function inOutVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Int
			andInitialValue: nil 
			andIdentifier: 'IO2 aaa sa asas aasasas asa' 
		).
		
	^ function.
]

{ #category : #'class initialization' }
PLC_Function class >> initialize [ 
	"comment stating purpose of message"

	super initialize.
	
	self clearFunctions.
]

{ #category : #'instance creation' }
PLC_Function class >> newWithName: anIdentifier andDataType: aPLC_DataType [
	"Nuevo con nombre y tipo de datos"

	| function |
	
	function := self newWithName: anIdentifier.
	
	function dataType: aPLC_DataType.
	
	function declarations returnVarDecl add: ( PLC_SymbolicVariableDecl
		newWithDataType: aPLC_DataType 
		andInitialValue: nil 
		andIdentifier: 'OUT' ).	"La variable de RETURN se llama OUT No Ret o Ret_Val"
		
	function dataType: aPLC_DataType.
		
	"Agregar a diccionario de Funciones"
	"Hacerrrrrrrrrr de la forma :
	PLC_FunctionDeclaration  add: function."
		
	^ function.
]

{ #category : #'instance creation' }
PLC_Function class >> newWithName: anIdentifier andDataType: aPLC_DataType andFunctionResultType: anotherPLC_DataType [
	"Nuevo con nombre y tipo de datos
	
	ESTE METODO SIRVE PARA HACER LAS FUNCIONES DE COMPARACION POR EJEJMPLO. 
	
	Sirve para que una función tenga un tipo de datos de Return distinto al tipo de datos de la POU (de sobrecarga)"

	| function |
	
	function := self newWithName: anIdentifier.
		
	function dataType: aPLC_DataType.
	
	function declarations returnVarDecl add: ( PLC_SymbolicVariableDecl
		newWithDataType: anotherPLC_DataType 
		andInitialValue: nil 
		andIdentifier: 'OUT' ).
		
	"Agregar a diccionario de Funciones"
	"Hacerrrrrrrrrr de la forma :
	PLC_FunctionDeclaration  add: function."
		
	^ function.
]

{ #category : #compilation }
PLC_Function >> cCompile [
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
	y las F no tienen VAR_EXTERN, ni VAR_TEMP y pisan antes del cuerpo de POU las VAR 
	
	Dentro de la estructura de instancia:
	
	self declarations inputVarDecls
	self declarations outputVarDecls
	self declarations inOutVarDecls
	self declarations varDecls
	
	Dentro de la funcion de la POU en C:
	
	self declarations constantVarDecls 
	
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
	self declarations constantVarDecls cCompile.
	
	
	"ACA FALTA QUE EN FUNCTION PISE CONCERO A LAS VAR INTERNAS PARAQUENOTENGA MEMORIA"
	
	cCode := cCode , '
	
		// Cuerpo de POU
		
',	progAcc compiledBody cCompile.
	
	
	cCode := cCode, '	
	}'.
	
	^ cCode.
]

{ #category : #compilation }
PLC_Function >> ilCompile [
	"Definición de POU en IL.
	
	Ejemplo:

	FUNCTION Fej : INT
	
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
			
	END_FUNCTION
	
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
	' , self pouType , ' ' , self identifier , ' : ' , self return dataType ilCompile , '
	
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
	self declarations constantVarDecls ilCompile .
	
	ilCode := ilCode , '
	
		 (* Cuerpo de POU *)
		
',	progAcc compiledBody ilCompile.
	
	
	ilCode := ilCode, '
			
	END_' , self pouType.
	
	^ ilCode.
]

{ #category : #'initialize-release' }
PLC_Function >> initialize [.
	"Inicializo la declaración de Función."

	super initialize.

	"Declaraciones de Variables y Tipos de Datos"
	self declarations: ( PLC_Function_Declarations functionDeclarationsWithPOUDeclaration: self ).
]

{ #category : #instance }
PLC_Function >> instanceDecl [
	"Devuelve la variable de instancia única de la declaración de Función."

	instance
		ifNil: [ 
			instance :=  self instanceDeclWithIdentifier: nil.
			].
		
	^ instance.
]

{ #category : #instance }
PLC_Function >> instanceDeclWithIdentifier: anIdentifier [
	"Devuelve una nueva variable de instancia de la declaración de Programa o Bloque de Función."
	
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

{ #category : #'POU type' }
PLC_Function >> pouType [
	"Devuelve el tipo de POU que es."

	^ 'FUNCTION'
]

{ #category : #'POU type' }
PLC_Function >> pouTypeAcronym [
	"Devuelve las siglas del tipo de POU que es."

	^ 'F'
]

{ #category : #instance }
PLC_Function >> resetInstance [
	"Borra la variable de instancia en caso de modificación de la Declaración de Función."

	instance := nil.
]

{ #category : #accessing }
PLC_Function >> return [
	^ self declarations returnVarDecl first
]
