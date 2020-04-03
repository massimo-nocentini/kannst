as yet unclassified
gru: n1 flag: rnn_flag
	^ self
		ffiCall: #(KAD_node_t * kann_layer_gru #(KAD_node_t * self , int n1 , int rnn_flag))
		library: Libkann