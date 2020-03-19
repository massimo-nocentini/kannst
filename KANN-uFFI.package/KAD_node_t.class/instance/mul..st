unary operands
mul: y
	"f(x,y) = x * y (generalized element-wise product)"

	^ self
		ffiCall: #(KAD_node_t * kad_mul #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff