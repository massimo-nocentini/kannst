unary operands
softmax
	^ self
		ffiCall: #(KAD_node_t * kad_softmax #(KAD_node_t * self))
		library: Libkautodiff