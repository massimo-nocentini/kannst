unary operands
ce_multi_weighted: truth weight: weight
	"binary cross-entropy for (-1,1)"

	^ self
		ffiCall:
			#(KAD_node_t * kad_ce_multi_weighted #(KAD_node_t * self , KAD_node_t * truth , KAD_node_t * weight))
		library: Libkautodiff