"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CAL_Instruction is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CAL_Instruction',
	#superclass : #'PLC_IL_Instruction',
	#category : #'IDE4PLC-Elements-IL'
}

{ #category : #compilation }
PLC_CAL_Instruction >> ilCompile [
	"Compila el elemento IL Instruccion CAL (llamado a Bloque de Función) a IL

	Devuelve:
	
		CAL FB_InstanceName ( 
			inputAssignment , 
			inOutAssignment , 
			outputAssignment , 
			) 
	
	Por ejemplo:
	
		CAL CMD_TMR ( 
			IN :=  ENT1 , 
			PT := T#300ms ,
			ENO => ERR , 
			Q => OUT , 
			ET => ELAPSED , 
			) 
	"
	
	| pouCall |

	pouCall := 'CAL	' , self instanceName , ' ( '.
	
	self inputAssignments do: [ :each |
		pouCall := pouCall , '
		' , each ilCompile , ','.
		].	
			
	self inOutAssignments do: [ :each |
		pouCall := pouCall , '
		' , each ilCompile , ','.
		].	
			
	self outputAssignments do: [ :each |
		pouCall := pouCall , '
		' , each ilCompile , ','.
		].	

	pouCall := pouCall , '
		)'.
	
	^ pouCall.
]
