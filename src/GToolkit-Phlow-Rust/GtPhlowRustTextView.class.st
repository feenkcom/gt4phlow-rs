Class {
	#name : #GtPhlowRustTextView,
	#superclass : #GtPhlowRustView,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustTextView class >> viewType [
	^ 'text_view'
]

{ #category : #converting }
GtPhlowRustTextView >> asPhlowView [
	^ GtPhlowTextView new
		definingMethod: self sourceCode;
		title: self title;
		priority: self priority;
		text: [ self computeText ]
]

{ #category : #private }
GtPhlowRustTextView >> computeText [
	^ GtBoxerString getStringFrom: [ :aGtBoxerString | self primComputeText: aGtBoxerString ]
]

{ #category : #'private - ffi' }
GtPhlowRustTextView >> primComputeText: aGtBoxerString [
	^ self ffiCall: #(void phlow_text_view_compute_text(self, GtBoxerString aGtBoxerString))
]
