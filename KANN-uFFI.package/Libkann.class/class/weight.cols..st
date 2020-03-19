creating
weight: n_row cols: n_col
	^ self
		ffiCall: #(KAD_node_t * kann_new_weight #(int n_row , int n_col))