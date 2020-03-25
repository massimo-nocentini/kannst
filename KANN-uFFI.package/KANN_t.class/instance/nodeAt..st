accessing
nodeAt: anInteger
	| type |
	type := FFIExternalType resolveType: #KAD_node_t.
	^ type
		handle: ((self v asArrayOf: #'KAD_node_t *' size: self n) at: anInteger)
		at: 1