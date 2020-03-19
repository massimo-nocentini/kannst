unary operands
mse: y
	"mean square error"

	^ self
		ffiCall: #(KAD_node_t * kad_mse #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff