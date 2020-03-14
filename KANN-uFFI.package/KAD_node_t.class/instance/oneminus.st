unary operands
oneminus
	^ self
		ffiCall: #(KAD_node_t * kad_1minus #(KAD_node_t * self))
		library: Libkautodiff