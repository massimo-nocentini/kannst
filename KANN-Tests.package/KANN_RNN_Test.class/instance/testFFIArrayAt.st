tests
testFFIArrayAt
	| array |
	array := FFIArray externalNewType: #uint size: 10.
	[ self should: [ array at: 0 ] raise: Error ]
		ensure: [ array free ]