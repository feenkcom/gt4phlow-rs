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
				spec repository: 'github://feenkcom/gtoolkit-boxer:main/src' ].

		spec package: 'GToolkit-Phlow-Rust' with: [
				spec requires: #('GToolkitBoxer'). ]. ].
]
