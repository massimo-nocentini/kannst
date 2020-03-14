unary operands
sin
	^ self
		ffiCall: #(KAD_node_t * kad_sin #(KAD_node_t * self))
		library: Libkautodiff