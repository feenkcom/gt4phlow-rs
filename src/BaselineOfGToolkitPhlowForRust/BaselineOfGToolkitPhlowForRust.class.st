Class {
	#name : #BaselineOfGToolkitPhlowForRust,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlowForRust
}

{ #category : #baseline }
BaselineOfGToolkitPhlowForRust >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitBoxer' with: [
				spec repository: 'github://feenkcom/gtoolkit-boxer:v0.8.51/boxer-bindings' ].

		spec package: 'GToolkit-Phlow-Rust' with: [
			spec requires: #('GToolkitBoxer') ].
	]
]
