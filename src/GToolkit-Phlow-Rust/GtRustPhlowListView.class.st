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
		items: [ 1 to: self itemsCount ];
		itemText: [ :anIndex | self itemTextAt: anIndex ];
		send: [ :anIndex | self itemSendAt: anIndex ];
		actionUpdateButton
]

{ #category : #private }
GtRustPhlowListView >> itemSendAt: anIndex [
	| aHandle |
	aHandle := self ffiLibrary
			primPhlowListViewInstance: self rustViewInstance
			getSendAt: anIndex - 1.

	^ GtRustPhlowAnyObject fromOwnedHandle: aHandle library: self ffiLibrary
]

{ #category : #private }
GtRustPhlowListView >> itemTextAt: anIndex [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowListViewInstance: self rustViewInstance
			getItemText: aStringBox
			index: anIndex - 1 ]
]

{ #category : #private }
GtRustPhlowListView >> itemsCount [
	^ self ffiLibrary primPhlowListViewInstanceItemsCount: self rustViewInstance
]
