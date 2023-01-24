Class {
	#name : #GtPhlowRustSourceCode,
	#superclass : #Object,
	#instVars : [
		'sourceCode'
	],
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #'as yet unclassified' }
GtPhlowRustSourceCode >> gtPhlowIncludesCompiledMethod: aCompiledMethod [ 
	^ false
]

{ #category : #accessing }
GtPhlowRustSourceCode >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtPhlowRustSourceCode >> sourceCode: anObject [
	sourceCode := anObject
]
