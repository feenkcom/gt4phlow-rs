Class {
	#name : #GtRustPhlowColumnedListView,
	#superclass : #GtRustPhlowView,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #accessing }
GtRustPhlowColumnedListView class >> viewType [
	^ 'columned_list_view'
]

{ #category : #converting }
GtRustPhlowColumnedListView >> asPhlowView [
	| aColumnedListView |

	aColumnedListView := (self class environment at: #GtPhlowColumnedListView) new.
	aColumnedListView
		definingMethod: self sourceCode;
		title: self title;
		priority: self priority;
		items: [ GtPhlowRustVectorCollection new vector: self computeItems ];
		send: [ :eachItem | self computeItemSend: eachItem ].

	1 to: self computeAmountOfColumns do: [ :aColumnIndex |
		aColumnedListView
			column: (self computeColumnTitleAt: aColumnIndex)
			text: [ :eachItem | self computeCellText: eachItem columnIndex: aColumnIndex ] ].
	
	aColumnedListView actionUpdateButton.

	^ aColumnedListView
]

{ #category : #private }
GtRustPhlowColumnedListView >> computeAmountOfColumns [
	^ self ffiLibrary primPhlowColumnedListGetAmountOfColumns: self
]

{ #category : #private }
GtRustPhlowColumnedListView >> computeCellText: anAnyVecItem columnIndex: aColumnIndex [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
		primPhlowColumnedList: self
		computeCellText: aStringBox
		items: anAnyVecItem objectVec 
		row: anAnyVecItem index - 1
		column: aColumnIndex - 1 ]
]

{ #category : #private }
GtRustPhlowColumnedListView >> computeColumnTitleAt: aColumnIndex [		
	^ self ffiLibrary getStringFrom: [ :aStringBox | self ffiLibrary
		primPhlowColumnedList: self
		computeColumnTitle: aStringBox
		index: aColumnIndex - 1 ]
]

{ #category : #private }
GtRustPhlowColumnedListView >> computeItemSend: anAnyVecItem [
	^ GtRustPhlowObject
		fromOwnedHandle: (self ffiLibrary
			primPhlowColumnedListView: self
			computeItemSend: anAnyVecItem objectVec
			index: anAnyVecItem index - 1)
		library: self ffiLibrary
]

{ #category : #private }
GtRustPhlowColumnedListView >> computeItems [
	^ GtPhlowRustObjectVec
		fromOwnedHandle: (self ffiLibrary primPhlowColumnedListViewComputeItems: self)
		library: self ffiLibrary
]
