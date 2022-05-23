"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLeriC is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #PLeriC,
	#superclass : #Object,
	#classVars : [
		'pou'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> bootLPCLink [

	PLC_CompilerAndWriter uniqueInstance bootLPCLink.
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> cCompileConfigSoft [

	(self createConfigSoftWithPOU: pou ) cCompile.
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> createConfigSoftWithPOU: aPOU [

	| programitaDecl  pouCall categoriaDeInstancia declDeInstancia operandoInstancia 
	tarea proyecto configHard configSoft recurso |


	programitaDecl := aPOU.

	"--------------------------------------------------------------------------------------------------------------"

					"PROYECTO
					------------------"

	proyecto := PLC_Project newWithName: 'Trabajo_Final'.
	proyecto libraries.
	proyecto hardwareConfigurations.

	proyecto projectName.
	proyecto identifier.

	proyecto addHardwareConfiguration: (
		PLC_HardwareConfiguration 
			newWithName: 'Config_Ejemplo'
		).
		
	"proyecto explore."
		
		
	"--------------------------------------------------------------------------------------------------------------"

				"CONFIGURACION DE HARDWARE DESDE PROYECTO
				------------------------------------------------------------------------------"

	configHard := proyecto hardwareConfigurations first.

	configHard addDevice: PLC_DevicePLC plericLPC1769 at: 0.


	"--------------------------------------------------------------------------------------------------------------"

				"CONFIGURACION DE SOFTWARE DESDE LA DE HARDWARE
				----------------------------------------------------------------------------------------"

	"Para crear y almacenar una Configuracioón de software en la de hardware"
	configSoft := configHard createSoftwareConfiguration.

	"--------------------------------------------------------------------------------------------------------------"

				"RECURSO DESDE LA CONFIGURACION DE SOFTWARE
				-------------------------------------------------------------------------------"

	recurso := configSoft resources first.

	recurso ilCompile.
				
	"--------------------------------------------------------------------------------------------------------------"

			"CREO UNA TAREA PERIODICA
			 -------------------------------------------"				

	tarea := PLC_TaskConfiguration newWithName: 'TareaPer'.


	"--------------------------------------------------------------------------------------------------------------"

			"DECLARACION DE VARIABLE DE INSTANCIA (del Programa) EN RECURSO
			 -----------------------------------------------------------------------------------------------------------"
			
	"Obtengo la Categoría VAR_GLOBAL en Recurso"
	categoriaDeInstancia := recurso globalVarDecls.

	"Es la declaracion de variable de instancia que voy a poner en la lista de VAR_GLOBAL en Recurso"
	declDeInstancia := programitaDecl instanceDecl.

	"Agrego la variable a la categoria, Declara la instancia en el Recurso"
	categoriaDeInstancia add: declDeInstancia.


	"CREACION DE OPERANDO VARIABLE INSTANCIA A PARTIR DE SU DECLARACION:"

	"Creo un operando instancia desde la declaracion. ESTO LO VA A TENER QUE HACER EL PARSER EN IL"
	operandoInstancia :=  declDeInstancia operand.
		

	"--------------------------------------------------------------------------------------------------------------"

			"CREO UNA CONFIGURACION DE (o llamado a) PROGRAMA
			 --------------------------------------------------------------------------------------"

	"Le asigno la instancia creada"	
	pouCall := PLC_ProgramConfiguration 
		newFromDeclaration: programitaDecl 
		andInstanceOperand: operandoInstancia.
				
	"--------------------------------------------------------------------------------------------------------------"

			"AÑADO LAS CONFIG DE TAREA y PROGRAMA ALRECURSO 	
			-------------------------------------------------------------------------------------"				
					
	"Agrego al recurso configuraciones de Tareas y Programas"	
	recurso addProgConfig: pouCall.
	recurso addTaskConfig: tarea.

	"--------------------------------------------------------------------------------------------------------------"

			"CONFIGURO LA TAREA PERIODICA
			 ---------------------------------------------------"				

	"PRIORIDAD"
	(tarea inputAssignments at: 3) actualArgument dataValue: 9.

	"PERIODICIDAD cada 20 ms"
	(tarea inputAssignments at: 2) actualArgument dataValue: 20. 


	"--------------------------------------------------------------------------------------------------------------"

			"CONFIGURO LA CONFIG DE PROGRAMA
			 ---------------------------------------------------------"
		
	"Asigno una las entradas del llamado a programa con direcciones fisicas  %IX0.0"	
		
	(pouCall inputAssignments at: 1) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 1) 
					andDataValue: nil
				).	"globalVarDecls at: 1 = %I0.0"	
		
	(pouCall inputAssignments at: 2) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 2) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 3) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 3) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 4) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 4) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 5) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 5) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 6) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 6) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 7) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 7) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 8) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 8) 
					andDataValue: nil
				).

	"Asigno una las salidas del llamado a programa con direcciones fisicas  %QX0.0"	
		
	(pouCall outputAssignments at: 1) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 9) 
					andDataValue: nil
				).	"recurso globalVarDecls at: 9 = %Q0.0"
		
	(pouCall outputAssignments at: 2) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 10) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 3) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 11) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 4) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 12) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 5) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 13) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 6) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 14) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 7) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 15) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 8) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 16) 
					andDataValue: nil
				).	


	"--------------------------------------------------------------------------------------------------------------"

			"ASOCIO CONFIG DE TAREA CON CONFIG PROGRAMA
			-------------------------------------------------------------------------------"
			
	"Añado la configuracion de programa o llamado a programa a la tarea (asociacion)"
	tarea addProgConfig: pouCall.

	"--------------------------------------------------------------------------------------------------------------"

	^ configSoft.
	
	
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> createProgDecl [

	| programitaDecl |

	"Acá hago de cuenta que toque el ícono 'Nueva POU'  y elegí PROGRAMA" 
	programitaDecl := PLC_Program
		newWithName: 'MAIN_PROG' 
		andDataType: PLC_DataType Bool.

	"y cuerpo en lenguaje Ladder. El cuerpo añade una network automaticamente"
	programitaDecl pouBody: (PLC_LadderBody newWithPOU: programitaDecl).


	"Agrego una declaracion de variable de entrada. 
	Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E0' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E1' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E2' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E3' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E4' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E5' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E6' 
		).	
	"Agrego una declaracion de variable de entrada. Cuando hace add le agrega su categoría automaticamente"
	programitaDecl inputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'E7' 
		).	
				
				
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S0' 
		).	
					"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S1' 
		).					
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S2' 
		).	
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S3' 
		).	
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S4' 
		).	
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S5' 
		).	
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S6' 
		).	
	"Agrego una declaracion de variable de salida"
	programitaDecl outputVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'S7' 
		).
	"Agrego una declaracion de variable temporal"
	programitaDecl tempVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Bool
			andInitialValue: nil 
			andIdentifier: 'MEM' 
		).
	"Agrego una declaracion de variable temporal"
	programitaDecl tempVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Time
			andInitialValue: nil 
			andIdentifier: 'A' 
		).	
	"Agrego una declaracion de variable temporal"
	programitaDecl tempVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Time
			andInitialValue: nil 
			andIdentifier: 'B' 
		).
	"Agrego una declaracion de variable temporal"
	programitaDecl tempVarDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Time
			andInitialValue: nil 
			andIdentifier: 'C' 
		).
		
		
	"Agrego una declaracion de variable interna persistente 'ACC = Acumulador' "
	programitaDecl varDecls add: ( 
		PLC_SymbolicVariableDecl 
			newWithDataType: PLC_DataType Time
			andInitialValue: nil 
			andIdentifier: 'ACC' 
		).



	^ programitaDecl.
	
	
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> createProyectWithPOU: aPOU [

	| programitaDecl  pouCall categoriaDeInstancia declDeInstancia operandoInstancia 
	tarea proyecto configHard configSoft recurso |


	programitaDecl := aPOU.

	"--------------------------------------------------------------------------------------------------------------"

					"PROYECTO
					------------------"

	proyecto := PLC_Project newWithName: 'Trabajo_Final'.
	proyecto libraries.
	proyecto hardwareConfigurations.

	proyecto projectName.
	proyecto identifier.

	proyecto addHardwareConfiguration: (
		PLC_HardwareConfiguration 
			newWithName: 'Config_Ejemplo'
		).
		
	"proyecto explore."
		
		
	"--------------------------------------------------------------------------------------------------------------"

				"CONFIGURACION DE HARDWARE DESDE PROYECTO
				------------------------------------------------------------------------------"

	configHard := proyecto hardwareConfigurations first.

	configHard addDevice: PLC_DevicePLC plericLPC1769 at: 0.


	"--------------------------------------------------------------------------------------------------------------"

				"CONFIGURACION DE SOFTWARE DESDE LA DE HARDWARE
				----------------------------------------------------------------------------------------"

	"Para crear y almacenar una Configuracioón de software en la de hardware"
	configSoft := configHard createSoftwareConfiguration.

	"--------------------------------------------------------------------------------------------------------------"

				"RECURSO DESDE LA CONFIGURACION DE SOFTWARE
				-------------------------------------------------------------------------------"

	recurso := configSoft resources first.

	recurso ilCompile.
				
	"--------------------------------------------------------------------------------------------------------------"

			"CREO UNA TAREA PERIODICA
			 -------------------------------------------"				

	tarea := PLC_TaskConfiguration newWithName: 'MAIN_TASK'.


	"--------------------------------------------------------------------------------------------------------------"

			"DECLARACION DE VARIABLE DE INSTANCIA (del Programa) EN RECURSO
			 -----------------------------------------------------------------------------------------------------------"
			
	"Obtengo la Categoría VAR_GLOBAL en Recurso"
	categoriaDeInstancia := recurso globalVarDecls.

	"Es la declaracion de variable de instancia que voy a poner en la lista de VAR_GLOBAL en Recurso"
	declDeInstancia := programitaDecl instanceDecl.

	"Agrego la variable a la categoria, Declara la instancia en el Recurso"
	categoriaDeInstancia add: declDeInstancia.


	"CREACION DE OPERANDO VARIABLE INSTANCIA A PARTIR DE SU DECLARACION:"

	"Creo un operando instancia desde la declaracion. ESTO LO VA A TENER QUE HACER EL PARSER EN IL"
	operandoInstancia :=  declDeInstancia operand.
		

	"--------------------------------------------------------------------------------------------------------------"

			"CREO UNA CONFIGURACION DE (o llamado a) PROGRAMA
			 --------------------------------------------------------------------------------------"

	"Le asigno la instancia creada"	
	pouCall := PLC_ProgramConfiguration 
		newFromDeclaration: programitaDecl 
		andInstanceOperand: operandoInstancia.
				
	"--------------------------------------------------------------------------------------------------------------"

			"AÑADO LAS CONFIG DE TAREA y PROGRAMA ALRECURSO 	
			-------------------------------------------------------------------------------------"				
					
	"Agrego al recurso configuraciones de Tareas y Programas"	
	recurso addProgConfig: pouCall.
	recurso addTaskConfig: tarea.

	"--------------------------------------------------------------------------------------------------------------"

			"CONFIGURO LA TAREA PERIODICA
			 ---------------------------------------------------"				

	"PRIORIDAD"
	(tarea inputAssignments at: 3) actualArgument dataValue: 9.

	"PERIODICIDAD cada 20 ms"
	(tarea inputAssignments at: 2) actualArgument dataValue: 20. 


	"--------------------------------------------------------------------------------------------------------------"

			"CONFIGURO LA CONFIG DE PROGRAMA
			 ---------------------------------------------------------"
		
	"Asigno una las entradas del llamado a programa con direcciones fisicas  %IX0.0"	
		
	(pouCall inputAssignments at: 1) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 1) 
					andDataValue: nil
				).	"globalVarDecls at: 1 = %I0.0"	
		
	(pouCall inputAssignments at: 2) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 2) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 3) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 3) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 4) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 4) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 5) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 5) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 6) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 6) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 7) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 7) 
					andDataValue: nil
				).
		
	(pouCall inputAssignments at: 8) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 8) 
					andDataValue: nil
				).

	"Asigno una las salidas del llamado a programa con direcciones fisicas  %QX0.0"	
		
	(pouCall outputAssignments at: 1) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 9) 
					andDataValue: nil
				).	"recurso globalVarDecls at: 9 = %Q0.0"
		
	(pouCall outputAssignments at: 2) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 10) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 3) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 11) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 4) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 12) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 5) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 13) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 6) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 14) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 7) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 15) 
					andDataValue: nil
				).	
		
	(pouCall outputAssignments at: 8) 
			actualArgument: (
				PLC_Location 
					newWithDeclaration: (recurso globalVarDecls at: 16) 
					andDataValue: nil
				).	


	"--------------------------------------------------------------------------------------------------------------"

			"ASOCIO CONFIG DE TAREA CON CONFIG PROGRAMA
			-------------------------------------------------------------------------------"
			
	"Añado la configuracion de programa o llamado a programa a la tarea (asociacion)"
	tarea addProgConfig: pouCall.

	"--------------------------------------------------------------------------------------------------------------"

	^ proyecto.
	
	
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> downloadProgram [

	PLC_CompilerAndWriter uniqueInstance downloadSoftwareConfig.
]

