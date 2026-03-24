Class {
	#name : #GtRustPhlowInfoView,
	#superclass : #GtRustPhlowView,
	#category : #'GToolkit-Phlow-Rust-Core'
}

{ #category : #accessing }
GtRustPhlowInfoView class >> viewType [
	^ 'info_view'
]

{ #category : #converting }
GtRustPhlowInfoView >> asPhlowView [
	^ GtPhlowColumnedListView new
		definingMethod: self sourceCode;
		title: self title;
		priority: self priority;
		items: [ 1 to: self getRowsCount ];
		column: 'Name' text: [ :anIndex | self getRowNameAt: anIndex ];
		column: 'Value' text: [ :anIndex | self getRowValueTextAt: anIndex ];
		send: [ :anIndex | self getRowSendAt: anIndex ];
		actionUpdateButton
]

{ #category : #private }
GtRustPhlowInfoView >> getRowNameAt: anIndex [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowInfoViewInstance: self rustViewInstance
			getRowName: aStringBox
			index: anIndex - 1 ]
]

{ #category : #private }
GtRustPhlowInfoView >> getRowSendAt: anIndex [
	| aHandle |
	aHandle := self
			forTypedObject: [ :anObject | 
				self ffiLibrary
					primPhlowInfoViewInstance: self rustViewInstance
					getSendAt: anIndex - 1
					forTypedObject: anObject ]
			forAnyObject: [ :anObject | 
				self ffiLibrary
					primPhlowInfoViewInstance: self rustViewInstance
					getSendAt: anIndex - 1
					forAnyObject: anObject ].

	^ GtRustPhlowAnyObject fromOwnedHandle: aHandle library: self ffiLibrary
]

{ #category : #private }
GtRustPhlowInfoView >> getRowValueTextAt: anIndex [
	^ self ffiLibrary getStringFrom: [ :aStringBox |
		self ffiLibrary
			primPhlowInfoViewInstance: self rustViewInstance
			getRowValueText: aStringBox
			index: anIndex - 1 ]
]

{ #category : #private }
GtRustPhlowInfoView >> getRowsCount [
	^ self ffiLibrary primPhlowInfoViewInstanceGetRowsCount: self rustViewInstance
]
