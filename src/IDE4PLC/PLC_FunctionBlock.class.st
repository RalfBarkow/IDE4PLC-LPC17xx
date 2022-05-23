"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_FunctionBlock is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_FunctionBlock',
	#superclass : #'PLC_POU',
	#classVars : [
		'StdFunctionBlocks',
		'StdFunctionBlocksCreated',
		'UserFunctionBlocks'
	],
	#category : #'IDE4PLC-Declarations-POU'
}

{ #category : #'instance creation' }
PLC_FunctionBlock class >> StdFunctionBlocks [
	"Devuelve el diccionario."
	
	^ StdFunctionBlocks.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> UserFunctionBlocks [
	"Devuelve el diccionario."
	
	^ UserFunctionBlocks.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> addStdFunctionBlock: aFunctionBlockDecl [
	"Añade una declaración de Bloque de Función."
		
	StdFunctionBlocks at: aFunctionBlockDecl typedIdentifier put: aFunctionBlockDecl.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> addUserFunctionBlock: aFunctionBlockDecl [
	"Añade una declaración de Bloque de Función."
		
	UserFunctionBlocks at: aFunctionBlockDecl typedIdentifier put: aFunctionBlockDecl.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> clearFunctionBlocks [
	"Borra los diccionarios."
		
	self clearStdFunctionBlocks.
	self clearUserFunctionBlocks.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> clearStdFunctionBlocks [
	"Borra el diccionario."
		
	StdFunctionBlocks := Dictionary new.
	
	StdFunctionBlocksCreated := false.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> clearUserFunctionBlocks [
	"Borra el diccionario."
		
	UserFunctionBlocks := Dictionary new.
]

{ #category : #'Std Function Blocks' }
PLC_FunctionBlock class >> createBiestableFunctionBlockDeclarations [
	"Crea y guarda en la biblioteca los bloques de funcion de temporizadores"
	
	"SR"
	self createSRFunctionBlockDeclaration.
	
	"RS"
	self createRSFunctionBlockDeclaration.
]

{ #category : #'Std Counters' }
PLC_FunctionBlock class >> createCTDFunctionBlockDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración del Bloque de Función estándar CTD_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'CTD'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'CD' 
		).	

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'LD' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'PV' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'CV' 
		).
						
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL').
	
	pouDecl pouBody cCode: '
	
		const PLC_INT PVmin = -32768; // Ver esto que esta medio confuso en el estandar,
									  // le puse el minimo de PLC Int
									
	
		// Utilización del FB instancia R_TRIG_IN.
		// Lo que sigue implementa: CAL R_TRIG_IN(CLK:=CD, Q=>CD)
		(pxPOU->R_TRIG_IN).CLK = pxPOU->CD;	// Completo los parametros VAR_INPUT de REDGE
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN) );	// Llamo a la función pasandole la estructura por referencia
		pxPOU->CD = (pxPOU->R_TRIG_IN).Q;	// Grabo los parametros VAR_OUTPUT de REDGE a las variables
													// a las cuales estan igualadas las VAR_OUTPUT de REDGE

		if( pxPOU->LD )
		{
			pxPOU->CV = pxPOU->PV;
		}
		else
		{
			if( pxPOU->CD && (pxPOU->CV > PVmin) )
			{
				(pxPOU->CV)--;
			}
		}
		pxPOU->Q = (pxPOU->CV <= 0);
'.
		
	^ pouDecl.
]

{ #category : #'Std Counters' }
PLC_FunctionBlock class >> createCTUDFunctionBlockDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración del Bloque de Función estándar CTUD_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'CTUD'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'CU' 
		).	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'CD' 
		).	

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'R' 
		).	

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'LD' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'PV' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'QU' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'QD' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'CV' 
		).
						
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN1'
		).
						
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN2'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL').
	
	
	pouDecl pouBody cCode: '

		const PLC_INT PVmax = 32767; // Ver esto que esta medio confuso en el estandar,
									 // le puse el maximo de PLC Int
		const PLC_INT PVmin = -32768; // Ver esto que esta medio confuso en el estandar,
									  // le puse el minimo de PLC Int


		(pxPOU->R_TRIG_IN1).CLK = pxPOU->CU;	
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN1) );	
		pxPOU->CU = (pxPOU->R_TRIG_IN1).Q;	


		(pxPOU->R_TRIG_IN2).CLK = pxPOU->CD;	
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN2) );	
		pxPOU->CD = (pxPOU->R_TRIG_IN2).Q;	

		if( pxPOU->R )
		{
			pxPOU->CV = 0;
		}
		else
		{
			if( pxPOU->LD )
			{
				pxPOU->CV = pxPOU->PV;
			}
			if( !(pxPOU->CU && pxPOU->CD) )
			{
				if( pxPOU->CU && ( pxPOU->CV < PVmax) )
				{
					(pxPOU->CV)++;
				}
				else
				{
					if( pxPOU->CD && ( pxPOU->CV > PVmin) )
					{
						(pxPOU->CV)--;
					}
				}
			}
		}
		pxPOU->QU = (pxPOU->CV >= pxPOU->PV);
		pxPOU->QD = (pxPOU->CV <= 0);
