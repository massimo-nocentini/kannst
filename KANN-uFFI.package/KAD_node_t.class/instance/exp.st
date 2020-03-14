unary operands
exp
	^ self
		ffiCall: #(KAD_node_t * kad_exp #(KAD_node_t * self))
		library: Libkautodiff