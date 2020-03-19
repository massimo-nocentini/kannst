creating
scalar: x flag: flag
	^ self
		ffiCall: #(KAD_node_t * kann_new_scalar #(usignedByte flag , float x))