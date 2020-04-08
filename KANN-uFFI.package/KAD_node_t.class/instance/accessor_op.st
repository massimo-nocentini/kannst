accessing
accessor_op
	^ self
		ffiCall: #(uint8 kad_accessor_op #(KAD_node_t * self))
		library: Libkautodiff