"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.


A PLC_FileSystem is xxxxxxxxx.

Instance Variables
	batFilesPath:		<Object>
	cLibraryPath:		<Object>
	guiImagesPath:		<Object>
	hLibraryPath:		<Object>
	ilExportPath:		<Object>
	mainPath:		<Object>
	workspacePath:		<Object>

batFilesPath
	- xxxxx

cLibraryPath
	- xxxxx

guiImagesPath
	- xxxxx

hLibraryPath
	- xxxxx

ilExportPath
	- xxxxx

mainPath
	- xxxxx

workspacePath
	- xxxxx

"
Class {
	#name : #'PLC_FileSystem',
	#superclass : #Object,
	#instVars : [
		'workspacePath',
		'mainPath',
		'cLibraryPath',
		'hLibraryPath',
		'batFilesPath',
		'guiImagesPath',
		'ilExportPath'
	],
	#classVars : [
		'Instance'
	],
	#category : #'IDE4PLC-Compilation-Program'
}

{ #category : #'instance creation' }
PLC_FileSystem class >> clearInstance [ 
	"Elimina la unica instancia de esta clase."

	Instance ifNotNil: 
		[
		Instance := nil.
		].
]

{ #category : #'instance creation' }
PLC_FileSystem class >> uniqueInstance [ 
	"Devuelve la unica instancia de esta clase."

	Instance ifNil: 
		[
		Instance := PLC_FileSystem new.
		].
	
	^ Instance.
]

{ #category : #accessing }
PLC_FileSystem >> batFilesPath [
	
	^ batFilesPath
]

{ #category : #accessing }
PLC_FileSystem >> batFilesPath: anObject [
	
	batFilesPath := anObject
]

{ #category : #accessing }
PLC_FileSystem >> cLibraryPath [
	
	^ cLibraryPath
]

{ #category : #accessing }
PLC_FileSystem >> cLibraryPath: anObject [
	
	cLibraryPath := anObject
]

{ #category : #accessing }
PLC_FileSystem >> guiImagesPath [
	
	^ guiImagesPath
]

{ #category : #accessing }
PLC_FileSystem >> guiImagesPath: anObject [
	
	guiImagesPath := anObject
]

{ #category : #accessing }
PLC_FileSystem >> hLibraryPath [
	
	^ hLibraryPath
]

{ #category : #accessing }
PLC_FileSystem >> hLibraryPath: anObject [
	
	hLibraryPath := anObject
]

{ #category : #accessing }
PLC_FileSystem >> ilExportPath [
	
	^ ilExportPath
]

{ #category : #accessing }
PLC_FileSystem >> ilExportPath: anObject [
	
	ilExportPath := anObject
]

{ #category : #'initialize-release' }
PLC_FileSystem >> initialize [ 
	"Inicializaciones"

	workspacePath := 'IDE4PLC_LPC1769_WS/'.
	mainPath := 'PLeric_Project/'.
	cLibraryPath := 'PLeriC_Library/src/'.
	hLibraryPath := 'PLeriC_Library/inc/'.
	batFilesPath := 'IDE4PLC_BAT/'.
	ilExportPath := 'IDE4PLC_IL_Export/'.
	guiImagesPath := 'IDE4PLC_files/GUI_Images/'.
]

{ #category : #accessing }
PLC_FileSystem >> mainPath [
	
	^ mainPath
]

{ #category : #accessing }
PLC_FileSystem >> mainPath: anObject [
	
	mainPath := anObject
]

{ #category : #accessing }
PLC_FileSystem >> workspacePath [
	
	^ workspacePath
]

{ #category : #accessing }
PLC_FileSystem >> workspacePath: anObject [
	
	workspacePath := anObject
]

{ #category : #file }
PLC_FileSystem >> write: aString in: filePathString in: fileNameString [ 
	"Graba el string aString en el archivo de texto cuya ruta es filePathString y nombre de archivo fileNameString"

	| stream |
	

	"forceNewFileNamed: Crea un nuevo archivo con el nombre dado, 
	y devuelve un stream abierto para escritura en ese archivo. 
	Si el archivo ya existe lo borra sin preguntar."
	stream := StandardFileStream forceNewFileNamed:  filePathString , fileNameString.
	
	stream nextPutAll: aString.
	stream cr.
	stream close.
]

{ #category : #file }
PLC_FileSystem >> writeInCLibrary: aString in: fileNameString [ 
	"Graba el string aString en el archivo de texto cuyo nombre de archivo fileNameString"

	self write: aString 
		in: self workspacePath , self cLibraryPath  
		in: fileNameString.
]

{ #category : #file }
PLC_FileSystem >> writeInHLibrary: aString in: fileNameString [ 
	"Graba el string aString en el archivo de texto cuyo nombre de archivo fileNameString"

	self write: aString 
		in: self workspacePath , self hLibraryPath  
		in: fileNameString.
]

{ #category : #file }
PLC_FileSystem >> writeInILExport: aString in: fileNameString [ 
	"Graba el string aString en el archivo de texto cuyo nombre de archivo fileNameString"

	self write: aString 
		in: self ilExportPath
		in: fileNameString.
]

{ #category : #file }
PLC_FileSystem >> writeInMain: aString [
	"Graba el string aString en el archivo de texto cuyo nombre de archivo es manin.c"

	self write: aString 
		in: self workspacePath , self mainPath
		in: 'main.c'.
]
