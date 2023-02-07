Class {
	#name : #GtPhlowRustObjectVec,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Phlow-Rust-Utilities'
}

{ #category : #'private - ffi' }
GtPhlowRustObjectVec class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPhlowObjectVecRelease: aHandle
]

{ #category : #accessing }
GtPhlowRustObjectVec >> at: anIndex [
	^ GtPhlowRustObjectVecItem new
		objectVec: self;
		index: anIndex
]

{ #category : #accessing }
GtPhlowRustObjectVec >> size [
	^ self ffiLibrary primPhlowObjectVecGetLength: self
]
