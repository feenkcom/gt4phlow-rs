Extension { #name : #FFILibrary }

{ #category : #'*GToolkit-Phlow-Rust' }
FFILibrary >> asPhlowObject: aValueBox do: foundBlock ifNone: noneBlock [
	^ noneBlock value
]
