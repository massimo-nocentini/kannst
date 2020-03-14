unary operands
log
	^ self
		ffiCall: #(KAD_node_t * kad_log #(KAD_node_t * self))
		library: Libkautodiff