'.
		
	^ pouDecl.
]

{ #category : #'Std Counters' }
PLC_FunctionBlock class >> createCTUFunctionBlockDeclarationWithType: aDataType [
	"Crea y devuelve una Declaración del Bloque de Función estándar CTU_aDataType"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'CTU'
		andDataType: aDataType.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'CU' 
		).	

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'R' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'PV' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: aDataType
			andInitialValue: nil 
			andIdentifier: 'CV' 
		).
						
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL').
	
	pouDecl pouBody cCode: '
	
		const PLC_INT PVmax = 32767;
	
		// Utilización del FB instancia R_TRIG_IN.
		// Lo que sigue implementa: CAL R_TRIG_IN(CLK:=CU, Q=>CU)
		(pxPOU->R_TRIG_IN).CLK = pxPOU->CU;	// Completo los parametros VAR_INPUT de REDGE
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN) );	// Llamo a la función pasandole la estructura por referencia
		pxPOU->CU = (pxPOU->R_TRIG_IN).Q;	// Grabo los parametros VAR_OUTPUT de REDGE a las variables
													// a las cuales estan igualadas las VAR_OUTPUT de REDGE


		if( pxPOU->R )
		{
			pxPOU->CV = 0;
		}
		else
		{
			if( pxPOU->CU && (pxPOU->CV < PVmax) )
			{
				(pxPOU->CV)++;
			}
		}
		pxPOU->Q = (pxPOU->CV >= pxPOU->PV);
		
'.
		
	^ pouDecl.
]

{ #category : #'Std Function Blocks' }
PLC_FunctionBlock class >> createCounterFunctionBlockDeclarations [
	"Crea y guarda en la biblioteca los bloques de funcion Contadores"
	
	"CTU"
	self createCTUFunctionBlockDeclarationWithType: PLC_DataType Int.

	"CTD"
	self createCTDFunctionBlockDeclarationWithType:  PLC_DataType Int.
	
	"CTUD"
	self createCTUDFunctionBlockDeclarationWithType:  PLC_DataType Int.
	
	
]

{ #category : #'Std Function Blocks' }
PLC_FunctionBlock class >> createEdgeFunctionBlockDeclarations [
	"Crea y guarda en la biblioteca los bloques de funcion de temporizadores"
	
	"R_TRIG"
	self createR_TRIGFunctionBlockDeclaration.
	
	"F_TRIG"
	self createF_TRIGFunctionBlockDeclaration.
]

{ #category : #'Std Edge' }
PLC_FunctionBlock class >> createF_TRIGFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar F_TRIG_BOOL"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'F_TRIG'
		andDataType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'CLK' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'M' 
		).	
			
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		pxPOU->Q = !(pxPOU->CLK) && !(pxPOU->M);
		pxPOU->M = !(pxPOU->CLK);
'.
		
	^ pouDecl.
]

{ #category : #'Std Biestable' }
PLC_FunctionBlock class >> createRSFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar RS_BOOL"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'RS'
		andDataType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'S' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'R1' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'Q1' 
		).
			
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		pxPOU->Q1 = !(pxPOU->R1) && ( pxPOU->S || pxPOU->Q1 );
'.
		
	^ pouDecl.
]

