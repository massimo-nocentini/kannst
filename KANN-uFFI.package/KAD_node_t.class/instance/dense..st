layers composition
dense: n
	^ self
		ffiCall: #(KAD_node_t * kann_layer_dense #(KAD_node_t * self , int n))
		library: Libkann