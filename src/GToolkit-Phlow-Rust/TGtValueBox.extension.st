Extension { #name : #TGtValueBox }

{ #category : #'*GToolkit-Phlow-Rust' }
TGtValueBox >> asPhlowObjectDo: aBlock ifNone: aNoneBlock [
	"Try to get a phlow object for this value box and evaluate aBlock if it was successful"
	| anFFILibrary isPhlowSupported aPhlowObjectHandle |
	
	anFFILibrary := self ffiLibrary asFFILibrary.
	
	"It is expected that some libraries do not support phlow.
	Which is fine because if a library declares that it supports phlow then there will
	be examples on the class side that validate phlow functionality"
	isPhlowSupported := [ anFFILibrary primPhlowTest ]
		on: Error
		do: [ :anError | false ].
		
	isPhlowSupported
		ifFalse: [ ^ aNoneBlock value ].

	aPhlowObjectHandle := [ anFFILibrary primValueBoxToPhlowObject: self ]
		on: Error
		do: [ :anError | ExternalData null ].
	
	aPhlowObjectHandle isNull
		ifTrue: [ ^ aNoneBlock value ].

	^ aBlock value: (GtRustPhlowObject
		fromOwnedHandle: aPhlowObjectHandle
		library: anFFILibrary)
]

{ #category : #'*GToolkit-Phlow-Rust' }
TGtValueBox >> gtAsPhlowObjectActionFor: anAction [
	<gtAction>
	
	^ self
		asPhlowObjectDo: [ :aPhlowObject |
			aPhlowObject == self
				ifTrue: [ anAction noAction ]
				ifFalse: [
					anAction button
						priority: 1;
						tooltip: 'Inspect Rust object';
						icon:( self class environment at: #BrGlamorousVectorIcons) rustLogo;
						action: [ :aButton | aButton phlow spawnObject: aPhlowObject ] ] ]
		ifNone: [ anAction noAction ]
]

{ #category : #'*GToolkit-Phlow-Rust' }
TGtValueBox >> gtViewsFor: aView inContext: aContext [
	"Add the declarative views from the inspectors object to the inspectors views"
	| resultingView inspectorViews |

	resultingView := super gtViewsFor: aView inContext: aContext.
	inspectorViews := resultingView originalView views.

	"Add the explicitly declarative views from the inspected object"
	inspectorViews addAll: (self asPhlowObjectDo: [ :aPhlowObject |
		aPhlowObject
			rustPhlowViewsFor: aView
			inContext: aContext ]
		ifNone: [ #() ]).

	"Re-sort by priority"
	inspectorViews := inspectorViews sorted: [ :a :b | a priority < b priority ].
	resultingView originalView views: inspectorViews.
	^ resultingView
]