{ #category : #'Std Edge' }
PLC_FunctionBlock class >> createR_TRIGFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar R_TRIG_BOOL"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'R_TRIG'
		andDataType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'CLK' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'M' 
		).	
			
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		pxPOU->Q = pxPOU->CLK && !(pxPOU->M);
		pxPOU->M = pxPOU->CLK;
'.
		
	^ pouDecl.
]

{ #category : #'Std Biestable' }
PLC_FunctionBlock class >> createSRFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar SR_BOOL"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'SR'
		andDataType: PLC_DataType Bool.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'S1' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'R' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'Q1' 
		).
			
	"CUERPO DE LA POU"

	pouDecl pouBody: PLC_StandardBody new.
	pouDecl pouBody cCode: '
		pxPOU->Q1 = pxPOU->S1 || ( !(pxPOU->R) && pxPOU->Q1 );
		// Ver si va ~ o ! para negar una variable booleana. Si va ! implementar como las de abajo.
'.
		
	^ pouDecl.
]

{ #category : #'Std Function Blocks' }
PLC_FunctionBlock class >> createStdFunctionBlockDeclarations [
	"Crea y guarda en la biblioteca los bloques de funcion de temporizadores"
	
	"BIESTABLES"
	self createBiestableFunctionBlockDeclarations.
	
	"EDGE DETECTORS"
	self createEdgeFunctionBlockDeclarations.
	
	"TIMERS"
	self createTimerFunctionBlockDeclarations.
	
	"COUNTERS"
	self createCounterFunctionBlockDeclarations.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> createStdFunctionBlocks [
	"Crea los Bloques de Función Estándar."
		
	StdFunctionBlocks := Dictionary new.
	
	self createStdFunctionBlockDeclarations. 
	
	StdFunctionBlocksCreated := true.
]

{ #category : #'Std Timers' }
PLC_FunctionBlock class >> createTOFFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar TOF_Time"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'TOF'
		andDataType: PLC_DataType Time.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	
	
	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'IN' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'PT' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'ET' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'START' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'RUNNING' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'EDGE' 
		).
			
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'F_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'F_TRIG_IN'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'F_TRIG_BOOL').
	
	
	pouDecl pouBody cCode: '
		// Utilización del FB instancia F_TRIG_IN.
		// Lo que sigue implementa: CAL F_TRIG_IN(CLK:=IN, Q=>EDGE)
		(pxPOU->F_TRIG_IN).CLK = pxPOU->IN;		// Completo los parametros VAR_INPUT de FEDGE
		PLC_FB_F_TRIG_BOOL( &(pxPOU->F_TRIG_IN) );	// Llamo a la función pasandole la estructura por referencia
		pxPOU->EDGE = (pxPOU->F_TRIG_IN).Q;	// Grabo los parametros VAR_OUTPUT de FEDGE a las variables
														// a las cuales estan igualadas las VAR_OUTPUT de FEDGE

		// Si la entrada IN es 1 , entonces Q = 1 y ET = 0
		if ( pxPOU->IN ){
			pxPOU->Q = true;
			pxPOU->ET = 0;
		}

		// Si contando == 0 (no esta contando) y hay flanco descendente, arranca a contar
		if ( pxPOU->EDGE && !(pxPOU->RUNNING) ){
			pxPOU->START = xTaskGetTickCount();	// Obtiene el tiempo inicial de ticks
			pxPOU->RUNNING = true; 					// Comienza a contar el tiempo de pulso
		}

		// Si está contando
		if ( pxPOU->RUNNING ){
			pxPOU->ET = xTaskGetTickCount() - pxPOU->START; // Calcula el tiempo transcurrido ET

			// Si ET >= PT entonces termina de contar y satura el valor de ET en PT
			if ( (pxPOU->ET) >= (pxPOU->PT) ){
				pxPOU->ET = pxPOU->PT;			// Satura el valor de ET en PT
				pxPOU->RUNNING = false;			// Deja de Contar
				pxPOU->Q = false; 					// Apaga la salida de pulso
			}
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Timers' }
PLC_FunctionBlock class >> createTONFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar TON_Time"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'TON'
		andDataType: PLC_DataType Time.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'IN' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'PT' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'ET' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'START' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'RUNNING' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'EDGE' 
		).
			
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL').
	
	
	pouDecl pouBody cCode: '
		// Utilización del FB instancia R_TRIG_IN.
		// Lo que sigue implementa: CAL R_TRIG_IN(CLK:=IN, Q=>EDGE)
		(pxPOU->R_TRIG_IN).CLK = pxPOU->IN;	// Completo los parametros VAR_INPUT de REDGE
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN) );	// Llamo a la función pasandole la estructura por referencia
		pxPOU->EDGE = (pxPOU->R_TRIG_IN).Q;	// Grabo los parametros VAR_OUTPUT de REDGE a las variables
													// a las cuales estan igualadas las VAR_OUTPUT de REDGE

		// Si hay flanco ascendente, arranca a contar
		if ( pxPOU->EDGE ){
			pxPOU->START = xTaskGetTickCount();	// Obtiene el tiempo inicial de ticks
			pxPOU->RUNNING = true; 					// Comienza a contar el tiempo de pulso
		}

		// Si está contando
		if ( pxPOU->RUNNING ){
			pxPOU->ET = xTaskGetTickCount() - pxPOU->START; 	// Calcula el tiempo transcurrido ET

			// Si ET >= PT entonces termina de contar y satura el valor de ET en PT
			if ( (pxPOU->ET) >= (pxPOU->PT) ){
				pxPOU->Q = true; 				// Enciende la salida de pulso
				pxPOU->ET = pxPOU->PT;		// Satura el valor de ET en PT
				pxPOU->RUNNING = false;		// Deja de Contar
			}
		}

		// Si la entrada IN es 0 , entonces ET y Q quedan en 0
		if ( !(pxPOU->IN) ){
			pxPOU->ET = 0;				// ET = 0
			pxPOU->Q = false; 				// Apaga la salida de pulso
			pxPOU->RUNNING = false;		// Deja de Contar
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Timers' }
PLC_FunctionBlock class >> createTPFunctionBlockDeclaration [
	"Crea y devuelve una Declaración del Bloque de Función estándar TP_Time"

	| pouDecl |
	
	"DECLARACION DE POU"

	pouDecl := self
		newWithName: 'TP'
		andDataType: PLC_DataType Time.
		
	"Agrego la función a la biblioteca de funciones estándar"		
	self addStdFunctionBlock: pouDecl.
	

	"DECLARACIONES DE VARIABLES DE LA POU"

	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'IN' 
		).	
			
	"Agrego una declaracion de variable de entrada"
	pouDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'PT' 
		).	
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'Q' 
		).
			
	"Agrego una declaracion de variable de salida"
	pouDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'ET' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: pouDecl dataType
			andInitialValue: nil 
			andIdentifier: 'START' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'RUNNING' 
		).
			
	"Agrego una declaracion de variable interna persistente"
	pouDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'EDGE' 
		).
			
	"Agrego una declaracion de variable interna persistente de instancia"
	"( StdFunctionBlocks at: 'R_EDGE_BOOL' ) Obtengo la declaración de REDGE desde la biblioteca"
	pouDecl varDecls add: ( 
		( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL')
			instanceDeclForForFBWithIdentifier: 'R_TRIG_IN'
		).


	"CUERPO DE LA POU"

	"Es un cuerpo estandar"
	pouDecl pouBody: PLC_StandardBody new.
	
	"Agrego la POU que llama esta pou estandar en su interior"
	pouDecl pouBody calledPOUs: ( PLC_FunctionBlock StdFunctionBlocks at: 'R_TRIG_BOOL').
	
	pouDecl pouBody cCode: '
		// Utilización del FB instancia R_TRIG_IN.
		// Lo que sigue implementa: CAL R_TRIG_IN(CLK:=IN, Q=>EDGE)
		(pxPOU->R_TRIG_IN).CLK = pxPOU->IN;	// Completo los parametros VAR_INPUT de REDGE
		PLC_FB_R_TRIG_BOOL( &(pxPOU->R_TRIG_IN) );	// Llamo a la función pasandole la estructura por referencia
		pxPOU->EDGE = (pxPOU->R_TRIG_IN).Q;	// Grabo los parametros VAR_OUTPUT de REDGE a las variables
													// a las cuales estan igualadas las VAR_OUTPUT de REDGE

		// Si contando == 0 (no esta contando) y hay flanco ascendente, arranca a contar
		if ( pxPOU->EDGE && !(pxPOU->RUNNING) ){
			pxPOU->START = xTaskGetTickCount();	// Obtiene el tiempo inicial de ticks
			pxPOU->RUNNING = true; 				// Comienza a contar el tiempo de pulso
			pxPOU->Q = true; 					// Enciende la salida de pulso
		}

		// Si está contando
		if ( pxPOU->RUNNING ){
			pxPOU->ET = xTaskGetTickCount() - pxPOU->START; 	// Calcula el tiempo transcurrido ET = t1 - t0

			// Si ET >= PT entonces termina de contar y satura el valor de ET en PT
			if ( pxPOU->ET >= pxPOU->PT ){
				pxPOU->Q = false;				// Apaga la salida de pulso
				pxPOU->ET = pxPOU->PT;			// Satura el valor de ET en PT
				pxPOU->RUNNING = false;			// Deja de contar
			}
		}

		// Si la entrada IN es 0 y No está contando
		if ( !(pxPOU->IN) && !(pxPOU->RUNNING) ){
			pxPOU->ET = 0;
		}
'.
		
	^ pouDecl.
]

