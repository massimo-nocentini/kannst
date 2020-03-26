as yet unclassified
conv2d: n_flt rows: k_rows cols: k_cols row_stride: stride_r col_stride: stride_c row_pad: pad_r col_pad: pad_c
	^ self
		ffiCall:
			#(KAD_node_t * kann_layer_conv2d #(KAD_node_t * self , int n_flt , int k_rows , int k_cols , int stride_r , int stride_c , int pad_r , int pad_c))
		library: Libkann