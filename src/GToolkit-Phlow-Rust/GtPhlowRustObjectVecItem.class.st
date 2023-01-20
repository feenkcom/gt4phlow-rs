Class {
	#name : #GtPhlowRustObjectVecItem,
	#superclass : #Object,
	#instVars : [
		'anyVec',
		'index'
	],
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustObjectVecItem >> index [
	^ index
]

{ #category : #accessing }
GtPhlowRustObjectVecItem >> index: anObject [
	index := anObject
]

{ #category : #accessing }
GtPhlowRustObjectVecItem >> objectVec [
	^ anyVec
]

{ #category : #accessing }
GtPhlowRustObjectVecItem >> objectVec: anObject [
	anyVec := anObject
]
