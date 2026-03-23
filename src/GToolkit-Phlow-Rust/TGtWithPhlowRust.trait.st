Trait {
	#name : #TGtWithPhlowRust,
	#category : #'GToolkit-Phlow-Rust-Library'
}

{ #category : #'api - phlow' }
TGtWithPhlowRust >> asPhlowObject: aValueBox do: foundBlock ifNone: noneBlock [
	^ aValueBox asPhlowObjectDo: foundBlock ifNone: noneBlock
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> phlowVTable: aPhlowVTable views: aRustObject [
	<return: #Array of: #GtPhlowRustViews>
	| aHandle views |

	aHandle := (aRustObject isKindOf: GtRustPhlowAnyObject)
		ifTrue: [ self primPhlowVTable: aPhlowVTable getViewsForAnyObject: aRustObject ]
		ifFalse: [ self primPhlowVTable: aPhlowVTable getViewsForTypedObject: aRustObject ].
	
	views := GtPhlowRustViews
		fromOwnedHandle: aHandle
		library: self
		during: [ :thePhlowViews | thePhlowViews popAll ].

	views do: [ :eachView | eachView rustObject: aRustObject ].

	^ views
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowAnyObjectRelease: aHandle [
	self ffiCall: #(void phlow_any_send_object_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowGetVTableOfAnyObject: aHandle [
	^ self ffiCall: #(void* phlow_get_vtable_of_any(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowInfoViewInstance: aPhlowViewInstance getRowName: aStringBox index: anIndex [
	^ self ffiCall: #(void* phlow_info_view_instance_get_row_name_at(
		void* aPhlowViewInstance,
		size_t anIndex,
		void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowInfoViewInstance: aPhlowViewInstance getRowValueText: aStringBox index: anIndex [
	^ self ffiCall: #(void* phlow_info_view_instance_get_row_text_at(
		void* aPhlowViewInstance,
		size_t anIndex,
		void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowInfoViewInstance: aPhlowViewInstance getSendAt: anIndex forAnyObject: aGtRustPhlowAnyObject [
	^ self ffiCall: #(void* phlow_info_view_instance_get_row_send_at_for_any_object (
		void* aPhlowViewInstance,
		size_t anIndex,
		void* aGtRustPhlowAnyObject))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowInfoViewInstance: aPhlowViewInstance getSendAt: anIndex forTypedObject: aValueBox [
	^ self ffiCall: #(void* phlow_info_view_instance_get_row_send_at_for_typed_object (
		void* aPhlowViewInstance,
		size_t anIndex,
		void* aValueBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowInfoViewInstanceGetRowsCount: aPhlowViewInstance [
	^ self ffiCall: #(size_t phlow_info_view_instance_get_rows_count(void* aPhlowViewInstance))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowListViewInstance: aPhlowView getItemText: aStringBox index: anIndex [
	^ self ffiCall: #(void phlow_list_view_instance_get_item_text_at (
		void* aPhlowView,
		size_t anIndex,
		void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowListViewInstance: aPhlowView getSendAt: anIndex [
	^ self ffiCall: #(void* phlow_list_view_instance_get_send_at (
		void* aPhlowView,
		size_t anIndex))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowListViewInstanceItemsCount: aPhlowView [
	^ self ffiCall: #(size_t phlow_list_view_instance_get_items_count #(void #* aPhlowView))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowTest [
	^ self ffiCall: #(bool phlow_test())
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowTextViewInstance: aPhlowView getText: aStringBox [
	^ self ffiCall: #(void phlow_text_view_instance_get_text(void* aPhlowView, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable getValueType: aStringBox [
	self ffiCall: #(void phlow_vtable_get_type_name(void* aPhlowVTable, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable getViewsForAnyObject: aRustPhlowAnyObject [
	^ self ffiCall: #(void* phlow_vtable_get_views_for_any_object(void* aPhlowVTable, void* aRustPhlowAnyObject))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable getViewsForTypedObject: aValueBox [
	^ self ffiCall: #(void* phlow_vtable_get_views_for_typed_object(void* aPhlowVTable, void* aValueBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable toString: aStringBox forAnyObject: aRustPhlowAnyObject [
	self ffiCall: #(void phlow_vtable_to_string_for_any_object(
		void* aPhlowVTable,
		void* aRustPhlowAnyObject,
		void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable toString: aStringBox forTypedObject: aValueBox [ 
	self ffiCall: #(void phlow_vtable_to_string_for_typed_object(
		void* aPhlowVTable,
		void* aValueBox,
		void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTable: aPhlowVTable views: aHandle [
	^ self ffiCall: #(void* phlow_vtable_get_views(void* aPhlowVTable, void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTableRelease: aHandle [
	self ffiCall: #(void phlow_vtable_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTableSupportsToString: aPhlowVTable [
	self ffiCall: #(bool phlow_vtable_supports_to_string(void* aPhlowVTable))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowVTableSupportsTypeName: aPhlowVTable [
	self ffiCall: #(bool phlow_vtable_supports_type_name(void* aPhlowVTable))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView createInstanceForAnyObject: aGtRustPhlowAnyObject [
	^ self ffiCall: #(void* phlow_view_create_instance_for_any_object(void* aPhlowView, void* aGtRustPhlowAnyObject))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView createInstanceForTypedObject: aTypedValueBox [
	^ self ffiCall: #(void* phlow_view_create_instance_for_typed_object(void* aPhlowView, void* aTypedValueBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getSourceCode: aStringBox [
	^ self ffiCall: #(void phlow_view_get_source_code(void* aPhlowView, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getTitle: aStringBox [
	^ self ffiCall: #(void phlow_view_get_title(void* aPhlowView, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getType: aStringBox [
	^ self ffiCall: #(void phlow_view_get_type(void* aPhlowView, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewGetPriority: aPhlowView [
	^ self ffiCall: #(size_t phlow_view_get_priority(void* aPhlowView))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewInstance: aPhlowView getTitle: aStringBox [
	^ self ffiCall: #(void phlow_view_instance_get_title(void* aPhlowView, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewInstance: aHandle getType: aStringBox [
	self ffiCall: #(void phlow_view_instance_get_type(void* aHandle, void* aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewInstanceGetPriority: aPhlowViewInstance [
	^ self ffiCall: #(size_t phlow_view_instance_get_priority(void* aPhlowViewInstance))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewInstanceRelease: aHandle [
	self ffiCall: #(void phlow_view_instance_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewRelease: aHandle [
	self ffiCall: #(void phlow_view_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewsPop: aPhlowRustViews [
	^ self ffiCall: #(void* phlow_views_pop(GtPhlowRustViews aPhlowRustViews))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewsRelease: aHandle [
	self ffiCall: #(void phlow_views_drop(void* aHandle))
]
