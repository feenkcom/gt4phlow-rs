Class {
	#name : #GtPhlowRustRemoteDataSource,
	#superclass : #Object,
	#instVars : [
		'methodSelector',
		'objectId',
		'client',
		'items',
		'objects'
	],
	#category : #'GToolkit-Phlow-Rust-Remote'
}

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> client [
	^ client
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> flushItemsIterator [
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> objectId [
	^ objectId
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> objectId: anObject [
	objectId := anObject
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> retrieveItems: anItemsCount fromIndex: startIndex [
	startIndex > 1
		ifTrue: [ ^ #() ].

	items ifNil: [
		items := client
			retrieveViewItems: objectId
			methodSelector: methodSelector.
		
		objects := items collect: [ :item | GtPhlowRustRemoteObject fromDictionary: (item at: 'phlowObject') client: client ] ].

	^ items
]

{ #category : #accessing }
GtPhlowRustRemoteDataSource >> retriveSentItemAt: anInteger [
	^ GtPhlowRustRemoteObject
		fromDictionary: (client
			retrieveViewSentItem: objectId
			methodSelector: methodSelector
			selectedObjectId: (objects at: anInteger) id)
		client: client
]
