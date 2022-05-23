"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_TaskConfiguration is xxxxxxxxx.

Instance Variables
	inputAssignments:		<Object>
	inputDecls:		<Object>
	programConfigurations:		<Object>
	resource:		<Object>

inputAssignments
	- xxxxx

inputDecls
	- xxxxx

programConfigurations
	- xxxxx

resource
	- xxxxx

"
Class {
	#name : #'PLC_TaskConfiguration',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'inputDecls',
		'inputAssignments',
		'programConfigurations',
		'resource'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_TaskConfiguration class >> newWithName: aTaskName [
	"Crea una nueva Configuracción de Tarea con nombre aTaskName."

	| taskConfig |
	
	taskConfig := self new.
	
	taskConfig taskName: aTaskName.

	^ taskConfig.
]

{ #category : #'program configurations' }
PLC_TaskConfiguration >> addProgConfig: aProgConfig [
	"Añade a la Tarea la Configuración de programa aProgConfig que le llega como parámetro"

	| set |
	
	"Con el set evito que una tarea tenga configuraciones de programas repetidas"
	set := self programConfigurations asSet.
	set add: aProgConfig.
	self programConfigurations: set asOrderedCollection.
	
	aProgConfig task: self.
	
	^ aProgConfig.
]

{ #category : #compilation }
PLC_TaskConfiguration >> cCompile [
	"Devuelve la definicion de función de Tarea de freeRTOS en lenguaje C.
	
	Ejemplo:

/*-----------------------------------------------------------*/

void vPeriodicTask_TareaEj(void *pvParameters)
{
	portTickType xLastWakeTime;

	/* La variable xLastWakeTime necesita ser inicializada con el conteo actual
	de ticks. Nótese que este es el único momento que se accede a esta variable.
	De aquí en adelante xLastWakeTime es manejada automáticamente por la función
	API vTaskDelayUntil(). */
	xLastWakeTime = xTaskGetTickCount(); 
	// xTaskGetTickCount() es la función API del S.O.  
	// freeRTOS para obtener el conteo de Ticks del Sistema.
	
	/* DECLARACIÓN DE INSTANCIAS DE LOS PROGRAMAS ASOCIADOS
	PLC_P_Struct_ProgEj es un tipo de datos estructurado
	que contiene todas las declaraciones de variables de
	ProgEj como miembros */
	PLC_P_Struct_ProgEj ProgEj_Instance;

	/* Cada tarea del S.O. contiene un bucle infinito */
	for( ;; )
	{
	
		/* Leo las entradas físicas */
		entradas = Read_IN();
		/* Convierto de Uint8_t a campo de bits*/
		I = Convert_Uint8_t_2_PLC_1ByteRegister(entradas);
		
		
		/* LLAMADOS A PROGRAMAS ASOCIADOS A LA TAREA PLC */
		
		// Lectura de parámetros de entrada
		ProgEj_Instance.Ent1 = I0.b0;
		ProgEj_Instance.Ent2 = I0.b1;
		
		// Llamo al Programa
		ProgEj(&ProgEj_Instance);
		
		// Escritura de parámetros de salida
		Q0.b0 = ProgEj_Instance.Sal;
		
		
		/* Escritura de salidas físicas */
		salidas = Convert_PLC_Digital_PORT_8_2_Uint8_t(Q0);
		Write_OUT(salidas);
		
		
		/* Trarea periódica cada 20ms utilizando la API 
		del S.O. freeRTOS de Dealay Periódico. 
		Se pone el parámetro en ms / portTICK_RATE_MS. */
		vTaskDelayUntil(&xLastWakeTime, (20/portTICK_RATE_MS));
		
	}
}

"
	
	| task |
	
	task := '
	
/*---------------------------------------------------------------------------------------------------------*/

void vPeriodicTask_'

, self taskName

,'(void *pvParameters)
{
	portTickType xLastWakeTime;

	/* La variable xLastWakeTime necesita ser inicializada con el conteo actual
	de ticks. Nótese que este es el único momento que se accede a esta variable.
	De aquí en adelante xLastWakeTime es manejada automáticamente por la función
	API vTaskDelayUntil(). */
	xLastWakeTime = xTaskGetTickCount(); 
	/* xTaskGetTickCount() es la función API del S.O. freeRTOS para obtener el conteo 
	de Ticks del Sistema.*/
	
	/* DECLARACIONES DE INSTANCIAS DE LOS PROGRAMAS ASOCIADOS A LA TAREA */
	
	'.

	"Declaraciones de variables de instancia de Programa sin valor inicial"
	 self programConfigurations do: [ :each |
		task := task , each instanceOperand declaration cCompileWithoutInitialValue , ';
		
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
		
		
		/* Trarea periódica cada Xms utilizando la API del S.O. freeRTOS de Dealay 
		Periódico. Se pone el parámetro en ms / portTICK_RATE_MS. */
		vTaskDelayUntil( &xLastWakeTime, ( '
		
	, self taskCInterval 
	
	, ' / portTICK_RATE_MS ) );
		
	}
}
'.
			
			
	^ task.
		
	
]

{ #category : #compilation }
PLC_TaskConfiguration >> cCompilePrototype [
	"Devuelve el prototipo de función de Tarea de freeRTOS en lenguaje C.
	
	Ejemplo:

	void vPeriodicTask_TareaEj(void *);
	
	"
	
	| task |
	
	task := '
	
	void vPeriodicTask_'

	, self taskName

	, '(void *);'.
		
	^ task.
		
	
]

{ #category : #compilation }
PLC_TaskConfiguration >> cPOUName [
	"Devuelve el nombre en C de la POU"
	
	"Ejemplo: 
	
	PLC_F_ADD_INT"
	
	^ self declaration cPOUName.
]

{ #category : #compilation }
PLC_TaskConfiguration >> cTaskCreate [
	"Devuelve la API de creación de esta Tarea de freeRTOS en lenguaje C.
	
	Ejemplo:

	void vPeriodicTask_TareaEj(void *);
	
	"
	
	| task |
	
	task := '
	
	/* Crea una instancia de la tarea periodica con prioridad X. */
	xTaskCreate( vPeriodicTask_'

	, self taskName

	, ', "Tarea periódica '
	
	, self taskName
	
	, '", 512, NULL, '
	
	, self taskCPriority 
	
	, ', NULL );'.
		
	^ task.
		
	
]

{ #category : #'initialize-release' }
PLC_TaskConfiguration >> createInitialInputAssignments [
	"Crea las asignaciones iniciales a las variables de entrada de la Tarea"

	self inputAssignments: OrderedCollection new.
	
	self inputAssignments add: 
			( PLC_InputAssignment
				newWithFormalParameter: 
					( PLC_Variable 
						newWithDeclaration: (self inputDecls at: 1)
						andDataValue: nil )
				andActtualArgument:
					( PLC_Literal newWithDataType: PLC_DataType Bool andDataValue: false )
			).	
	
	self inputAssignments add: 
			( PLC_InputAssignment
				newWithFormalParameter: 
					( PLC_Variable 
						newWithDeclaration: (self inputDecls at: 2)
						andDataValue: nil )
				andActtualArgument:
					( PLC_Literal newWithDataType: PLC_DataType Time andDataValue: 0 )
			).	
	
	self inputAssignments add: 
			( PLC_InputAssignment
				newWithFormalParameter: 
					( PLC_Variable 
						newWithDeclaration: (self inputDecls at: 3)
						andDataValue: nil )
				andActtualArgument:
					( PLC_Literal newWithDataType: PLC_DataType UInt andDataValue: 0 )
			).	
]

{ #category : #'initialize-release' }
PLC_TaskConfiguration >> createInputVarDecls [
	"Crea las asignaciones iniciales a las variables de entrada de la Tarea"

	self inputDecls: PLC_VariableCategoryDecl inputVarDecls.
	
	self inputDecls add: ( 
	PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Bool
		andInitialValue: true 
		andIdentifier: 'SINGLE' 
	).
	
	self inputDecls add: ( 
	PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType Time
		andInitialValue: 0 
		andIdentifier: 'INTERVAL' 
	).
	
	self inputDecls add: ( 
	PLC_SymbolicVariableDecl 
		newWithDataType: PLC_DataType UInt
		andInitialValue: 0 
		andIdentifier: 'PRIORITY' 
	).
]

{ #category : #compilation }
PLC_TaskConfiguration >> ilCompile [
	"Compila el elemento IL Configuración de Tarea a IL."

	"Por ejemplo:
	
		TASK TareaEj ( 	INTERVAL := T#50 ms , PRIORITY := 1) ;'
		
	"	

	^ '
			TASK ' 
		, self taskName , ' ( ' 
		,  ( self inputAssignments at: 2 ) ilCompile , 'ms , ' 
		,  ( self inputAssignments at: 3 ) ilCompile , ' ) ;'.
		
	
]

{ #category : #'initialize-release' }
PLC_TaskConfiguration >> initialize [
	"Inicializaciones"

	self createInputVarDecls.
	
	self createInitialInputAssignments.
	
	self programConfigurations: OrderedCollection new.
]

{ #category : #accessing }
PLC_TaskConfiguration >> inputAssignments [
	
	^ inputAssignments
]

{ #category : #accessing }
PLC_TaskConfiguration >> inputAssignments: anObject [
	
	inputAssignments := anObject
]

{ #category : #accessing }
PLC_TaskConfiguration >> inputDecls [
	
	^ inputDecls
]

{ #category : #accessing }
PLC_TaskConfiguration >> inputDecls: anObject [
	
	inputDecls := anObject
]

{ #category : #compilation }
PLC_TaskConfiguration >> instanceName [
	"Devuelve el nombre de la Instancia de la POU"
	
	^ self instance identifier.
]

{ #category : #compilation }
PLC_TaskConfiguration >> pouName [
	"Devuelve el identificador de la POU"
	
	^ self declaration identifier.
]

{ #category : #accessing }
PLC_TaskConfiguration >> programConfigurations [
	
	^ programConfigurations
]

{ #category : #accessing }
PLC_TaskConfiguration >> programConfigurations: anObject [
	
	programConfigurations := anObject
]

{ #category : #'program configurations' }
PLC_TaskConfiguration >> removeProgConfig: aProgConfig [
	"Remueve de la Tarea la Configuración de programa aProgConfig que le llega como parámetro"

	self programConfigurations remove: aProgConfig.
	
	aProgConfig task: nil.

	^ aProgConfig.
]

{ #category : #accessing }
PLC_TaskConfiguration >> resource [
	
	^ resource
]

{ #category : #accessing }
PLC_TaskConfiguration >> resource: anObject [
	
	resource := anObject.
]

{ #category : #compilation }
PLC_TaskConfiguration >> taskCInterval [
	"Devuelve el valor de Periodicidad de la Tarea c como String."
	
	| plcInterval |
	
	plcInterval := (self inputAssignments at: 2) actualArgument dataValue.
	
	^ plcInterval asString.
]

{ #category : #compilation }
PLC_TaskConfiguration >> taskCPriority [
	"Devuelve el valor de prioridad de la Tarea c como String."
	
	"Las prioridades de TASK CONFIGURATION de PLC pueden ir de 0 (más prioritaria)
	a 9 (menor prioridad). Es al revés que en las Tareas freeRTOS. 
	Guardo la Prioridad 0 (la menor prioridad en freeRTOS) para la tarea cíclica.
	Las demas pueden tener de 1 a 9.
	Entonces: PrioridadFreeRTOS = 10 - PrioridadIEC para las tareas periódicas."
	
	| plcPriority |
	
	plcPriority := (self inputAssignments at: 3) actualArgument dataValue.
	
	^ ( 10 - plcPriority ) asString.
]

{ #category : #accessing }
PLC_TaskConfiguration >> taskName [
	
	^ self identifier
]

{ #category : #accessing }
PLC_TaskConfiguration >> taskName: aString [
	
	self identifier: aString.
]
