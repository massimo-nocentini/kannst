*KANN-uFFI
asExternalAddressOfType: aTypeName with: aBlock
	^ FFIArray
		externalNewTypeOf: aTypeName
		size: 1
		with: [ :anArray | 
			anArray at: 1 put: self.
			aBlock value: anArray getHandle.
			anArray at: 1 ]