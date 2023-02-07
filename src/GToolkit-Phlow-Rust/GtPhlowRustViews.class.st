Class {
	#name : #GtPhlowRustViews,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Phlow-Rust-Utilities'
}

{ #category : #'private - ffi' }
GtPhlowRustViews class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPhlowViewsRelease: aHandle
]

{ #category : #accessing }
GtPhlowRustViews >> pop [
	<return: #GtRustPhlowView or: nil>
	| aHandle aBaseView aViewType |

	aHandle := self ffiLibrary primPhlowViewsPop: self.
	aHandle isNull
		ifTrue: [ ^ nil ].
	
	aBaseView := GtRustPhlowView
		fromBorrowedHandle: aHandle
		library: self ffiLibrary.

	aViewType := aBaseView type.

	^ GtRustPhlowView allSubclasses
		detect: [ :eachPhlowClass | eachPhlowClass viewType = aViewType ]
		ifFound: [ :aPhlowViewClass | aPhlowViewClass fromOwnedHandle: aHandle library: self ffiLibrary ]
		ifNone: [
			aBaseView release.
			self error: ('Unsupported view type: {1}' format: { aViewType }) ]
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
