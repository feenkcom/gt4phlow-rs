Class {
	#name : #GtRustPhlowObject,
	#superclass : #GtExternalLibraryBox,
	#instVars : [
		'phlowRustViews'
	],
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #'private - ffi' }
GtRustPhlowObject class >> primRelease: aHandle library: anFFILibrary [
	"External objects must be released using a specific method from the ffi library similar to:"
	"self ffiCall: #(void lib_object_drop(void* aHandle))"

	anFFILibrary primPhlowObjectRelease: aHandle
]

{ #category : #converting }
GtRustPhlowObject >> asPhlowObjectDo: aBlock ifNone: aNoneBlock [
	^ aBlock value: self
]

{ #category : #printing }
GtRustPhlowObject >> gtInspectorTitleString [
	| limitedString limit |
	limit := 1000.
	limitedString := String 	
		streamContents: [ :s | self gtInspectorTitleStringOn: s ] 
		limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #printing }
GtRustPhlowObject >> gtInspectorTitleStringOn: aStream [
	aStream
		nextPutAll: self rustValueType;
		nextPutAll: ' (';
		nextPutAll: self rustToString;
		nextPutAll: ')'
]

{ #category : #'gt - extensions' }
GtRustPhlowObject >> gtRawFor: aView [
	^ aView empty
]

{ #category : #printing }
GtRustPhlowObject >> printOn: aStream [
	aStream nextPutAll: self rustToString
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustPhlowViews [
	<return: #Array of: #GtRustPhlowView>

	^ phlowRustViews ifNil: [ phlowRustViews := self ffiLibrary phlowObjectGetViews: self ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustPhlowViewsFor: aView inContext: aContext [
	^ self rustPhlowViews collect: [ :each | each asPhlowView ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustToString [
	<return: #String>

	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowObject: self
			toString: aStringBox ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustValueType [
	<return: #String>

	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowObject: self
			getValueType: aStringBox ]
]
