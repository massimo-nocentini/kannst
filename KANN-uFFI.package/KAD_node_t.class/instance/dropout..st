layers composition
dropout: r
	^ self
		ffiCall: #(KAD_node_t * kann_layer_dropout #(KAD_node_t * self , float r))
		library: Libkann