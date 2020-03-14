unary operands
sigmoid
	^ self
		ffiCall: #(KAD_node_t * kad_sigm #(KAD_node_t * self))
		library: Libkautodiff