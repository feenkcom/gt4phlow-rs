Class {
	#name : #GtPhlowRustObjectVec,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustObjectVec class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'private - ffi' }
GtPhlowRustObjectVec class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_object_vec_drop(void* aHandle))
]

{ #category : #accessing }
GtPhlowRustObjectVec >> at: anIndex [
	^ GtPhlowRustObjectVecItem new
		objectVec: self;
		index: anIndex
]

{ #category : #'private - ffi' }
GtPhlowRustObjectVec >> primLength [
	^ self ffiCall: #(size_t phlow_object_vec_len(self))
]

{ #category : #accessing }
GtPhlowRustObjectVec >> size [
	^ self primLength
]
