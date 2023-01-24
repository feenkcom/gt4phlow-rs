Class {
	#name : #GtPhlowRustView,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustView class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'private - ffi' }
GtPhlowRustView class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_view_drop(void* aHandle))
]

{ #category : #accessing }
GtPhlowRustView class >> viewType [
	^ self subclassResponsibility
]

{ #category : #converting }
GtPhlowRustView >> asPhlowView [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtPhlowRustView >> primGetPriority [
	^ self ffiCall: #(size_t phlow_view_get_priority(self))
]

{ #category : #'private - ffi' }
GtPhlowRustView >> primGetSourceCode: aGtBoxerString [
	^ self ffiCall: #(void phlow_view_get_source_code(self, GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustView >> primGetTitle: aGtBoxerString [
	^ self ffiCall: #(void phlow_view_get_title(self, GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustView >> primGetType: aGtBoxerString [
	^ self ffiCall: #(void phlow_view_get_type(self, GtBoxerString aGtBoxerString))
]

{ #category : #accessing }
GtPhlowRustView >> priority [
	^ self primGetPriority
]

{ #category : #accessing }
GtPhlowRustView >> sourceCode [
	| aSourceCode |
	aSourceCode := GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetSourceCode: aGtBoxerString ].
	^ GtPhlowRustSourceCode new sourceCode: aSourceCode
]

{ #category : #accessing }
GtPhlowRustView >> title [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetTitle: aGtBoxerString ]
]

{ #category : #accessing }
GtPhlowRustView >> type [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetType: aGtBoxerString ]
]
