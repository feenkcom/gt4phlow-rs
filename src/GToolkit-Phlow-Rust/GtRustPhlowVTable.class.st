Class {
	#name : #GtRustPhlowVTable,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #'as yet unclassified' }
GtRustPhlowVTable class >> primRelease: aHandle library: anFFILibrary [
	"External objects must be released using a specific method from the ffi library similar to:"
	"self ffiCall: #(void lib_object_drop(void* aHandle))"

	anFFILibrary primPhlowVTableRelease: aHandle
]

{ #category : #'as yet unclassified' }
GtRustPhlowVTable >> primGetPhlowVTable [
	^ self ffiCall: #(void* phlow_get_vtable_of_phlow_vtable(self))
]

{ #category : #'as yet unclassified' }
GtRustPhlowVTable >> supportsToString [
	^ self ffiLibrary primPhlowVTableSupportsToString: self
]

{ #category : #'as yet unclassified' }
GtRustPhlowVTable >> supportsTypeName [
	^ self ffiLibrary primPhlowVTableSupportsTypeName: self
]
