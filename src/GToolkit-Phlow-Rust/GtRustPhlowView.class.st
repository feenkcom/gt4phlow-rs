Class {
	#name : #GtRustPhlowView,
	#superclass : #GtExternalLibraryBox,
	#instVars : [
		'rustViewInstance',
		'rustObject'
	],
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #'private - ffi' }
GtRustPhlowView class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPhlowViewRelease: aHandle
]

{ #category : #accessing }
GtRustPhlowView class >> viewType [
	^ self subclassResponsibility
]

{ #category : #converting }
GtRustPhlowView >> asPhlowView [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtRustPhlowView >> createRustViewInstance [
	| aHandle |
	aHandle := self
			forTypedObject: [ :anObject | self ffiLibrary primPhlowView: self createInstanceForTypedObject: anObject ]
			forAnyObject: [ :anObject | self ffiLibrary primPhlowView: self createInstanceForAnyObject: anObject ].

	^ GtRustPhlowViewInstance fromOwnedHandle: aHandle library: self ffiLibrary
]

{ #category : #'as yet unclassified' }
GtRustPhlowView >> forTypedObject: typedBlock forAnyObject: anyBlock [
	^ (rustObject isKindOf: GtRustPhlowAnyObject)
		ifTrue: [ anyBlock cull: rustObject ]
		ifFalse: [ typedBlock cull: rustObject ].
]

{ #category : #accessing }
GtRustPhlowView >> priority [
	^ self ffiLibrary primPhlowViewGetPriority: self
]

{ #category : #accessing }
GtRustPhlowView >> rustObject [
	^ rustObject
]

{ #category : #accessing }
GtRustPhlowView >> rustObject: anObject [
	rustObject := anObject
]

{ #category : #'as yet unclassified' }
GtRustPhlowView >> rustViewInstance [
	^ rustViewInstance ifNil: [ rustViewInstance := self createRustViewInstance ]
]

{ #category : #accessing }
GtRustPhlowView >> sourceCode [
	| aSourceCode |

	aSourceCode := self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowView: self
			getSourceCode: aStringBox ].

	^ GtPhlowRustSourceCode new sourceCode: aSourceCode
]

{ #category : #accessing }
GtRustPhlowView >> title [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowView: self
			getTitle: aStringBox ]
]

{ #category : #accessing }
GtRustPhlowView >> type [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowView: self
			getType: aStringBox ]
]
