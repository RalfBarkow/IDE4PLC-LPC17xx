"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_CompilerAndWriter is xxxxxxxxx.

Instance Variables
	fileSystem:		<Object>

fileSystem
	- xxxxx

"
Class {
	#name : #'PLC_CompilerAndWriter',
	#superclass : #Object,
	#instVars : [
		'fileSystem'
	],
	#classVars : [
		'Instance'
	],
	#category : #'IDE4PLC-Compilation-Program'
}

{ #category : #'instance creation' }
PLC_CompilerAndWriter class >> clearInstance [ 
	"Elimina la unica instancia de esta clase."

	Instance ifNotNil: 
		[
		Instance := nil.
		].
]

{ #category : #'instance creation' }
PLC_CompilerAndWriter class >> uniqueInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNil: 
		[
		Instance := PLC_CompilerAndWriter new.
		].
	
	^ Instance.
]

{ #category : #download }
PLC_CompilerAndWriter >> bootLPCLink [
	"Bootea el LPC Link. So lo hay que hacerlo una vez"
	"OSProcess command: 'C:\IDE4PLC.app\Contents\Resources\IDE4PLC_BAT\LPC_Link_Boot.bat'."
]

{ #category : #compile }
PLC_CompilerAndWriter >> buildCProject [
	"Hace el build del Proyecto en C que tiene el Programa Completo de usuario 
	(Configuración de Software implementada en C) + Entorno de Ejecución."

	"Inicicaliza la direccion de la ruta de instalacion del LPCXpressoIDE"
	"OSProcess command: self fileSystem batFilesPath , '1.bat'."

	"Ejecuta el Build de los archivos .C y .H de los Proyectos de Eclipse 
	PLeriC_Project (ejecutable) y PLeriC (biblioteca estática)"
	OSProcess command: 'C:\IDE4PLC.app\Contents\Resources\IDE4PLC_BAT\Build_C_Project.bat'.
]

{ #category : #compile }
PLC_CompilerAndWriter >> cCompile: aSoftConfig [
	"Crea los archivos y hace el build del Proyecto en C que tiene el Programa Completo de usuario 
	(Configuración de Software implementada en C) + Entorno de Ejecución."


	"Crea los archivos .C y .H"
	self createCProjectFor: aSoftConfig.

	"Build de los archivos .C y .H"
	"self buildCProject.	"			"LO COMENTO PARA QUE NO ME HAGA BUILD MIENTRAS PRUEBO"
]

{ #category : #compile }
PLC_CompilerAndWriter >> createCProjectFor: aSoftConfig [
	"Crea los archivos .C y .H Crea los archivos Proyecto en C que tiene el
	 Programa Completo de usuario (Configuración de Software implementada en C)."
	
	| resource |
	
	resource := aSoftConfig resources first.

	"Grabo el archivo main.c"
	self fileSystem 
		writeInMain: resource cMainC.
	
	
		
	"Grabo el archivo PLC_UserPrograms.c"
	self fileSystem 
		writeInCLibrary: resource cUserProgramsC 
		in: 'PLC_UserPrograms.c'.
	
	"Grabo el archivo PLC_UserPrograms.h"
	self fileSystem 
		writeInHLibrary: resource cUserProgramsH 
		in: 'PLC_UserPrograms.h'.
	
		
	
	"Grabo el archivo PLC_StdFunctions.c"
	self fileSystem 
		writeInCLibrary: resource cStandardFunctionsC
		in: 'PLC_StdFunctions.c'.
	
	"Grabo el archivo PLC_StdFunctions.h"
	self fileSystem 
		writeInHLibrary: resource cStandardFunctionsH 
		in: 'PLC_StdFunctions.h'.
	
		
	
	"Grabo el archivo PLC_StdFunctionBlocks.c"
	self fileSystem 
		writeInCLibrary: resource cStandardFunctionBlocksC 
		in: 'PLC_StdFunctionBlocks.c'.
	
	"Grabo el archivo PLC_StdFunctionBlocks.h"
	"self fileSystem 
		writeInHLibrary: resource cStandardFunctionBlocksH 
		in: 'PLC_StdFunctionBlocks.h'."
	
	
			
	"Grabo el archivo PLC_UserTasks.c"
	self fileSystem writeInCLibrary: 
		resource cUserTasksC 
		in: 'PLC_UserTasks.c'.
	
	"Grabo el archivo PLC_UserTasks.h"
	self fileSystem 
		writeInHLibrary: resource 
		cUserTasksH in: 'PLC_UserTasks.h'.
]

{ #category : #download }
PLC_CompilerAndWriter >> downloadSoftwareConfig [
	"Descarga el programa en el PLC (flasheo)"

	"Programa el ejecutable en la Flash del microcontrolador"
	"OSProcess command: 'C:\IDE4PLC.app\Contents\Resources\IDE4PLC_BAT\Flash_Programming.bat'."
]

{ #category : #accessing }
PLC_CompilerAndWriter >> fileSystem [
	
	^ fileSystem
]

{ #category : #accessing }
PLC_CompilerAndWriter >> fileSystem: anObject [
	
	fileSystem := anObject
]

{ #category : #compile }
PLC_CompilerAndWriter >> ilCompile: aSoftConfig [
	"Crea los archivos .il."
	
	| resource |
	
	
	"HACER"
	
	
	
	resource := aSoftConfig resources first.

	"Grabo el archivo main.c"
	self fileSystem 
		writeInMain: resource cMainC.
	
	
		
	"Grabo el archivo PLC_UserPrograms.c"
	self fileSystem 
		writeInCLibrary: resource cUserProgramsC 
		in: 'PLC_UserPrograms.c'.
	
	"Grabo el archivo PLC_UserPrograms.h"
	self fileSystem 
		writeInHLibrary: resource cUserProgramsH 
		in: 'PLC_UserPrograms.h'.
	
		
	
	"Grabo el archivo PLC_StdFunctions.c"
	self fileSystem 
		writeInCLibrary: resource cStandardFunctionsC
		in: 'PLC_StdFunctions.c'.
	
	"Grabo el archivo PLC_StdFunctions.h"
	self fileSystem 
		writeInHLibrary: resource cStandardFunctionsH 
		in: 'PLC_StdFunctions.h'.
	
		
	
	"Grabo el archivo PLC_StdFunctionBlocks.c"
	self fileSystem 
		writeInCLibrary: resource cStandardFunctionBlocksC 
		in: 'PLC_StdFunctionBlocks.c'.
	
	"LO CANCELE PORQUE JODIA CON EL SET QUE ME MEZCLA LAS DECLARACIONESaSoftConfig DE TYPEDEF DE LOS FB ENTONCES LOS CONTADORES Y TEMPORIZADORES NO ENCUENTRAN R_TRIG O F_TRIG"
	"Grabo el archivo PLC_StdFunctionBlocks.h"
	"self fileSystem 
		writeInHLibrary: resource cStandardFunctionBlocksH 
		in: 'PLC_StdFunctionBlocks.h'."
	
	
			
	"Grabo el archivo PLC_UserTasks.il"
	self fileSystem writeInCLibrary: 
		resource cUserTasksC 
		in: 'PLC_UserTasks.il'.
			
			
			
	"aSoftConfig ilCompile."


]

{ #category : #'initialize-release' }
PLC_CompilerAndWriter >> initialize [ 
	"Inicializo la instancia de Compilador y Grabador"
	
	fileSystem := PLC_FileSystem uniqueInstance.
]
