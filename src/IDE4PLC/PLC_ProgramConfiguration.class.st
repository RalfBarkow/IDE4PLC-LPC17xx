"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_ProgramConfiguration is xxxxxxxxx.

Instance Variables
	task:		<Object>

task
	- xxxxx

"
Class {
	#name : #'PLC_ProgramConfiguration',
	#superclass : #'PLC_TextualPOUCall',
	#instVars : [
		'task'
	],
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #compilation }
PLC_ProgramConfiguration >> cCompile [
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
		'( &',
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
		
	cCode := cCode , '

'.
			
	^ cCode.
		
	
]

{ #category : #compilation }
PLC_ProgramConfiguration >> ilCompile [
	"Compila el elemento IL Configuración de Programa a IL.
	Este elemento IL es una instanciación y llamado a la vez de 
	una POU Programa.

	Devuelve (sin asociación con Tarea. Es la Tarea FreeRTOS de menor prioridad):
	
		PROGRAM ProgramInstanceName : ProgramName ( 
			inputAssignment , 
			inOutAssignment , 
			outputAssignment 
			) ;
	
	Por ejemplo:
	
		PROGRAM G : GRAVEL ( 
			IN :=  ENT1 , 
			PT := T#300ms ,
			ENO => ERR , 
			Q => OUT , 
			ET => ELAPSED 
			) ;
			
			
	Devuelve (con asociación con Tarea):
	
		PROGRAM ProgramInstanceName WITH TaskName : ProgramName ( 
			inputAssignment , 
			outputAssignment , 
			inOutAssignment 
			) ;
	
	Por ejemplo:
	
		PROGRAM G WITH TAREA1 : GRAVEL ( 
			IN :=  ENT1 , 
			PT := T#300ms ,
			ENO => ERR , 
			Q => OUT , 
			ET => ELAPSED 
			) ;
			
	"
	
	| pouCall |

	pouCall := '			PROGRAM ' , 
		self pouName , ' ' ,
		self withTaskName , 
		' : ' , 
		self instanceName , ' ( '.
	
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
		
	"Borro la última coma de más"	
	pouCall := pouCall copyFrom: 1 to: ( pouCall size ) - 1.	

	pouCall := pouCall , '
				) ;'.
	
	^ pouCall.
		
	
]

{ #category : #accessing }
PLC_ProgramConfiguration >> task [
	
	^ task
]

{ #category : #accessing }
PLC_ProgramConfiguration >> task: anObject [
	
	task := anObject
]

{ #category : #accessing }
PLC_ProgramConfiguration >> taskName [
	
	^ self task taskName
]

{ #category : #compilation }
PLC_ProgramConfiguration >> withTaskName [
	"Devuelve el nombre de la Tarea anteponiendo WITH"
	
	self task 
		ifNil: [ 
			^ ''.
			 ] 
		ifNotNil: [
			^ 'WITH ' , self taskName.
			].
]
