Extension { #name : #GtBoxerValueBox }

{ #category : #'*GToolkit-Phlow-Rust' }
GtBoxerValueBox >> asPhlowObject [
	^ GtPhlowRustObject fromNativeHandle: self primToPhlowObject
]

{ #category : #'*GToolkit-Phlow-Rust' }
GtBoxerValueBox >> gtViewsFor: aView inContext: aContext [
	"Add the declarative views from the inspectors object to the inspectors views"
	| resultingView inspectorViews |

	resultingView := super gtViewsFor: aView inContext: aContext.
	inspectorViews := resultingView originalView views.

	"Add the explicitly declarative views from the inspected object"
	inspectorViews addAll: (self rustPhlowViewsFor: aView inContext: aContext).

	"Re-sort by priority"
	inspectorViews := inspectorViews sorted: [ :a :b | a priority < b priority ].
	resultingView originalView views: inspectorViews.
	^ resultingView
]

{ #category : #'*GToolkit-Phlow-Rust' }
GtBoxerValueBox >> primToPhlowObject [
	^ ExternalAddress null
]

{ #category : #'*GToolkit-Phlow-Rust' }
GtBoxerValueBox >> rustPhlowViewsFor: aView inContext: aContext [
	| aPhlowObject |
	
	aPhlowObject := self asPhlowObject.
	^ aPhlowObject rustPhlowViewsFor: aView inContext: aContext
]
