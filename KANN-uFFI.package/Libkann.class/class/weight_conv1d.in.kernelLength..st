creating
weight_conv1d: n_out in: n_in kernelLength: kernel_len
	^ self
		ffiCall:
			#(KAD_node_t * kann_new_weight_conv1d #(int n_out , int n_in , int kernel_len))