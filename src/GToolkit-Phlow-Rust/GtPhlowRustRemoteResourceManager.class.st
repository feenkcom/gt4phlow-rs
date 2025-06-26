Class {
	#name : #GtPhlowRustRemoteResourceManager,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Rust-Remote'
}

{ #category : #'resource management' }
GtPhlowRustRemoteResourceManager class >> addResource: anObject [ 
	self uniqueInstance addResource: anObject 
]

{ #category : #'resource management' }
GtPhlowRustRemoteResourceManager class >> addResource: anObject data: aData [
	self uniqueInstance addResource: anObject data: aData
]

{ #category : #'resource management' }
GtPhlowRustRemoteResourceManager class >> addResource: anObject executor: anExecutor [
	self uniqueInstance addResource: anObject executor: anExecutor
]

{ #category : #'class initialization' }
GtPhlowRustRemoteResourceManager class >> reset [
	uniqueInstance := nil
]

{ #category : #accessing }
GtPhlowRustRemoteResourceManager class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance  := super new ]
]

{ #category : #'external resource management' }
GtPhlowRustRemoteResourceManager >> addResource: anObject [
	^ self addResource: anObject data: anObject resourceData
]

{ #category : #'external resource management' }
GtPhlowRustRemoteResourceManager >> addResource: anObject data: resourceData [
	registry 
		add: anObject 
		executor: (GtPhlowRustRemoteResourceExecutor new 
			resourceClass: anObject class
			data: resourceData)
]

{ #category : #'external resource management' }
GtPhlowRustRemoteResourceManager >> addResource: anObject executor: anExecutor [
	registry add: anObject executor: anExecutor
]

{ #category : #initialization }
GtPhlowRustRemoteResourceManager >> initialize [ 
	registry := FinalizationRegistry new.
]
