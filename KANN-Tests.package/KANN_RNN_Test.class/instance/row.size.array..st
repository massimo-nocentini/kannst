tests
row: j size: size array: x
	| array |
	array := (FFIArray externalNewType: #float size: size)
		atAllPut: 0 asFloat;
		yourself.
	x at: j put: array getHandle