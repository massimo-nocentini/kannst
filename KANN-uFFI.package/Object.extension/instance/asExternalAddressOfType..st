*KANN-uFFI
asExternalAddressOfType: aType
	^ (FFIArray externalNewType: aType size: 1)
		at: 1 put: self;
		getHandle