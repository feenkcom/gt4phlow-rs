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
			aCoderElement
				hExact: 500;
				vFitContentLimited;
				background: aCoderElement theme default contentBackgroundColor;
				addAptitude: (BrGlamorousMenuPinnableAptitude new
						menuModel: aMenuModel;
						withResizers;
						withAllPinActions);
				addAptitude: (BrMenuHideableAptitude new menuModel: aMenuModel);
				addAptitude: BrMenuCommonAptitude new ]
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
