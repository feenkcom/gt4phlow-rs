Class {
	#name : #GtPhlowRustVectorCollection,
	#superclass : #SequenceableCollection,
	#instVars : [
		'vector'
	],
	#category : #'GToolkit-Phlow-Rust-Utilities'
}

{ #category : #adding }
GtPhlowRustVectorCollection >> add: newObject [ 
	"Include newObject as one of the receiver's elements. Answer newObject. 
	ArrayedCollections cannot respond to this message."

	self shouldNotImplement
]

{ #category : #accessing }
GtPhlowRustVectorCollection >> at: anIndex [
	^ vector at: anIndex
]

{ #category : #accessing }
GtPhlowRustVectorCollection >> size [
	^ vector size
]

{ #category : #accessing }
GtPhlowRustVectorCollection >> vector [
	^ vector
]

{ #category : #accessing }
GtPhlowRustVectorCollection >> vector: anObject [
	vector := anObject
]
