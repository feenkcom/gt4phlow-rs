Class {
	#name : #GtPhlowRustRemoteObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'printString',
		'client',
		'rustValueType',
		'referenceCount',
		'shouldAutoRelease'
	],
	#category : #'GToolkit-Phlow-Rust-Remote'
}

{ #category : #accessing }
GtPhlowRustRemoteObject class >> finalizeResourceData: aResourceData [
	| id client |

	id := aResourceData first.
	client := aResourceData second.

	[ client releaseObject: id ]
		on: Error
		do: [ :anError | "connection error?" ].
]

{ #category : #accessing }
GtPhlowRustRemoteObject class >> fromDictionary: aDictionary client: aRemoteClient [
	^ self new
		id: (aDictionary at: 'id');
		rustValueType: (aDictionary at: 'object_type');
		rustToString: (aDictionary at: 'print_string');
		referenceCount: (aDictionary at: 'reference_count');
		client: aRemoteClient;
		autoRelease: (aDictionary at: 'should_auto_release')
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> autoRelease: aBoolean [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"
	
	shouldAutoRelease := aBoolean.
	shouldAutoRelease ifFalse: [ ^ self ].
	
	GtPhlowRustRemoteResourceManager addResource: self
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> client [
	^ client
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> gtInspectorTitleString [
	| limitedString limit |
	limit := 1000.
	limitedString := String 	
		streamContents: [ :s | self gtInspectorTitleStringOn: s ] 
		limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #printing }
GtPhlowRustRemoteObject >> gtInspectorTitleStringOn: aStream [
	aStream
		nextPutAll: self rustValueType;
		nextPutAll: ' (';
		nextPutAll: self rustToString;
		nextPutAll: ')'
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> gtMetaFor: aView [
	^ aView empty
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> gtRawFor: aView [
	^ aView empty
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> gtViewsFor: aView inContext: aContext [
	"Add the remote views from the rust object to the inspectors views"
	| resultingView inspectorViews |

	resultingView := super gtViewsFor: aView inContext: aContext.
	inspectorViews := resultingView originalView views.

	"Add the explicitly declarative views from the inspected object"
	inspectorViews addAll: (self remoteViewsFor: aView inContext: aContext).

	"Re-sort by priority"
	inspectorViews := inspectorViews sorted: [ :a :b | a priority < b priority ].
	resultingView originalView views: inspectorViews.
	^ resultingView
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> id [
	^ id
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> id: aNumber [
	id := aNumber
]

{ #category : #printing }
GtPhlowRustRemoteObject >> printOn: aStream [
	aStream nextPutAll: self rustToString
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> referenceCount [
	^ referenceCount
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> referenceCount: anObject [
	referenceCount := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> remoteViewsFor: aView inContext: aContext [
	^ client
		remoteViewsOf: id
		for: aView
		inContext: aContext
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> resourceData [
	^ { id . client }
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> rustToString [
	^ printString
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> rustToString: anObject [
	printString := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> rustValueType [
	^ rustValueType
]

{ #category : #accessing }
GtPhlowRustRemoteObject >> rustValueType: aString [
	rustValueType := aString
]
