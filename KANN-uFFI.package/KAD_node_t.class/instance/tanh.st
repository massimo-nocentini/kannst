unary operands
tanh
	^ self
		ffiCall: #(KAD_node_t * kad_tanh #(KAD_node_t * self))
		library: Libkautodiff