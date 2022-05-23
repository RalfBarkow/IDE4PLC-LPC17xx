"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_SoftwareConfiguration is xxxxxxxxx.

Instance Variables
	declarations:		<Object>
	hardwareConfiguration:		<Object>
	resources:		<Object>

declarations
	- xxxxx

hardwareConfiguration
	- xxxxx

resources
	- xxxxx

"
Class {
	#name : #'PLC_SoftwareConfiguration',
	#superclass : #'PLC_ClassWithIdentifier',
	#instVars : [
		'hardwareConfiguration',
		'declarations',
		'resources'
	],
	#category : #'IDE4PLC-Project'
}

{ #category : #'instance creation' }
PLC_SoftwareConfiguration class >> newFromHardwareConfiguration: aHardConfig [
	"Crea una nueva isntancia a partir de la Configuración de Hardware recibida como parámetro"

	| softConfig |
	
	"Creo la Configuración de Software"
	softConfig := self new.
	
	"Le asigno la Configuración de Hardware a la de Software"
	softConfig hardwareConfiguration: aHardConfig.
	
	"Le agrego a  la Configuración de Software los Recursos 
	que me provea la Configuración de Hardware"
	aHardConfig resources do: [  :each |
		softConfig addResource: each.
		].
	
	softConfig softConfigName: 
		aHardConfig hardConfigName.
	
	^ softConfig.
	

]

{ #category : #resources }
PLC_SoftwareConfiguration >> addResource: aResource [
	"Añade a la Configuración de Software el recurso aResource que le llega como parámetro"

	self resources add: aResource.
	
	aResource softwareConfiguration: self.
	
	^ aResource.
]

{ #category : #compilation }
PLC_SoftwareConfiguration >> cCompile [
	"Llama al compilador y grabador para que genere los archivos C y H."

	PLC_CompilerAndWriter uniqueInstance
		cCompile: self.
]

{ #category : #compilation }
PLC_SoftwareConfiguration >> calledPOUs [
	"Devuelve un Set con las POU que llama cada Configuración de 
	Programa de cada uno de sus Recursos."

	| pouSet |
	
	pouSet := Set new.
	
	self resources do: [ :each |
		pouSet addAll: each calledPOUs.
		].

	^ pouSet.
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> declarations [
	
	^ declarations
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> declarations: anObject [
	
	declarations := anObject
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> globalVarDecls [
	
	^ self declarations
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> hardwareConfiguration [
	
	^ hardwareConfiguration
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> hardwareConfiguration: anObject [
	
	hardwareConfiguration := anObject
]

{ #category : #compilation }
PLC_SoftwareConfiguration >> ilCompile [
	"Devuelve un String con el Configuración de Software Compilada a código IL."

	| ilCode |
	
	ilCode := 'CONFIGURATION ' 
	, self softConfigName
	, '
	
	(* Declaraciones de Configuracion *)

'.
	self globalVarDecls
		ifNotNil: [ 
			ilCode := ilCode ,
			self globalVarDecls ilCompile , '
'.
			].
	
	ilCode := ilCode ,'	
	(* Recursos *)'.

	self resources
		ifNotNil: [ 
			self resources do: [ :each | 
				ilCode := ilCode , each ilCompile , '
'.
				].
			].

	ilCode := ilCode ,'		
END_CONFIGURATION'.


	^ ilCode.
	
]

{ #category : #'initialize-release' }
PLC_SoftwareConfiguration >> initialize [
	"Inicializaciones de Recurso"

	self resources: OrderedCollection new.
	
	"POR AHORA COMO SOLO HAGO QUE CONFIGURACION TENGA 
	SOLO DECLARACIONES DE VARIABLES GLOBALES NO HACE FALTA EL 
	OBJETO PLC_SOFT_CONFIG_DECLARATIONS"
	self declarations: PLC_VariableCategoryDecl globalVarDecls.
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> resources [
	
	^ resources
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> resources: anObject [
	
	resources := anObject
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> softConfigName [
	
	^ identifier
]

{ #category : #accessing }
PLC_SoftwareConfiguration >> softConfigName: anObject [
	
	identifier := anObject
]
