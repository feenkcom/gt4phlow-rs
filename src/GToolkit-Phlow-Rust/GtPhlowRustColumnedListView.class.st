Class {
	#name : #GtPhlowRustColumnedListView,
	#superclass : #GtPhlowRustView,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustColumnedListView class >> viewType [
	^ 'columned_list_view'
]

{ #category : #converting }
GtPhlowRustColumnedListView >> asPhlowView [
	| aColumnedListView |

	aColumnedListView := GtPhlowColumnedListView new.
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

	^ aColumnedListView
]

{ #category : #private }
GtPhlowRustColumnedListView >> computeAmountOfColumns [
	^ self primAmountOfColumns
]

{ #category : #private }
GtPhlowRustColumnedListView >> computeCellText: anAnyVecItem columnIndex: aColumnIndex [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString |
		self
			primComputeCellText: aGtBoxerString
			items: anAnyVecItem objectVec 
			row: anAnyVecItem index - 1
			column: aColumnIndex - 1 ]
]

{ #category : #private }
GtPhlowRustColumnedListView >> computeColumnTitleAt: aColumnIndex [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString |
		self
			primComputeColumnTitle: aGtBoxerString
			index: aColumnIndex - 1 ]
]

{ #category : #private }
GtPhlowRustColumnedListView >> computeItemSend: anAnyVecItem [
	^ GtPhlowRustObject fromNativeHandle:
		(self primComputeItemSend: anAnyVecItem objectVec index: anAnyVecItem index - 1)
]

{ #category : #private }
GtPhlowRustColumnedListView >> computeItems [
	^ GtPhlowRustObjectVec fromNativeHandle: self primComputeItems
]

{ #category : #'private - ffi' }
GtPhlowRustColumnedListView >> primAmountOfColumns [
	^ self ffiCall: #(size_t phlow_columned_list_get_columns_len(self))
]

{ #category : #'private - ffi' }
GtPhlowRustColumnedListView >> primComputeCellText: aGtBoxerString items: anAnyVec row: aRowIndex column: aColumnIndex [
	^ self ffiCall: #(void phlow_columned_list_view_compute_item_text_at (
		self,
		GtPhlowRustObjectVec anAnyVec,
		size_t aRowIndex,
		size_t aColumnIndex,
		GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustColumnedListView >> primComputeColumnTitle: aGtBoxerString index: aColumnIndex [
	^ self ffiCall: #(void phlow_columned_list_get_column_title(
		self,
		size_t aColumnIndex,
		GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustColumnedListView >> primComputeItemSend: anAnyVec index: anIndex [
	^ self ffiCall: #(void* phlow_columned_list_view_compute_item_send_at (
		self,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex))
]

{ #category : #'private - ffi' }
GtPhlowRustColumnedListView >> primComputeItems [
	^ self ffiCall: #(void* phlow_columned_list_view_compute_items(self))
]
