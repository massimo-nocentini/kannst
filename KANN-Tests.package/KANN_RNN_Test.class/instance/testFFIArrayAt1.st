tests
testFFIArrayAt1
	| array |
	array := FFIArray externalNewType: #uint size: 10.
	[ self assert: (array at: 1) equals: 0 ]
		ensure: [ array free ]