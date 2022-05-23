"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_Resource is xxxxxxxxx.

Instance Variables
	declarations:		<Object>
	processor:		<Object>
	programConfigurations:		<Object>
	softwareConfiguration:		<Object>
	taskConfigurations:		<Object>

declarations
	- xxxxx

processor
	- xxxxx

programConfigurations
	- xxxxx

softwareConfiguration
	- xxxxx

taskConfigurations
	- xxxxx

"
Class {
	#name : #'PLC_Resource',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'softwareConfiguration',
		'processor',
		'taskConfigurations',
		'programConfigurations',
		'declarations'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_Resource class >> newWithName: aString andSoftConfig: aSoftConfig andProcessor: aProcessor [
	"Crea una nueva isntancia con el nombre indicado"

	| res |
	
	res := self new.
	res resourceName: aString.
	res softwareConfiguration: aSoftConfig.
	res processor: aProcessor.
	
	^ res.
]

{ #category : #'program and task configurations' }
PLC_Resource >> addProgConfig: aProgConfig [
	"Añade al Recurso la Configuración de Programa aProgConfig que le llega como parámetro"

	self programConfigurations add: aProgConfig.
	
	^ aProgConfig.
]

{ #category : #'program and task configurations' }
PLC_Resource >> addTaskConfig: aTaskConfig [
	"Añade al Recurso la Configuración de Tarea aTaskConfig que le llega como parámetro"

	self taskConfigurations add: aTaskConfig.
	
	aTaskConfig resource: self.
	
	^ aTaskConfig.
]

{ #category : #compilation }
PLC_Resource >> cComplie [
	"Devuelve un String con el Recurso Compilado a código C."

	^ 'Recurso compliado en C.'
]

{ #category : #compilation }
PLC_Resource >> cMainC [
	" Devuelve un String con el Código C que va en el archivo main.c "

	| cCode |
	
	cCode := '/*
 * main.c
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

// Todos los inlcudes juntos
#include "PLeriC.h"

/*-----------------------------------------------------------*/

int main( void )
{

	extern PLC_SymbolicRegister CR;

	// Se inicializa el Current Result (CR) con el tipo Booleano a true;
	CR.TYPE = BOOL;
	CR.VALUE.BOOL = true;

	// Se inicializa las E/S del Hardware - IMPORTANTE SINO NO ANDA NADA
	IO_init();

	/* CREACION DE INSTANCIAS DE TAREAS */'.
	
	self taskConfigurations do: [ :each |
		cCode := cCode , each cTaskCreate.
		].
	
	cCode := cCode , '

	
	/* INICIO DEL PLANIFICADOR
	Se inicia el Planificador para que las tareas comiencen a ejecutarse. */
	
	vTaskStartScheduler();

	/* Si todo va bien nunca se llegará aquí ya que el planificador estará 
	corriendo. Si se ha llegado, entonces es probable que no haya 
	suficiente memoria disponible en el heap para crear la tarea Idle. */
	for( ;; );
	return 0;
}

/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook( void )
{
	/* This function will only be called if an API call to create a task, queue
	or semaphore fails because there is too little heap RAM remaining. */
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook( xTaskHandle *pxTask, signed char *pcTaskName )
{
	/* This function will only be called if a task overflows its stack.  Note
	that stack overflow checking does slow down the context switch
	implementation. */
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook( void )
{
	/* This example does not use the idle hook to perform any processing. */
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
	/* This example does not use the tick hook to perform any processing. */
}'.

	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cStandardFunctionBlocksC [
	" Devuelve un String con el Código C que va en el archivo PLC_StdFunctionBlocks.c "

	| cCode |
	
	cCode := '/*
 * PLC_StdFunctionBlocks.c
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* Includes */

#include "PLeriC.h"

/* PLC Standard Functions - Functions Declarations */

/* Los FB se implementan como funciones de C que no retornan valores
 * y que reciben como parametro un puntero a la estructura de la
 * FB instancia, que debe ser declarada como STATIC en la funcion
 * contenedora.
*/

'.
	
	self calledPOUs standardFunctionBlocks do: [ :each |
		cCode := cCode , each cCompile.
		].
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cStandardFunctionBlocksH [
	" Devuelve un String con el Código C que va en el archivo PLC_StdFunctionBlocks.h "

	| cCode |
	
	cCode := '/*
 * PLC_StdFunctionBlocks.h
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* En este archivo se guardan los prototipos de funciones
 * en C de los Bloques de Funcion (FUNCTION_BLOCK) del 
 * PLC estandar y los tipos de datos para sus instaniancias */

#ifndef PLC_STDFB_H_
	#define PLC_STDFB_H_
	
	/* Declaraciones de typedef de estructura con las variables de los Bloques de Funcion  */

'.
	
	self calledPOUs standardFunctionBlocks do: [ :each |
		cCode := cCode , each typeDeclaration cCompile , '
'.
		].
	
	cCode := cCode , '	/* Prototipos de Funciones en C que implementan los Bloques de Funcion  */
'.
	
	self calledPOUs standardFunctionBlocks do: [ :each |
		cCode := cCode , each cCompilePrototype.
		].
	
	cCode := cCode , '
	
#endif /* PLC_STDFB_H_ */'.
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cStandardFunctionsC [
	" Devuelve un String con el Código C que va en el archivo PLC_StdFunctions.c "

	| cCode |
	
	cCode := '/*
 * PLC_StdFunctions.c
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* Includes */

#include "PLeriC.h"

/* PLC Standard Functions - Functions Declarations */

/* Las F se implementan como funciones de C que no retornan valores
 * y que reciben como parametro un puntero a la estructura de la
 * F, esta variable estructura del tipo de la funcion es unica por
 * no como el caso de los FB que tienen una variable de su tipo de
 * estructura por  instancia.
*/


/*-------------------------------------------------------------*/

// MOVE SOBRECARGADA
void PLC_F_MOVE(void* sourceValue, void* destinationValue, uint16_t lenght)
{
	// sourceValue y destinationValue DEBEN SER DEL MISMO TIPO
	// VOLCADO DE MEMORIA
	PLC_BYTE *source;
	PLC_BYTE *destination;
	uint16_t i = 0;

	source = sourceValue;
	destination = destinationValue;

	for( i = 0; i < lenght; i++ )
	{
		*destination = *source;
		destination++;
		source++;
	}
}
/*-------------------------------------------------------------*/

'.
	
	self calledPOUs standardFunctions do: [ :each |
		cCode := cCode , each cCompile.
		].
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cStandardFunctionsH [
	" Devuelve un String con el Código C que va en el archivo PLC_StdFunctions.h "

	| cCode |
	
	cCode := '/*
 * PLC_StdFunctions.h
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* En este archivo se guardan los prototipos de funciones
 * en C de las Funciones (FUNCTION) del PLC estandar y
 * los tipos de datos para sus instaniancias */

#ifndef PLC_STDF_H_
	#define PLC_STDF_H_
	
	/* Declaraciones de typedef de estructura con las variables de las Funciones */

'.
	
	self calledPOUs standardFunctions do: [ :each |
		cCode := cCode , each typeDeclaration cCompile , '
'.
		].
	
	cCode := cCode , '	/* Prototipos de Funciones en C que implementan las Funciones */
'.
	
	self calledPOUs standardFunctions do: [ :each |
		cCode := cCode , each cCompilePrototype.
		].
	
	cCode := cCode , '
	
#endif /* PLC_STDF_H_ */'.
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cUserProgramsC [
	" Devuelve un String con el Código C que va en el archivo PLC_UserPrograms.c "

	| cCode |
	
	cCode := '/*
 * PLC_UserPrograms.c
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* Includes */

#include "PLeriC.h"

/* En este archivo se guardan las definiciones de funciones
 * en C de los Programas (PROGRAM) del PLC creadas por
 * el usuario */

'.
	
	self calledPOUs userPrograms do: [ :each |
		cCode := cCode , each cCompile.
		].
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cUserProgramsH [
	" Devuelve un String con el Código C que va en el archivo PLC_UserPrograms.h "

	| cCode |
	
	cCode := '/*
 * PLC_UserPrograms.h
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* En este archivo se guardan los prototipos de funciones
 * en C de los Programas (PROGRAM) del PLC creadas por
 * el usuario y los tipos de datos para sus instaniancias  */

#ifndef PLC_USER_PROGRAMS_H_
	#define PLC_USER_PROGRAMS_H_

	/* Declaraciones de typedef de estructura con las variables del Programa */

'.
	
	self calledPOUs userPrograms do: [ :each |
		cCode := cCode , each typeDeclaration cCompile , '
'.
		].
	
	cCode := cCode , '	/* Prototipos de Funciones en C que implementan los Programas */
'.
	
	self calledPOUs userPrograms do: [ :each |
		cCode := cCode , each cCompilePrototype.
		].
	
	cCode := cCode , '
	
#endif /* PLC_USER_PROGRAMS_H_ */'.
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cUserTasksC [
	" Devuelve un String con el Código C que va en el archivo PLC_UserTasks.c "

	| cCode |
	
	cCode := '/*
 * PLC_UserTasks.c
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* En este archivo se guardan las declaraciones de funciones
 * en C de las Tareas (TASK) del PLC creadas por el usuario.
 * Estas se implementan como funciones periódicas de FreeRtos
 * con un mutex cada una.*/

/* Includes */

#include "PLeriC.h"

	/* Las entradas y salidas fisicas del PLC son variables Globales públicas del tipo volatile */

	volatile uint8_t entradas;
	volatile uint8_t salidas;

	/* Registros de I/O y Memoria como variables globales públicas */

	PLC_1ByteRegister  I0;
	PLC_1ByteRegister  Q0;
	PLC_1KByteRegister M0;

	extern PLC_SymbolicRegister CR;
	
	/* Declaraciones de variables simbólicas localizadas */'.


	"--------------------------------------------------------------------------------------------------------------
	ACA AGREGAR LA COMPILACION DE LAS VARIABLES SIMBOLICAS LOCATED
	------------------------------------------------------------------------------------------------------------------"
	
	cCode := cCode , 
	'	/* Definiciones de funciones de tareas de freeRTOS que implementan las Tareas del PLC. */

'.
	
	self taskConfigurations do: [ :each |
		cCode := cCode , each cCompile.
		].
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> cUserTasksH [
	" Devuelve un String con el Código C que va en el archivo PLC_UserTasks.h "

	| cCode |
	
	cCode := '/*
 * PLC_UserTasks.h
 *
 *  Created on: 2012-02-04
 *      Author: Eric N. Pernia
 *
 * Archivo generado desde Pharo-Smalltalk 
 *
 */

/* En este archivo se guardan los prototipos de funciones
 * en C de las Tareas (TASK) del PLC creadas por el usuario.
 * Estas se implementan como funciones periódicas de FreeRtos
 * con un mutex cada una.*/

#ifndef PLC_USER_TASKS_H_
	#define PLC_USER_TASKS_H_

	/* Prototipos de funciones de tareas de freeRTOS que implementan las Tareas del PLC. */'.
	
	self taskConfigurations do: [ :each |
		cCode := cCode , each cCompilePrototype.
		].
	
	cCode := cCode , '
	
#endif /* PLC_USER_TASKS_H_ */'.
	
	^ cCode.

]

{ #category : #compilation }
PLC_Resource >> calledPOUs [
	"Devuelve un Set con las POU que llama cada Configuración de Programa del Recurso 
	y las declaraciones de programas de cada Configuración de Programa."

	| pouDecls |
	
	pouDecls := PLC_CalledPOU new.
	
	"Le paso una OC de llamados a programas"
	pouDecls addUserPrograms: self programConfigurations.
	
	"Le pido a cada declaracion de programa que usa cada 
	configuración de programa que agregue sus pou F y FB 
	que llame en su cuerpo"
	self programConfigurations do: [ :progConfig |
		progConfig declaration addCalledPOUsIn: pouDecls.
		 ].	

	^ pouDecls.
]

{ #category : #accessing }
PLC_Resource >> declarations [
	
	^ declarations
]

{ #category : #accessing }
PLC_Resource >> declarations: anObject [
	
	declarations := anObject
]

{ #category : #declarations }
PLC_Resource >> externVarDecls [
	"Devuelve sis declaraciones de variables globales"

	^ self declarations externVarDecls.
]

{ #category : #declarations }
PLC_Resource >> globalVarDecls [
	"Devuelve sis declaraciones de variables globales"

	^ self declarations globalVarDecls.
]

{ #category : #compilation }
PLC_Resource >> ilCompile [
	"Devuelve un String con el Recurso Compilado a código IL."

	| res |
	
	res := '
	
		RESOURCE ' 
	, self resourceName 
	, ' ON ' 
	, self processor identifier
	, '
	
			(* Declaraciones de Recurso *)

'.
	self globalVarDecls
		ifNotNil: [ 
			res := res ,
			self globalVarDecls ilCompile , '
'.
			].
		
	self externVarDecls
		ifNotNil: [ 
			res := res ,
			self externVarDecls ilCompile , '
'.
			].

	res := res ,'			(* Configuraciones de Tarea *)
' .


	self taskConfigurations
		ifNotNil: [ 
			self taskConfigurations do: [ :each | 
				res := res , each ilCompile , '
'.
				].
			].

	res := res ,'		
			
			(* Configuraciones de Programa *)
			
'.

	self programConfigurations
		ifNotNil: [ 
			self programConfigurations do: [ :each | 
				res := res , each ilCompile , '
'.
				].
			].

	res := res ,'			
		END_RESOURCE'.
		
	^ res.
	
]

{ #category : #'initialize-release' }
PLC_Resource >> initialize [
	"Inicializaciones de Recurso"

	taskConfigurations := OrderedCollection new.
	programConfigurations := OrderedCollection new.
	
	declarations := PLC_Resource_Declarations newWithResourceDeclaration: self.
	
	self addTaskConfig: (
		PLC_CyclicTaskConfiguration 
			newWithName: 'PLeriCScanCycle'
		).
]

{ #category : #accessing }
PLC_Resource >> processor [
	
	^ processor
]

{ #category : #accessing }
PLC_Resource >> processor: anObject [
	
	processor := anObject
]

{ #category : #accessing }
PLC_Resource >> programConfigurations [
	
	^ programConfigurations
]

{ #category : #accessing }
PLC_Resource >> programConfigurations: anObject [
	
	programConfigurations := anObject
]

{ #category : #'program and task configurations' }
PLC_Resource >> removeProgConfig: aProgConfig [
	"Remueve del Recurso la Configuración de Programa que le llega como parámetro"

	self programConfigurations remove: aProgConfig.

	^ aProgConfig.
]

{ #category : #'program and task configurations' }
PLC_Resource >> removeTaskConfig: aTaskConfig [
	"Remueve del Recurso la Configuración de Tarea que le llega como parámetro"

	self taskConfigurations remove: aTaskConfig.
	
	aTaskConfig resource: nil.

	^ aTaskConfig.
]

{ #category : #accessing }
PLC_Resource >> resourceName [
	
	^ identifier
]

{ #category : #accessing }
PLC_Resource >> resourceName: anObject [
	
	identifier := anObject
]

{ #category : #accessing }
PLC_Resource >> softwareConfiguration [
	
	^ softwareConfiguration
]

{ #category : #accessing }
PLC_Resource >> softwareConfiguration: anObject [
	
	softwareConfiguration := anObject
]

{ #category : #accessing }
PLC_Resource >> taskConfigurations [
	
	^ taskConfigurations
]

{ #category : #accessing }
PLC_Resource >> taskConfigurations: anObject [
	
	taskConfigurations := anObject
]
