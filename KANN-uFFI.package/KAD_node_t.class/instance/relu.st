unary operands
relu
	^ self
		ffiCall: #(KAD_node_t * kad_relu #(KAD_node_t * self))
		library: Libkautodiff