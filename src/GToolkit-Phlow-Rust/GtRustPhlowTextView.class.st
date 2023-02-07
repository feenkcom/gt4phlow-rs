Class {
	#name : #GtRustPhlowTextView,
	#superclass : #GtRustPhlowView,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #accessing }
GtRustPhlowTextView class >> viewType [
	^ 'text_view'
]

{ #category : #converting }
GtRustPhlowTextView >> asPhlowView [
	^ (self class environment at: #GtPhlowTextView) new
		definingMethod: self sourceCode;
		title: self title;
		priority: self priority;
		text: [ self computeText asRopedText glamorousRegularFontAndSize ];
		actionUpdateButton
]

{ #category : #private }
GtRustPhlowTextView >> computeText [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowTextView: self
			computeText: aStringBox ]
]
