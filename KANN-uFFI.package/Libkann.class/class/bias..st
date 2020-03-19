creating
bias: n
	^ self ffiCall: #(KAD_node_t * kann_new_bias #(int n))