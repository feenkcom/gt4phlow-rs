Class {
	#name : #GtPhlowRustLibrary,
	#superclass : #FFILibrary,
	#category : #'GToolkit-Phlow-Rust-Library'
}

{ #category : #logger }
GtPhlowRustLibrary class >> initEnvLogger [
	self uniqueInstance initEnvLogger
]

{ #category : #initialization }
GtPhlowRustLibrary class >> initialize [
	SessionManager default registerUserClassNamed: self name
]

{ #category : #'system startup' }
GtPhlowRustLibrary class >> startUp: isANewSession [
	isANewSession
		ifTrue: [ self initEnvLogger ]
]

{ #category : #logger }
GtPhlowRustLibrary >> initEnvLogger [
	[ self primInitEnvLogger ]
		on: Error
		do: [ :e | NonInteractiveTranscript stdout nextPutAll: '[Phlow] Could not init env logger'; cr ]
]

{ #category : #'accessing - platform' }
GtPhlowRustLibrary >> macLibraryName [
	^ FFIMacLibraryFinder findLibrary: 'libPhlow.dylib'
]

{ #category : #'private - ffi' }
GtPhlowRustLibrary >> primInitEnvLogger [
	^ self ffiCall: #(void phlow_init_env_logger())
]

{ #category : #'accessing - platform' }
GtPhlowRustLibrary >> unix32LibraryName [
	^ FFIUnix32LibraryFinder findLibrary: 'libPhlow.so'
]

{ #category : #'accessing - platform' }
GtPhlowRustLibrary >> unix64LibraryName [
	^ FFIUnix64LibraryFinder findLibrary: 'libPhlow.so'
]

{ #category : #'accessing - platform' }
GtPhlowRustLibrary >> win32LibraryName [
	^ FFIWindowsLibraryFinder findLibrary: 'Phlow.dll'
]
