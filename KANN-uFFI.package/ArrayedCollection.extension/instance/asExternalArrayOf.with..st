*KANN-uFFI
asExternalArrayOf: aType with: aBlock
	| eArray |
	eArray := FFIArray externalNewType: aType size: self size.
	self withIndexDo: [ :each :i | eArray at: i put: each ].
	^ [ aBlock value: eArray ]
		ensure: [ eArray free ]