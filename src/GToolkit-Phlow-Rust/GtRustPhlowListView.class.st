Class {
	#name : #GtRustPhlowListView,
	#superclass : #GtRustPhlowView,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #accessing }
GtRustPhlowListView class >> viewType [
	^ 'list_view'
]

{ #category : #converting }
GtRustPhlowListView >> asPhlowView [
	^ (self class environment at: #GtPhlowListView) new
		definingMethod: self sourceCode;
		title: self title;
		priority: self priority;
		items: [ GtPhlowRustVectorCollection new vector: self computeItems ];
		itemText: [ :eachItem | self computeItemText: eachItem ];
		send: [ :eachItem | self computeItemSend: eachItem ];
		actionUpdateButton
]

{ #category : #private }
GtRustPhlowListView >> computeItemSend: anAnyVecItem [
	^ GtRustPhlowObject
		fromOwnedHandle: (self ffiLibrary
			primPhlowListView: self
			computeItemSend: anAnyVecItem objectVec
			index: anAnyVecItem index - 1)
		library: self ffiLibrary
]

{ #category : #private }
GtRustPhlowListView >> computeItemText: anAnyVecItem [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowList: self
			computeItemText: aStringBox
			items: anAnyVecItem objectVec
			index: anAnyVecItem index - 1 ]
]

{ #category : #private }
GtRustPhlowListView >> computeItems [
	^ GtPhlowRustObjectVec
		fromOwnedHandle: (self ffiLibrary primPhlowListViewComputeItems: self)
		library: self ffiLibrary
]
