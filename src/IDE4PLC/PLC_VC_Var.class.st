"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_VC_Var is xxxxxxxxx.

Instance Variables

"
Class {
	#name : #'PLC_VC_Var',
	#superclass : #'PLC_VariableCategoryDecl',
	#category : #'IDE4PLC-Declarations'
}

{ #category : #'formal parameter check' }
PLC_VC_Var >> acceptLiteral [
	"Devuelve true si acepta asignar literales."
	
	^ true.
]

{ #category : #'declarations check' }
PLC_VC_Var >> acceptLocatedVarDecl [
	"Responde true si la ctegoría de variables acepta Declaraciones de Variables Localizadas"

	^ true.
]

{ #category : #'formal parameter check' }
PLC_VC_Var >> acceptWire [
	"Responde true si la categoría de variables puede cablear su variable 
	en un lenguaje gráfico si es utilizado como pin de una POU.
	Esto se combina con el >>acceptWire de tipo de datos para definir si
	un pin permite cable en una declaracion de variable.
	No riene sentido en los lenguajes textuales. "

	^ false
]

{ #category : #compilation }
PLC_VC_Var >> varScopePrefix [
	"Devuelve el prefijo que tiene que ver con el alcance de la variable.
	Las variables que se declaran dentro de la instancia usan pxPOU->
	mientras las que se declaran en el cuerpo de la funcion que 
	implementa la pou van sin prefijo."

	^ 'pxPOU->'.
]
