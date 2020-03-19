unary operands
matmul: y
	"f(x,y) = x * y   (general matrix product)"

	^ self
		ffiCall: #(KAD_node_t * kad_matmul #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff