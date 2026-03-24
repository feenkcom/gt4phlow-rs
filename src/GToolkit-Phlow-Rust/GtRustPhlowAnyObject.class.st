Class {
	#name : #GtRustPhlowAnyObject,
	#superclass : #GtExternalLibraryBox,
	#instVars : [
		'vtable'
	],
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #'private - ffi' }
GtRustPhlowAnyObject class >> primRelease: aHandle library: anFFILibrary [
	"External objects must be released using a specific method from the ffi library similar to:"
	"self ffiCall: #(void lib_object_drop(void* aHandle))"

	anFFILibrary primPhlowAnyObjectRelease: aHandle
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> gtInspectorTitleString [
	| limitedString limit |
	limit := 1000.
	limitedString := String 	
		streamContents: [ :s | self gtInspectorTitleStringOn: s ] 
		limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> gtInspectorTitleStringOn: aStream [
	aStream
		nextPutAll: self rustValueType;
		nextPutAll: ' (';
		nextPutAll: self rustToString;
		nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> gtPrintFor: aView [
	^ (self vtable isNil or: [ self vtable supportsToString not ])
		ifTrue: [ aView empty ]
		ifFalse: [ super gtPrintFor: aView ]
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> gtRawFor: aView [
	^ aView empty
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> primGetPhlowVTable [
	^ self ffiLibrary primPhlowGetVTableOfAnyObject: self
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> printOn: aStream [
	(self vtable isNil or: [ self vtable supportsToString not ])
		ifTrue: [ super printOn: aStream ]
		ifFalse: [ self rustPrintOn: aStream ]
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> rustPrintOn: aStream [
	<return: #String>
	
	aStream nextPutAll: (self ffiLibrary
		getStringFrom: [ :aStringBox | 
			self ffiLibrary
				primPhlowVTable: self vtable
				toString: aStringBox
				forAnyObject: self ])
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> rustToString [
	<return: #String>
	
	(self vtable isNil or: [ self vtable supportsToString not ])
		ifTrue: [ ^ self printString ].
	
	^ String streamContents: [ :aStream | self rustPrintOn: aStream ]
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> rustValueType [
	<return: #String>
	
	(self vtable isNil or: [ self vtable supportsTypeName not ])
		ifTrue: [ ^ self class name ].

	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowVTable: self vtable
			getValueType: aStringBox ]
]

{ #category : #'as yet unclassified' }
GtRustPhlowAnyObject >> vtable [
	^ vtable ifNil: [ vtable := self phlowVTable ]
]
