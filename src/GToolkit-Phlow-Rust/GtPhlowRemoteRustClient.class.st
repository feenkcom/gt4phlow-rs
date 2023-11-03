Class {
	#name : #GtPhlowRemoteRustClient,
	#superclass : #Object,
	#instVars : [
		'port',
		'sessionId',
		'serverId'
	],
	#category : #'GToolkit-Phlow-Rust-Remote'
}

{ #category : #accessing }
GtPhlowRemoteRustClient class >> connectTo: aPortNumber [
	^ self new connectTo: aPortNumber
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> connectTo: aNumber [
	port := aNumber.
	sessionId := self retrieveSession.
	serverId := self retrieveServerId
]

{ #category : #private }
GtPhlowRemoteRustClient >> connection [
	^ ZnClient new
		enforceHttpSuccess: false;
		beOneShot;
		accept: ZnMimeType applicationJson;
		host: 'localhost';
		port: port
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> gtPhlowObjectsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Objects';
		priority: 9;
		items: [ self objectsStream ];
		column: 'Id' text: [ :each | each id ];
		column: 'Type' text: [ :each | each rustValueType ];
		column: 'Print String' text: [ :each | each rustToString ];
		column: 'RefCount' text: [ :each | each referenceCount ] width: 70;
		send: [ :each | self remoteObjectById: each id ];
		actionUpdateButton
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> gtViewsFor: aView inContext: aContext [
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
GtPhlowRemoteRustClient >> initializeForPort: aNumber [
	port := aNumber
]

{ #category : #private }
GtPhlowRemoteRustClient >> objectsStream [
	^ [ self retrieveObjects asAsyncStream ] asAsyncFuture asAsyncStream flatten
		collect: [ :eachDictionary | GtPhlowRustRemoteObject fromDictionary: eachDictionary client: self ]
]

{ #category : #private }
GtPhlowRemoteRustClient >> releaseObject: anObjectId [
	| response |
	response := self connection
			delete: ('session/{1}/objects/{2}'
					format: {sessionId.
							anObjectId});
			response.
	^ response
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> remoteObjectById: anObjectId [
	^ GtPhlowRustRemoteObject
		fromDictionary: (self retrieveObject: anObjectId)
		client: self
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> remoteViewsFor: aView inContext: aContext [
	^ self
		remoteViewsOf: serverId
		for: aView
		inContext: aContext
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> remoteViewsOf: anObjectId for: aView inContext: aContext [
	^ (self remoteViewsSpecificationsOf: anObjectId)
		collect: [ :eachViewSpecification | eachViewSpecification viewFor: aView ]
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> remoteViewsSpecificationsOf: anObjectId [
	^ (self retrievePhlowObjectViews: anObjectId)
		collect: [ :eachDictionary | 
			| eachView |
			eachView := GtPhlowViewSpecification fromDictionary: eachDictionary.
			eachView phlowDataSource: (GtPhlowRustRemoteDataSource new
				objectId: anObjectId;
				methodSelector: eachView methodSelector;
				client: self).

			eachView ]
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrieveObject: anObjectId [
	^ STONJSON
		fromString: (self connection get: ('objects/{1}' format: {anObjectId})) contents
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrieveObjects [
	^ STONJSON fromString: (self connection get: 'objects') contents
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrievePhlowObjectViews: anObjectId [
	^ STONJSON fromString: (self connection get: ('objects/{1}/views' format: { anObjectId })) contents
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrieveServerId [
	^ STONJSON fromString: (self connection get: 'id') contents
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrieveSession [
	^ STONJSON fromString: (self connection get: 'session') contents
]

{ #category : #private }
GtPhlowRemoteRustClient >> retrieveViewItems: anObjectId methodSelector: aMethodSelector [
	^ STONJSON fromString: (self connection get: ('objects/{1}/views/{2}/items' format: { anObjectId . aMethodSelector})) contents
]

{ #category : #accessing }
GtPhlowRemoteRustClient >> retrieveViewSentItem: anInspectedObjectId methodSelector: aMethodSelector selectedObjectId: aSelectedObjectId [
	^ STONJSON
		fromString: (self connection
				get: ('objects/{1}/views/{2}/send/{3}'
						format: {anInspectedObjectId.
								aMethodSelector.
								aSelectedObjectId})) contents
]
