"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_GraphicProgramView is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_GraphicProgramView',
	#superclass : #'PLC_View',
	#category : #'IDE4PLC-Networks'
}

{ #category : #'model accessing' }
PLC_GraphicProgramView >> blockConnectedToInput: anInputNumber for: aGraphicElement [
	"Devuelve el elemento morph del bloque conectable conectado
	a la entrada anInputNumber del elemento morph aGraphicElement."

	| connectableBlock |

	connectableBlock := ( self modelElementForGraphicElement: aGraphicElement ) blockConnectedToInput: anInputNumber.
	
	^ self graphicElementForModelElement: connectableBlock.
]

{ #category : #'model accessing' }
PLC_GraphicProgramView >> blockConnectedToOutput: anOutputNumber for: aGraphicElement [
	"Devuelve el elemento morph del bloque conectable conectado
	a la salida anOutputNumber del elemento morph aGraphicElement."

	| connectableBlock |

	connectableBlock := ( self modelElementForGraphicElement: aGraphicElement ) blockConnectedToOutput: anOutputNumber.
	
	^ self graphicElementForModelElement: connectableBlock.
]

{ #category : #'commands send to self' }
PLC_GraphicProgramView >> changeActualArgumentFor: actualArgumentMorph by: aString [
	"Cambia el alactual argument del elemento del modelo de actualArgumentMorph por el string aString"
	
	| connectableBlock |
		
	"Busco el bloque conectable del actualArgumentMorph"
	connectableBlock := self modelElementForGraphicElement: actualArgumentMorph.
	
	"Le doy la orden al controller para que cambie el actual argument"
	self controller changeActualArgumentFor: connectableBlock by: aString
	
]

{ #category : #'model accessing' }
PLC_GraphicProgramView >> connectedAtInput: aNumber for: aGraphicElement [
	"Devuelve el elemento morph del bloque conectable o conexión conectado
	a la entrada aNumber del elemento morph aGraphicElement."

	| connectableBlock |

	connectableBlock := ( self modelElementForGraphicElement: aGraphicElement ) connectedAtInput: aNumber.
	
	^ self graphicElementForModelElement: connectableBlock.

	

]

{ #category : #'model accessing' }
PLC_GraphicProgramView >> connectedAtOutput: aNumber for: aGraphicElement [
	"Devuelve el elemento morph del bloque conectable o conexión conectado
	a la salida aNumber del elemento morph aGraphicElement."

	| connectableBlock |

	connectableBlock := ( self modelElementForGraphicElement: aGraphicElement) connectedAtOutput: aNumber.
	
	^ self graphicElementForModelElement: connectableBlock.
]

{ #category : #compilation }
PLC_GraphicProgramView >> generateCode [
	"METODO PROVISORIO. Se lo envía el editor ladder. Sirve para mostrar en un Transcript el programa compilado."
	
	| progAcc |
	
	"Creo el acumulador de objetos de programa."
	progAcc := PLC_ProgramAccumulator_POU new.
	
	"Le envio la petición al controlador de que se compile en el programa de objetos"
	self controller generateCodeIn: progAcc.
	
	"Abro un Transcript y muestro las 2 compilaciones"
	Transcript open.
	
	Transcript show: '
	Programa en IL:
	------------------------

' , progAcc compilerDataTypesDecls ilCompile ,'


' ,  progAcc compilerVarDecls ilCompile ,'


' , progAcc compiledBody ilCompile ,'


'.	
	
	Transcript show: '
	Programa en C:
	------------------------

' , progAcc compilerDataTypesDecls cCompile ,'


' ,  progAcc compilerVarDecls cCompile ,'


' , progAcc compiledBody cCompile ,'


'.	
]

{ #category : #'model accessing' }
PLC_GraphicProgramView >> modelElementForGraphicElement: aGraphicElement [
	"Devuelve el bloque conectable o conexion correspondiente al elemento grafico."

	^ self elements at: aGraphicElement
]
