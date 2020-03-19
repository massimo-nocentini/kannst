unary operands
sub: y
	"f(x,y) = x - y (generalized element-wise subtraction)"

	^ self
		ffiCall: #(KAD_node_t * kad_sub #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff