Class {
	#name : #GtPhlowRustListView,
	#superclass : #GtPhlowRustView,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #converting }
GtPhlowRustListView >> asPhlowView [
	^ GtPhlowListView new
		title: self title;
		priority: self priority;
		items: [ GtPhlowRustVectorCollection new vector: self computeItems ];
		itemText: [ :eachItem | self computeItemText: eachItem ];
		send: [ :eachItem | self computeItemSend: eachItem ]
]

{ #category : #private }
GtPhlowRustListView >> computeItemSend: anAnyVecItem [
	^ GtPhlowRustObject fromNativeHandle:
		(self primComputeItemSend: anAnyVecItem objectVec index: anAnyVecItem index - 1)
]

{ #category : #private }
GtPhlowRustListView >> computeItemText: anAnyVecItem [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString |
		self
			primComputeItemText: aGtBoxerString
			items: anAnyVecItem objectVec 
			index: anAnyVecItem index - 1 ]
]

{ #category : #private }
GtPhlowRustListView >> computeItems [
	^ GtPhlowRustObjectVec fromNativeHandle: self primComputeItems
]

{ #category : #'private - ffi' }
GtPhlowRustListView >> primComputeItemSend: anAnyVec index: anIndex [
	^ self ffiCall: #(void* phlow_list_view_compute_item_send_at (
		self,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex))
]

{ #category : #'private - ffi' }
GtPhlowRustListView >> primComputeItemText: aGtBoxerString items: anAnyVec index: anIndex [
	^ self ffiCall: #(void phlow_list_view_compute_item_text_at (
		self,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex,
		GtBoxerString aGtBoxerString))
]

{ #category : #'private - ffi' }
GtPhlowRustListView >> primComputeItems [
	^ self ffiCall: #(void* phlow_list_view_compute_items(self))
]
