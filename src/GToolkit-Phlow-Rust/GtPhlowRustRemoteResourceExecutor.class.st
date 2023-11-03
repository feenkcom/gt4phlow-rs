Class {
	#name : #GtPhlowRustRemoteResourceExecutor,
	#superclass : #Object,
	#instVars : [
		'session',
		'data',
		'resourceClass'
	],
	#category : #'GToolkit-Phlow-Rust-Remote'
}

{ #category : #finalization }
GtPhlowRustRemoteResourceExecutor >> finalize [ 
	session = Smalltalk session ifFalse: [ ^ self ].		
	resourceClass finalizeResourceData: data
]

{ #category : #initialization }
GtPhlowRustRemoteResourceExecutor >> initialize [ 
	super initialize.
	session := Smalltalk session
]

{ #category : #initialization }
GtPhlowRustRemoteResourceExecutor >> resourceClass: aResourceClass data: aData [
	resourceClass := aResourceClass.
	data := aData
]
