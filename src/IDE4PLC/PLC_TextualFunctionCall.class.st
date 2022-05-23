"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_TextualFunctionCall is xxxxxxxxx.

Instance Variables
	returnAssignment:		<Object>

returnAssignment
	- xxxxx

"
Class {
	#name : #'PLC_TextualFunctionCall',
	#superclass : #'PLC_TextualPOUCall',
	#instVars : [
		'returnAssignment'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #'instance creation' }
PLC_TextualFunctionCall class >> newFromDeclaration: pouDeclaration andInstanceOperand: inst [
	"Crea un nuevo llamado IL a partir de la declaración pouDeclaration."

	| pouCall |
	
	pouCall := self new.	

	pouCall declaration: pouDeclaration.
	pouCall instanceOperand: inst.

	pouDeclaration inputVarDecls do: [ :each | 
		pouCall inputAssignments add: 
			( PLC_InputAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].

	pouDeclaration inOutVarDecls do: [ :each | 
		pouCall inOutAssignments add: 
			( PLC_InOutAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].

	pouDeclaration outputVarDecls do: [ :each | 
		pouCall outputAssignments add: 
			( PLC_OutputAssignment
				newWithFormalParameter: each
				andActtualArgument: PLC_VoidOpenad new
				andPouCall: pouCall
			).
		].

	pouCall returnAssignment: ( 
		PLC_OutputAssignment
			newWithFormalParameter: pouDeclaration return
			andActtualArgument: PLC_VoidOpenad new
			andPouCall: pouCall
		).
	
	^ pouCall.
]

{ #category : #compilation }
PLC_TextualFunctionCall >> cCompile [
	"Compila el elemento IL llamado a función a lenguaje C.

	Devuelve:
	
		inputAssignment;
		inOutAssignment;

		cPOUName( &instanceName ); 
			
		outputAssignment; 
	
	Por ejemplo:
	
		// Cargo los parametros VAR_INPUT y VAR_IN_OUT del 
		// CTU_INT contador1 con sus variables conectadas
		// en su estructura.
		
		contador1.CU = varBool1 ;
		contador1.R = varBool2 ;
		contador1.PV = varInt1 ;
						
		// Llamo a la función pasandole la estructura por referencia
		
		PLC_FB_CTU_INT( &contador1 );	
						
		// Cargo las variables conectadas con los parametros VAR_OUTPUT del CTU_INT contador1
		// de en su estructura.
	
		varBool3 = contador1.Q;	
		varInt2 = contador1.CV;	

	"
	
	| cCode |
	
	cCode := '
	
		'.

	self inputAssignments do: [ :each |
		( each cCompile ~= '' )
			ifTrue: [ 
				cCode := cCode , '
		' , each cCompile , ';'.
				].
		].	
		
	self inOutAssignments do: [ :each |
		( each cCompile ~= '' )
			ifTrue: [ 
				cCode := cCode , '
		' , each cCompile , ';'.
				].
		].	

	cCode := cCode , '
	
		' , self cPOUName , 
		'( &pxPOU->',
		 self instanceName ,
		 ' );		
		'.
			
	self outputAssignments do: [ :each |
		( each cCompile ~= '' )
			ifTrue: [ 
				cCode := cCode , '
		' , each cCompile , ';'.
				].
		].
	
	( self returnAssignment cCompile ~= '' )
		ifTrue: [ 
			cCode := cCode , '
		' , self returnAssignment cCompile , ';'.
			].
			
	cCode := cCode , '

'.
			
	^ cCode.
		
	
]

{ #category : #compilation }
PLC_TextualFunctionCall >> ilCompile [
	"Compila el elemento IL llamado a función a lenguaje C.
	
	Devuelve:
	
		functionName ( 
			inputAssignment , 
			inOutAssignment , 
			outputAssignment , 
			) 
	
	Por ejemplo:
	
		ADD_INT ( 
			EN := CR , 
			IN1 := 10 ,
			IN2 := 2 , 
			ENO => FLUX , 
			) 
	
	Nota: el RetVal se asigna al Current Result de la forma
	
	RetVal => CR.tipoDeRetValDeLaF
		
	"
	
	| pouCall |

	pouCall := '
	
' , self pouName , '( '.
	
	self inputAssignments do: [ :each |
		( each ilCompile ~= '' )
			ifTrue: [ 
				pouCall := pouCall , '
				' , each ilCompile , ','.
				].
		].		
	
	self inOutAssignments do: [ :each |
		( each ilCompile ~= '' )
			ifTrue: [ 
				pouCall := pouCall , '
				' , each ilCompile , ','.
				].
		].		
	
	self outputAssignments do: [ :each |
		( each ilCompile ~= '' )
			ifTrue: [ 
				pouCall := pouCall , '
				' , each ilCompile , ','.
				].
		].		

	pouCall := pouCall , '
		)
'.
	
	^ pouCall.
		
	
]

{ #category : #accessing }
PLC_TextualFunctionCall >> returnAssignment [
	
	^ returnAssignment
]

{ #category : #accessing }
PLC_TextualFunctionCall >> returnAssignment: anObject [
	
	returnAssignment := anObject
]
