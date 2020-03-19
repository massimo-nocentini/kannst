unary operands
ce_multi: y
	"multi-class cross-entropy; x is the preidction and y is the truth"

	^ self
		ffiCall: #(KAD_node_t * kad_ce_multi #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff