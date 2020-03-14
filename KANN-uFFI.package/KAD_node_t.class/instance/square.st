unary operands
square
	^ self
		ffiCall: #(KAD_node_t * kad_square #(KAD_node_t * self))
		library: Libkautodiff