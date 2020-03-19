creating
weight_conv2d: n_out in: n_in row: k_row col: k_col
	^ self
		ffiCall:
			#(KAD_node_t * kann_new_weight_conv2d #(int n_out , int n_in , int k_row , int k_col))