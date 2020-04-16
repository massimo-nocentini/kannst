*KANN-uFFI
asExternalArrayOf: aTypeName with: aBlock
	| eArray |
	eArray := FFIArray externalNewType: aTypeName size: self size.
	self withIndexDo: [ :each :i | eArray at: i put: each ].
	^ [ aBlock
		cull: eArray
		cull: eArray getHandle
		cull: (FFIExternalType resolveType: aTypeName)
		cull: self ]
		ensure: [ eArray free ]