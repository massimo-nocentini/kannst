unary operands
cmul: y
	"f(x,y) = x * y^T (column-wise matrix product; i.e. y is transposed)"

	^ self
		ffiCall: #(KAD_node_t * kad_cmul #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff