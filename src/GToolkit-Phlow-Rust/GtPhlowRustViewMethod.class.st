Class {
	#name : #GtPhlowRustViewMethod,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustViewMethod class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'private - ffi' }
GtPhlowRustViewMethod class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_view_method_drop(void* aHandle))
]

{ #category : #'api - accessing' }
GtPhlowRustViewMethod >> fullName [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetFullName: aGtBoxerString ]
]

{ #category : #'api - accessing' }
GtPhlowRustViewMethod >> name [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetName: aGtBoxerString ]
]

{ #category : #'private - ffi' }
GtPhlowRustViewMethod >> primGetFullName: aGtBoxerString [
	^ self ffiCall: #(void phlow_view_method_get_full_name(self, GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustViewMethod >> primGetName: aGtBoxerString [
	^ self ffiCall: #(void phlow_view_method_get_name(self, GtBoxerString aGtBoxerString))
]
