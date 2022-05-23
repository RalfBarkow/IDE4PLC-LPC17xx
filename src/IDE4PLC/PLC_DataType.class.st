"
Copyright © 2012-2014 Eric Nicolás Pernia.

This class is part of IDE4PLC.

IDE4PLC is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

IDE4PLC is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with IDE4PLC. If not, see <http://www.gnu.org/licenses/>.

------------------------------------------------------------------

A PLC_DataType is xxxxxxxxx.

Instance Variables



"
Class {
	#name : #'PLC_DataType',
	#superclass : #'PLC_ClassWithIdentifier',
	#classVars : [
		'DerivedDataTypes',
		'ElementaryDataTypes',
		'GenericDataTypes',
		'TypesCreated'
	],
	#category : #'IDE4PLC-DataTypes'
}

{ #category : #'GUI information' }
PLC_DataType class >> AllDataTypeNameStrings [
	"Devuelve una coleccion de todos los nombres de los tipos de datos."

	| col | 
	
	col := self AllDataTypeNames.
	
	^ col collect: [ :each|
		each asString.
		].
]

{ #category : #InformationForLiterals }
PLC_DataType class >> AllDataTypeNames [
	"Devuelve una coleccion de todos los nombres de los tipos de datos."

	^ self AnyDataType acceptedDataTypes.
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyBit [
	"Retorna la unica instancia del tipo genérico PLC_AnyBit"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_BIT.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyDataType [
	"Retorna la unica instancia del tipo genérico AnyDataType"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyDate [
	"Retorna la unica instancia del tipo genérico AnyDate"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_DATE.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyDerived [
	"Retorna la unica instancia del tipo genérico AnyDerived"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_DERIVED.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyElementary [
	"Retorna la unica instancia del tipo genérico AnyElementary"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_ELEMENTARY.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyInteger [
	"Retorna la unica instancia del tipo genérico AnyInteger"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_INT.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyMagnitude [
	"Retorna la unica instancia del tipo genérico AnyMagnitude"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_MAGNITUDE.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyNumeric [
	"Retorna la unica instancia del tipo genérico AnyNumeric"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_NUM.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyReal [
	"Retorna la unica instancia del tipo genérico AnyReal"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_REAL.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> AnyString [
	"Retorna la unica instancia del tipo genérico AnyString"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ GenericDataTypes at: #ANY_STRING.
		
"Jerarquia de tipos genéricos:
AnyDataType
	AnyDerived
	AnyElementary
		AnyMagnitude
			AnyNumeric
				AnyReal
				AnyInteger
		PLC_AnyBit
		AnyString
		AnyDate
"
]

{ #category : #InformationForLiterals }
PLC_DataType class >> BitStringDataTypesNames [
	"Devuelve una coleccion de los Nombres de tipo de dato Bit String"

	^ self AnyBit acceptedDataTypes.
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Bool [
	"Retorna la unica instancia del tipo Bool"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #BOOL.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Byte [
	"Retorna la unica instancia del tipo Byte"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #BYTE.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> DInt [
	"Retorna la unica instancia del tipo DInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #DINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
	
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> DT [
	"Retorna la unica instancia del tipo DateAndTime"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #DT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> DWord [
	"Retorna la unica instancia del tipo DWord"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #DWORD.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Date [
	"Retorna la unica instancia del tipo Date"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #DATE.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> DateAndTime [
	"Retorna la unica instancia del tipo DateAndTime"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #DATE_AND_TIME.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Int [
	"Retorna la unica instancia del tipo Int"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #INT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
	
]

{ #category : #InformationForLiterals }
PLC_DataType class >> IntegerDataTypesNames [
	"Devuelve una coleccion de los Nombres de tipo de dato enteros"

	^ self AnyInteger acceptedDataTypes.
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> LInt [
	"Retorna la unica instancia del tipo LInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #LINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
	
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> LReal [
	"Retorna la unica instancia del tipo LReal"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #LREAL.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> LWord [
	"Retorna la unica instancia del tipo LWord"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #LWORD.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Real [
	"Retorna la unica instancia del tipo Real"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #REAL.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #InformationForLiterals }
PLC_DataType class >> RealDataTypesNames [
	"Devuelve una coleccion de los Nombres de tipo de dato reales"

	^ self AnyReal acceptedDataTypes.
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> SInt [
	"Retorna la unica instancia del tipo SInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #SINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> String [
	"Retorna la unica instancia del tipo String"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #STRING.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> TOD [
	"Retorna la unica instancia del tipo TimeOfDay"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #TOD.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Time [
	"Retorna la unica instancia del tipo Time"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #TIME.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> TimeOfDay [
	"Retorna la unica instancia del tipo TimeOfDay"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #TIME_OF_DAY.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> UDInt [
	"Retorna la unica instancia del tipo UDInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #UDINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> UInt [
	"Retorna la unica instancia del tipo UInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #UINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> ULInt [
	"Retorna la unica instancia del tipo ULInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #ULINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> USInt [
	"Retorna la unica instancia del tipo USInt"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #USINT.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Void [
	"Retorna la unica instancia del tipo Void"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #VOID.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> WString [
	"Retorna la unica instancia del tipo WString"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #WSTRING.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> Word [
	"Retorna la unica instancia del tipo Word"

	TypesCreated ifFalse: [self createDataTypes].
	
	^ ElementaryDataTypes at: #WORD.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #DerivedDataTypes }
PLC_DataType class >> addDerivedDataType: aUserDefinedDataType [
	"Añade un tipo de dato definido por el usuario, por ahora solo tengo tipos estructurados.
	Tambien lo usa el compilador de Ladder."

	| symbolIdentifier |
	
	symbolIdentifier := aUserDefinedDataType keyword.
	
	DerivedDataTypes at: symbolIdentifier put: aUserDefinedDataType.
]

{ #category : #'instance creation' }
PLC_DataType class >> allDataTypes [
	"Retorna el diccionario de tipos por defecto junto con el de los tipos definidos por el usuario"

	

	DerivedDataTypes.
	
	^ self. "HACERRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"
]

{ #category : #'instance creation' }
PLC_DataType class >> clearTypes [
	"Borra los tipos de datos"

	ElementaryDataTypes := Dictionary new.
	GenericDataTypes := Dictionary new.
	
	DerivedDataTypes := Dictionary new.
	
	TypesCreated := false.
	
	
]

{ #category : #'instance creation' }
PLC_DataType class >> createDataTypes [
	"Crea los tipos de datos"
		
	ElementaryDataTypes := Dictionary new.
	GenericDataTypes := Dictionary new.
	
	self createElementaryDataTypes. 
	self createGenericDataTypes. 
	
	TypesCreated := true.
]

{ #category : #'instance creation' }
PLC_DataType class >> createElementaryDataTypes [
	"Crea los tipos de datos elementales"

	| typeTemp |
	
	"Bit strings"
	
	typeTemp := PLC_Void new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_Boolean new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_Byte new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_Word new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_DoubleWord new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_LongWord new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	"Signed Integers"
	
	typeTemp := PLC_ShortInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_Integer new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_DoubleInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_LongInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	"Unsigned Integers"
	
	typeTemp := PLC_UnsignedShortInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_UnsignedInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_UnsignedDoubleInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp :=  PLC_UnsignedLongInteger new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	"Reals"
	
	typeTemp := PLC_Real new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_LongReal new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	"Character Strings"
	
	typeTemp := PLC_SingleByteString new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp :=  PLC_DoubleByteString new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	"Time and date"
	
	typeTemp := PLC_Duration new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp :=  PLC_Date new.
	ElementaryDataTypes at: typeTemp keyword put: typeTemp.
	
	typeTemp := PLC_TimeOfDay new.
	ElementaryDataTypes at: (typeTemp keywords at: 1) put: typeTemp.
	ElementaryDataTypes at: (typeTemp keywords at: 2) put: typeTemp.
	
	typeTemp :=  PLC_DateAndTimeOfDay new.
	ElementaryDataTypes at: (typeTemp keywords at: 1) put: typeTemp.
	ElementaryDataTypes at: (typeTemp keywords at: 2) put: typeTemp.
]

{ #category : #'instance creation' }
PLC_DataType class >> createGenericDataTypes [
	"Crea los tipos de datos Genericos. 
	Estan tabulados jerarquicamente, no tiene nada que ver con los mensajes entre los objetos."

	| typeTemp |
	
	typeTemp := PLC_AnyDataType new.
	GenericDataTypes at: typeTemp keyword put: typeTemp.
	
		typeTemp := PLC_AnyDerived new.
		GenericDataTypes at: typeTemp keyword put: typeTemp.
	
		typeTemp := PLC_AnyElementary new.
		GenericDataTypes at: typeTemp keyword put: typeTemp.
	
			typeTemp := PLC_AnyMagnitude new.
			GenericDataTypes at: typeTemp keyword put: typeTemp.
	
				typeTemp := PLC_AnyNumeric new.
				GenericDataTypes at: typeTemp keyword put: typeTemp.
				
					typeTemp := PLC_AnyReal new.
					GenericDataTypes at: typeTemp keyword put: typeTemp.

					typeTemp := PLC_AnyInteger new.
					GenericDataTypes at: typeTemp keyword put: typeTemp.
						
			typeTemp := PLC_AnyBit new.
			GenericDataTypes at: typeTemp keyword put: typeTemp.
			
			typeTemp := PLC_AnyString new.
			GenericDataTypes at: typeTemp keyword put: typeTemp.
			
			typeTemp := PLC_AnyDate new.
			GenericDataTypes at: typeTemp keyword put: typeTemp.
	
]

{ #category : #DerivedDataTypes }
PLC_DataType class >> derivedDataTypes [
	"Retorna el diccionario de tipos"
	
	^ DerivedDataTypes.
]

{ #category : #ElementaryDataTypes }
PLC_DataType class >> elementaryDataTypes [
	"Retorna el diccionario de tipos"
	
	^ ElementaryDataTypes.
		
"Bool Byte Word DWord LWord SInt Int DInt LInt USInt UInt UDInt ULInt Real LReal String WString Time Date TimeOfDay TOD DateAndTime DT"
]

{ #category : #GenericDataTypes }
PLC_DataType class >> genericDataTypes [
	"Retorna el diccionario de tipos"
	
	^ GenericDataTypes.
]

{ #category : #'class initialization' }
PLC_DataType class >> initialize [

	super initialize.
	TypesCreated := false
]

{ #category : #DerivedDataTypes }
PLC_DataType class >> removeAllDerivedDataTypes [
	"Borra todos los tipos derivados."

	DerivedDataTypes := Dictionary new.
]

{ #category : #types }
PLC_DataType >> accept: aSymbol [
	"Devuelve un booleano que indica si acepta el tipo de datos que le llega como parametro aSymbol"

	^ self acceptedDataTypes includes: aSymbol.
]

{ #category : #types }
PLC_DataType >> acceptType: aPLC_DataType [
	"Devuelve un booleano que indica si acepta el tipo de datos que le llega como parametrol"

	^ self = aPLC_DataType.
	
	"^ self acceptedDataTypes includes: aPLC_DataType keyword."
]

{ #category : #wired }
PLC_DataType >> acceptWire [
	"Responde true si el tipo de datos puede cablearse en 
	un lenguaje gráfico si es utilizado como pin de una POU.
	No tiene sentido en los lenguajes textuales."

	^ false.
]

{ #category : #compilation }
PLC_DataType >> cCompile [
	"Compila a C"

	^ self cCompileDataType.
]

{ #category : #compilation }
PLC_DataType >> cCompileDataType [
	"Compila a C"

	^ 'PLC_' , self keyword asString.
]

{ #category : #types }
PLC_DataType >> dataType [ 
	"Devuelve el nombre del tipo de dato."

	^ self keyword asString , ': ' , self description.
]

{ #category : #compilation }
PLC_DataType >> ilCompile [
	"Compila a IL"

	^ self ilCompileDataType.
]

{ #category : #compilation }
PLC_DataType >> ilCompileDataType [
	"Compila a IL"

	^ self keyword asString.
]
