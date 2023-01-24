Class {
	#name : #GtPhlowRustObject,
	#superclass : #GtBoxerValueBox,
	#instVars : [
		'phlowRustViews'
	],
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustObject class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'instance creation' }
GtPhlowRustObject class >> fromInt32: aNumber [
	^ self fromNativeHandle: (self primFromInt32: aNumber)
]

{ #category : #'private - ffi' }
GtPhlowRustObject class >> primFromInt32: aNumber [
	^ self ffiCall: #(void* phlow_to_object_i32(int32 aNumber))
]

{ #category : #'private - ffi' }
GtPhlowRustObject class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_object_drop(void* aHandle))
]

{ #category : #converting }
GtPhlowRustObject >> asPhlowObject [
	^ self
]

{ #category : #private }
GtPhlowRustObject >> createPhlowRustViews [
	<return: #Array of: #GtPhlowRustView>
	
	^ GtPhlowRustViews
		fromNativeHandle: self primGetViews
		during: [ :thePhlowViews | thePhlowViews popAll ]
]

{ #category : #printing }
GtPhlowRustObject >> gtInspectorTitleString [
	| limitedString limit |
	limit := 1000.
	limitedString := String 	
		streamContents: [ :s | self gtInspectorTitleStringOn: s ] 
		limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #printing }
GtPhlowRustObject >> gtInspectorTitleStringOn: aStream [
	aStream
		nextPutAll: self valueType;
		nextPutAll: ' (';
		nextPutAll: self toString;
		nextPutAll: ')'
]

{ #category : #'gt - extensions' }
GtPhlowRustObject >> gtRawFor: aView [
	^ aView empty
]

{ #category : #'gt - extensions' }
GtPhlowRustObject >> gtRustViewsFor: aView [
	"<gtView>"
	
	^ aView list
		title: 'Views';
		priority: 4;
		items: [ self phlowRustViews ];
		itemText: [ :each | each ]
]

{ #category : #'gt - extensions' }
GtPhlowRustObject >> gtViewMethodsFor: aView [
	"<gtView>"
	
	^ aView list
		title: 'View methods';
		priority: 5;
		items: [ self viewMethods ];
		itemText: [ :each | each fullName ]
]

{ #category : #'api - phlow' }
GtPhlowRustObject >> phlowRustViews [
	<return: #Array of: #GtPhlowRustView>

	^ phlowRustViews ifNil: [ phlowRustViews := self createPhlowRustViews ]
]

{ #category : #'private - ffi' }
GtPhlowRustObject >> primGetValueType: aGtBoxerString [
	^ self ffiCall: #(void phlow_object_get_value_type(self, GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustObject >> primGetViewMethods [
	^ self ffiCall: #(void* phlow_object_get_view_methods(self))
]

{ #category : #'private - ffi' }
GtPhlowRustObject >> primGetViews [
	^ self ffiCall: #(void* phlow_object_get_views(self))
]

{ #category : #'private - ffi' }
GtPhlowRustObject >> primToString: aGtBoxerString [
	^ self ffiCall: #(void phlow_object_to_string(self, GtBoxerString aGtBoxerString))
]

{ #category : #printing }
GtPhlowRustObject >> printOn: aStream [
	aStream nextPutAll: self toString
]

{ #category : #'api - phlow' }
GtPhlowRustObject >> rustPhlowViewsFor: aView inContext: aContext [
	^ self phlowRustViews
		collect: [ :each | each asPhlowView ]
]

{ #category : #printing }
GtPhlowRustObject >> toString [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primToString: aGtBoxerString ]
]

{ #category : #printing }
GtPhlowRustObject >> valueType [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primGetValueType: aGtBoxerString ]
]

{ #category : #private }
GtPhlowRustObject >> viewMethods [
	<return: #Array of: #GtPhlowRustViewMethod>
	
	^ GtPhlowRustViewMethods
		fromNativeHandle: self primGetViewMethods
		during: [ :theViewMethods | theViewMethods popAll ]
]
