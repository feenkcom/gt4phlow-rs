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
			baseline: 'GToolkitBoxerBindings' with: [
				spec repository: 'github://feenkcom/gtoolkit-boxer:main/src' ];
			baseline: 'GToolkitPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ].

		spec package: 'GToolkit-Phlow-Rust' with: [
				spec requires: #('GToolkitBoxerBindings' 'GToolkitPhlow'). ]. ].
]
