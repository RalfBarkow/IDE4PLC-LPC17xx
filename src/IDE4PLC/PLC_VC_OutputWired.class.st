"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VC_OutputWired is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_VC_OutputWired',
	#superclass : #'PLC_VariableCategoryDecl',
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'formal parameter check' }
PLC_VC_OutputWired >> acceptLiteral [
	"Devuelve true si acepta asignar literales."
	
	^ false.
]

{ #category : #'formal parameter check' }
PLC_VC_OutputWired >> acceptWire [
	"Responde true si la categoría de variables puede cablear su variable 
	en un lenguaje gráfico si es utilizado como pin de una POU.
	Esto se combina con el >>acceptWire de tipo de datos para definir si
	un pin permite cable en una declaracion de variable.
	No riene sentido en los lenguajes textuales. "

	^ true
]

{ #category : #'argument check' }
PLC_VC_OutputWired >> canBeRead [
	"Devuelve true si acepta ser leida. Esto es, si una declaración de variable
	en esta categoría acpeta ser asignada como argumento a un parámetro 
	formal del tipo VAR_INPUT o VAR_IN_OUT los cuales necesitan leer la 
	variable asignada."
	
	^ false.

]

{ #category : #compilation }
PLC_VC_OutputWired >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ 'pxPOU->'.
]

{ #category : #'category name' }
PLC_VC_OutputWired >> varType [
	
	^ '_OUTPUT'
]
