unary operands
ce_bin_neg: y
	"binary cross-entropy for (-1,1)"

	^ self
		ffiCall: #(KAD_node_t * kad_ce_bin_neg #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff