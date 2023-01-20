Class {
	#name : #GtPhlowRustViewMethods,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustViewMethods class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'private - ffi' }
GtPhlowRustViewMethods class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_view_methods_drop(void* aHandle))
]

{ #category : #accessing }
GtPhlowRustViewMethods >> pop [
	^ GtPhlowRustViewMethod fromNativeHandle: self primPop
]

{ #category : #accessing }
GtPhlowRustViewMethods >> popAll [
	^ Array streamContents: [ :aStream |
		[
			| aMethod |
			aMethod := self pop.
			aMethod isNull
				ifTrue: [ false ]
				ifFalse: [
					aStream nextPut: aMethod.
					true
				] ] whileTrue ]
]

{ #category : #'private - ffi' }
GtPhlowRustViewMethods >> primPop [
	^ self ffiCall: #(void* phlow_view_methods_pop(self))
]
