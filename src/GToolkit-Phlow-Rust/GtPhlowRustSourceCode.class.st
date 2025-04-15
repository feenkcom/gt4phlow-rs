Class {
	#name : #GtPhlowRustSourceCode,
	#superclass : #Object,
	#instVars : [
		'sourceCode'
	],
	#category : #'GToolkit-Phlow-Rust-Utilities'
}

{ #category : #ui }
GtPhlowRustSourceCode >> asBrMenuWithSelfObjectHolder: aSelfObjectHolder [
	^ BrMenuExplicit new
		stencil: [ :aMenuModel | 
			| aCoderElement |
			aCoderElement := (self gtRustFor: GtPhlowView empty) asElementDo: [ :e | e ].
			aCoderElement addAptitude: (BrGlamorousPopoverDefiningMethodAptitude new
				menuModel: aMenuModel).
			aCoderElement ]
]

{ #category : #'gt-extensions' }
GtPhlowRustSourceCode >> gtPhlowIncludesCompiledMethod: aCompiledMethod [ 
	^ false
]

{ #category : #'gt-extensions' }
GtPhlowRustSourceCode >> gtRustFor: aView [
	<gtView>

	^ aView textEditor
		title: 'Rust';
		priority: 1;
		aptitude: [ self class environment at: #BrGlamorousCodeEditorAptitude ];
		styler: [ (self class environment at: #RustParser) gtStyler ];
		text: [ sourceCode ]
]

{ #category : #accessing }
GtPhlowRustSourceCode >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtPhlowRustSourceCode >> sourceCode: anObject [
	sourceCode := anObject
]
