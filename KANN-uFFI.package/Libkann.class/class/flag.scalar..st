creating
flag: flag scalar: x
	^ self
		ffiCall: #(KAD_node_t * kann_new_scalar #(unsignedByte flag , float x))