{ #category : #'Std Function Blocks' }
PLC_FunctionBlock class >> createTimerFunctionBlockDeclarations [
	"Crea y guarda en la biblioteca los bloques de funcion de temporizadores"
	
	"TP"
	self createTPFunctionBlockDeclaration.
	
	"TON"
	self createTONFunctionBlockDeclaration.
	
	"TOF"
	self createTOFFunctionBlockDeclaration.
]

{ #category : #'class initialization' }
PLC_FunctionBlock class >> initialize [ 
	"comment stating purpose of message"

	super initialize.
	StdFunctionBlocksCreated := false.
]

{ #category : #'instance creation' }
PLC_FunctionBlock class >> newWithName: anIdentifier andDataType: aPLC_DataType [
	"Nuevo con nombre y tipo de datos"

	| pou |
	
	pou := self newWithName: anIdentifier.
		
	pou dataType: aPLC_DataType.
		
	^ pou.
]

{ #category : #compilation }
PLC_FunctionBlock >> cCompile [
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
	self declarations constantVarDecls cCompile ,
	self declarations tempVarDecls cCompile.
	
	
	"ACA FALTA QUE EN FUNCTION PISE CONCERO A LAS VAR INTERNAS PARAQUENOTENGA MEMORIA"
	
	cCode := cCode , '
	
		// Cuerpo de POU
		
',	progAcc compiledBody cCompile.
	
	
	cCode := cCode, '	
	}'.
	
	^ cCode.
]

{ #category : #compilation }
PLC_FunctionBlock >> ilCompile [
	"Definición de POU en IL.
	
	Ejemplo:

	FUNCTION_BLOCK FBej
	
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
			
	END_FUNCTION_BLOCK
	
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
	self declarations tempVarDecls ilCompile .
	
	ilCode := ilCode , '
	
		 (* Cuerpo de POU *)
		
',	progAcc compiledBody ilCompile.
	
	
	ilCode := ilCode, '
			
	END_' , self pouType.
	
	^ ilCode.
]

{ #category : #'initialize-release' }
PLC_FunctionBlock >> initialize [.
	"Inicializo la declaración de Bloque de Función."

	super initialize.

	"Declaraciones de Variables y Tipos de Datos"
	self declarations: ( PLC_POU_Declarations functionBlockDeclarationsWithPOUDeclaration: self ).
]

{ #category : #'POU type' }
PLC_FunctionBlock >> pouType [
	"Devuelve el tipo de POU que es."

	^ 'FUNCTION_BLOCK'
]

{ #category : #'POU type' }
PLC_FunctionBlock >> pouTypeAcronym [
	"Devuelve las siglas del tipo de POU que es."

	^ 'FB'
]

{ #category : #'variable declarations' }
PLC_FunctionBlock >> tempVarDecls [
	"Devuelve sus declaraciones de variables Internas Temporales"

	^ self declarations tempVarDecls.
]
