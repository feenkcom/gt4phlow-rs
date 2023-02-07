Trait {
	#name : #TGtWithPhlowRust,
	#category : #'GToolkit-Phlow-Rust-Library'
}

{ #category : #'api - phlow' }
TGtWithPhlowRust >> phlowObjectGetViews: aPhlowObject [
	<return: #Array of: #s>

	^ GtPhlowRustViews
		fromOwnedHandle: (self primPhlowObjectGetViews: aPhlowObject)
		library: self
		during: [ :thePhlowViews | thePhlowViews popAll ]
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowColumnedList: aPhlowView computeCellText: aGtBoxerString items: anAnyVec row: aRowIndex column: aColumnIndex [
	^ self ffiCall: #(void phlow_columned_list_view_compute_item_text_at (
		GtRustPhlowView aPhlowView,
		GtPhlowRustObjectVec anAnyVec,
		size_t aRowIndex,
		size_t aColumnIndex,
		GtBoxerString aGtBoxerString))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowColumnedList: aPhlowView computeColumnTitle: aStringBox index: aColumnIndex [
	^ self ffiCall: #(void phlow_columned_list_get_column_title(
		GtRustPhlowView aPhlowView,
		size_t aColumnIndex,
		GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowColumnedListGetAmountOfColumns: aPhlowView [
	^ self ffiCall: #(size_t phlow_columned_list_get_columns_len(GtRustPhlowView aPhlowView))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowColumnedListView: aPhlowView computeItemSend: anAnyVec index: anIndex [
	^ self ffiCall: #(void* phlow_columned_list_view_compute_item_send_at (
		GtRustPhlowView aPhlowView,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowColumnedListViewComputeItems: aPhlowView [
	^ self ffiCall: #(void* phlow_columned_list_view_compute_items(GtRustPhlowView aPhlowView))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowList: aPhlowView computeItemText: aStringBox items: anAnyVec index: anIndex [
	^ self ffiCall: #(void phlow_list_view_compute_item_text_at (
		GtRustPhlowView aPhlowView,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex,
		GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowListView: aPhlowView computeItemSend: anAnyVec index: anIndex [
	^ self ffiCall: #(void* phlow_list_view_compute_item_send_at (
		GtRustPhlowView aPhlowView,
		GtPhlowRustObjectVec anAnyVec,
		size_t anIndex))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowListViewComputeItems: aPhlowView [
	^ self ffiCall: #(void* phlow_list_view_compute_items(GtRustPhlowView aPhlowView))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObject: aPhlowObject getValueType: aStringBox [
	^ self ffiCall: #(void phlow_object_get_value_type(#GtRustPhlowObject aPhlowObject, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObject: aPhlowObject toString: aStringBox [
	^ self ffiCall: #(void phlow_object_to_string(#GtRustPhlowObject aPhlowObject, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObjectGetViews: aPhlowObject [
	^ self ffiCall: #(void* phlow_object_get_views(#GtRustPhlowObject aPhlowObject))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObjectRelease: aHandle [
	self ffiCall: #(void phlow_object_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObjectVecGetLength: aPhlowObjectVec [
	^ self ffiCall: #(size_t phlow_object_vec_len(GtPhlowRustObjectVec aPhlowObjectVec))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowObjectVecRelease: aHandle [
	self ffiCall: #(void phlow_object_vec_drop(void* aHandle))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowTest [
	^ self ffiCall: #(bool phlow_test())
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowTextView: aPhlowView computeText: aStringBox [
	^ self ffiCall: #(void phlow_text_view_compute_text(GtRustPhlowView aPhlowView, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getSourceCode: aStringBox [
	^ self ffiCall: #(void phlow_view_get_source_code(GtRustPhlowView aPhlowView, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getTitle: aStringBox [
	^ self ffiCall: #(void phlow_view_get_title(GtRustPhlowView aPhlowView, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowView: aPhlowView getType: aStringBox [
	^ self ffiCall: #(void phlow_view_get_type(GtRustPhlowView aPhlowView, GtStringBox aStringBox))
]

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primPhlowViewGetPriority: aPhlowView [
	^ self ffiCall: #(size_t phlow_view_get_priority(GtRustPhlowView aPhlowView))
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

{ #category : #'private - phlow' }
TGtWithPhlowRust >> primValueBoxToPhlowObject: aValueBox [
	^ self ffiCall: #(void* boxer_value_box_to_phlow_object(void* aValueBox))
]
