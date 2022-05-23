"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_CyclicTaskConfiguration is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_CyclicTaskConfiguration',
	#superclass : #'PLC_TaskConfiguration',
	#category : #'IDE4PLC-Project'
}

{ #category : #compilation }
PLC_CyclicTaskConfiguration >> cCompile [
	"Devuelve la definicion de función de Tarea de freeRTOS en lenguaje C.
	Es la tarea cíclica del Sistema que ejecuta todos los programas sin asociación
	con Tareas."
		
	| task |
	
	task := '
	
/*---------------------------------------------------------------------------------------------------------*/

void vPLeriCScanCycleTask(void *pvParameters)
{
	
	/* DECLARACIONES DE INSTANCIAS DE LOS PROGRAMAS ASOCIADOS A LA TAREA */
	
	'.

	"Declaraciones de variables de instancia de Programa sin valor inicial"
	 self programConfigurations do: [ :each |
		task := task , each instanceOperand declaration cCompileWithoutInitialValue , '
		
	'.
		 ].
	
	task := task , '
	/* Cada tarea del S.O. freeRTOS contiene un bucle infinito */
	
	for( ;; )
	{
	
		/* Lectura de las entradas físicas */
		entradas = Read_IN();
		I0 = Convert_Uint8_t_2_PLC_1ByteRegister(entradas);
		
		
		/* LLAMADOS A PROGRAMAS ASOCIADOS A LA TAREA PLC */
		
' .
		
	"Llamados a Programa compilados a C"
	 self programConfigurations do: [ :each |
		task := task , each cCompile , '
		
'.
		 ].
		
	task := task , 	
		'		/* Escritura de salidas físicas */
		salidas = Convert_PLC_1ByteRegister_2_Uint8_t( Q0 );
		Write_OUT(salidas);
		
	}
}
'.
			
			
	^ task.
		
	
]

{ #category : #compilation }
PLC_CyclicTaskConfiguration >> cCompilePrototype [
	"Devuelve la definicion de función de Tarea de freeRTOS en lenguaje C.
	Es la tarea cíclica del Sistema que ejecuta todos los programas sin asociación
	con Tareas."
			
	^ '
	
	void vPLeriCScanCycleTask(void *);'.
]

{ #category : #compilation }
PLC_CyclicTaskConfiguration >> cTaskCreate [
	"Devuelve la definicion de función de Tarea de freeRTOS en lenguaje C.
	Es la tarea cíclica del Sistema que ejecuta todos los programas sin asociación
	con Tareas."
	"Tiene prioridad 0. En freeRTOS es la menor prioridad."
		
	^ '
	
	/* Crea una instancia de Tarea ciclica PLeriC Scan cycle. */
	xTaskCreate( vPLeriCScanCycleTask, "PLeriC Scan cycle", 512, NULL, 0, NULL );'.
]

{ #category : #compilation }
PLC_CyclicTaskConfiguration >> ilCompile [
	"La tarea ciclica del sistema no genera codigo IL."
	
	^ ''.

	
]

{ #category : #compilation }
PLC_CyclicTaskConfiguration >> taskCPriority [
	"Devuelve el valor de prioridad de la Tarea c como String."
	"Tiene prioridad 0. En freeRTOS es la menor prioridad."
	
	^ '0'.
]
