creating
leaf: x flag: flag
	^ self
		ffiCall: #(KAD_node_t * kann_new_leaf #(byte flag , float x , int 0))	"`flag` can be KAD_CONST or KAD_VAR"