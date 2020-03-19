unary operands
ce_bin: y
	"binary cross-entropy for (0,1)"

	^ self
		ffiCall: #(KAD_node_t * kad_ce_bin #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff