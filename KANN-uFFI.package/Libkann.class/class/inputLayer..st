creating
inputLayer: n
	^ self ffiCall: #(KAD_node_t * kann_layer_input #(int n))