Class {
	#name : #GtRustPhlowObject,
	#superclass : #Object,
	#instVars : [
		'phlowRustViews',
		'vtable',
		'rustObject'
	],
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #converting }
GtRustPhlowObject >> asPhlowObjectDo: aBlock ifNone: aNoneBlock [
	^ aBlock value: self
]

{ #category : #'as yet unclassified' }
GtRustPhlowObject >> ffiLibrary [
	^ rustObject ffiLibrary
]

{ #category : #'as yet unclassified' }
GtRustPhlowObject >> forTypedObject: typedBlock forAnyObject: anyBlock [
	^ (rustObject isKindOf: GtRustPhlowAnyObject)
		ifTrue: [ anyBlock cull: rustObject ]
		ifFalse: [ typedBlock cull: rustObject ]
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

{ #category : #'as yet unclassified' }
GtRustPhlowObject >> gtViewsFor: aView inContext: aContext [
	"Add the declarative views from the inspectors object to the inspectors views"
	| resultingView inspectorViews |

	resultingView := super gtViewsFor: aView inContext: aContext.
	inspectorViews := resultingView originalView views.

	"Add the explicitly declarative views from the inspected object"
	inspectorViews addAll: (self rustPhlowViewsFor: aView inContext: aContext).

	"Re-sort by priority"
	inspectorViews := inspectorViews sorted: [ :a :b | a priority < b priority ].
	resultingView originalView views: inspectorViews.
	^ resultingView
]

{ #category : #printing }
GtRustPhlowObject >> printOn: aStream [
	aStream nextPutAll: self rustToString
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustPhlowViews [
	<return: #Array of: #GtRustPhlowView>

	^ phlowRustViews ifNil: [ phlowRustViews := self ffiLibrary phlowVTable: vtable views: rustObject ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustPhlowViewsFor: aView inContext: aContext [
	^ self rustPhlowViews collect: [ :each | each asPhlowView ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustToString [
	<return: #String>
	^ self ffiLibrary
		getStringFrom: [ :aStringBox | 
			self
				forTypedObject: [ :aRustObject | 
					self ffiLibrary
						primPhlowVTable: vtable
						toString: aStringBox
						forTypedObject: aRustObject ]
				forAnyObject: [ :aRustObject | 
					self ffiLibrary
						primPhlowVTable: vtable
						toString: aStringBox
						forAnyObject: aRustObject ] ]
]

{ #category : #'api - rust' }
GtRustPhlowObject >> rustValueType [
	<return: #String>

	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowVTable: vtable
			getValueType: aStringBox ]
]

{ #category : #'as yet unclassified' }
GtRustPhlowObject >> valueBox: aValueBox vtable: aVTable [
	rustObject := aValueBox.
	vtable := aVTable
]