{ #category : #'class initialization' }
PLeriC class >> initialize [
	"Esta clase inicializa todas las que usa el proyecto"

	super initialize.


"
			OS PROCESS
			=========
"

	"Ejecutar una vez"
	Gofer it
 	      squeaksource: 'MetacelloRepository';
  	     package: 'ConfigurationOfOSProcess';
   	    load.
	"Ejecutar una vez"
	(ConfigurationOfOSProcess project version: #stable) load.

	"Ejecutar una vez"
	OSProcess thisOSProcess stdOut.

	"Ejecutar cada vez que quiero abrir algo, por ejemplo:"
	"OSProcess command: 'calc'."


"
			 PARSER
			======
"

	"Pharo Smalltalk is the main development environment of PetitParser. 
	To load the core library evaluate the following code:"

	Gofer new
	    renggli: 'petit'; 
	    package: 'PetitParser';
	    load.

	"To get the full toolset, including a dedicated editor and some 
	experimental tools, use the following Metacello script: 
	(No funciona en Pharo 1.3)"

	"Gofer new
	    renggli: 'petit';
	    package: 'ConfigurationOfPetitParser';
	    load.
	(Smalltalk at: #ConfigurationOfPetitParser)
	    perform: #loadDefault."




"
			INSTANCIAS UNICAS
			=============
"

	"Clase con identificador"
	"PLC_ClassWithIdentifier initialize."

	"Compilador y grabador (usa PLC_FileSystem y OSProcess)"
	PLC_CompilerAndWriter clearInstance.

	"Es el que usa FileStream para finalmente crear los 
	archivos .C, .H y .IL"
	PLC_FileSystem clearInstance.

	"Tipos de datos"
	PLC_DataType clearTypes.
	"PLC_DataType createDataTypes."

	"Funciones y Bloques de Función"
	PLC_Function clearFunctions.
	PLC_Function createStdFunctions.
	PLC_FunctionBlock clearFunctionBlocks.
	PLC_FunctionBlock createStdFunctionBlocks.
	PLC_Program clearPrograms.

	"Elementos de lenguajes gráficos"
	"PLC_Element initialize."
	PLC_Element clearElements.
	"PLC_GraphicFunctionBlockCall initialize.
	PLC_VerticalLink initialize."

	"Elementos IL"
	"PLC_IL_Modifiers initialize."
	PLC_IL_Modifiers clearInstances.

	"Morphs de los elementos gráficos"
	PLC_GraphicElementProperties clearInstance.

	"Estados de los Morphs de los elementos gráfico"
	PLC_Aligns clearAligns.
	PLC_GraphicElementState clearStates.

	"Bibliotecas"
	PLC_Libraries clearInstance.

]

{ #category : #'class initialization' }
PLeriC class >> initializeGUI [
	"Esta clase inicializa la parte visual del proyecto"


	"GUI - Iconos de escritorio"
	PLC_DesktopIcon blueTheme.
	PLC_DesktopIcon blackTheme.
	PLC_DesktopIcon screen1920x1080.
	PLC_DesktopIcon screen800x600.
	PLC_DesktopIcon createIcons.

	
	"CAMBIAR FONDO EN PARO"

	World backgroundImage: (ImageReadWriter formFromFileNamed: 'IDE4PLC_files/GUI_Images/background.jpg') layout: #scaled.


	"CANCELAR MENU WORD SIGUE ANDANDO CON ESC, HAY QUE REESCRIBIR EL METODO"

"PasteUpMorph>>handlesMouseDown: evt
	^false"
	"^false" "ERIC: Lo puedo poner a flase para que no activen el menu word. Viene en true"
	

]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> open [

	"PARCHASOOO - Se lo manda el icono de biblioteca para resetear la pou"

	| pouEditor |

	pou := nil.
	
	
	"Creo un nuevo editor de POU - Para que cargue los cambios en la pou"
	pouEditor := PLC_POU_Editor 
		newWithPOU: PLeriC pou
		andColor: ( Color r: 1 g: 1 b: 1 alpha: 0.5 )  
		andBorderColor: Color black 
		andTitleColor:  PLC_GraphicElementProperties uniqueInstance programColor 
		andTitleName: 'POU: PROGRAMA'.	
		
	"Le asigno el editor"
	PLC_DesktopIcon pou action: pouEditor.
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> pou [

	pou ifNil: [
		pou := self createProgDecl.
		].
	
	^ pou
]

{ #category : #'SERVICIOS PARA LA PRESENTACION' }
PLeriC class >> pou: obj [

	pou := obj.
]
