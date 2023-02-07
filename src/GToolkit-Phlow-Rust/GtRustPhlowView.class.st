Class {
	#name : #GtRustPhlowView,
	#superclass : #GtExternalLibraryBox,
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

{ #category : #accessing }
GtRustPhlowView >> priority [
	^ self ffiLibrary primPhlowViewGetPriority: self
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
