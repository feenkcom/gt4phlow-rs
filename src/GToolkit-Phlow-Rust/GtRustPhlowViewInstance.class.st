Class {
	#name : #GtRustPhlowViewInstance,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #'as yet unclassified' }
GtRustPhlowViewInstance class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPhlowViewInstanceRelease: aHandle
]
