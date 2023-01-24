Class {
	#name : #GtPhlowRustSourceCode,
	#superclass : #Object,
	#instVars : [
		'sourceCode'
	],
	#category : #'GToolkit-Phlow-Rust-External'
}

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
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ RustParser gtStyler ];
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
