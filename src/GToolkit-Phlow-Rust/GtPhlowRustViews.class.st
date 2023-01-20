Class {
	#name : #GtPhlowRustViews,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Phlow-Rust-External'
}

{ #category : #accessing }
GtPhlowRustViews class >> ffiLibrary [
	^ GtPhlowRustLibrary
]

{ #category : #'private - ffi' }
GtPhlowRustViews class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void phlow_views_drop(void* aHandle))
]

{ #category : #accessing }
GtPhlowRustViews >> pop [
	<return: #GtPhlowRustView or: nil>
	| aHandle aBaseView aViewType |

	aHandle := self primPop.
	aHandle isNull
		ifTrue: [ ^ nil ].
	
	aBaseView := GtPhlowRustView fromHandle: aHandle.

	aViewType := aBaseView type.
	aViewType = 'list_view'
		ifTrue: [ ^ GtPhlowRustListView fromNativeHandle: aHandle ].
		
	self error: ('Unsupported view type: {1}' format: { aViewType })
]

{ #category : #accessing }
GtPhlowRustViews >> popAll [
	^ Array streamContents: [ :aStream |
		[
			| aMethod |
			aMethod := self pop.
			aMethod isNil
				ifTrue: [ false ]
				ifFalse: [
					aStream nextPut: aMethod.
					true
				] ] whileTrue ]
]

{ #category : #'private - ffi' }
GtPhlowRustViews >> primPop [
	^ self ffiCall: #(void* phlow_views_pop(self))
]
