accessing
accessor_op_function
	^ self
		ffiCall: #(FFICallback kad_accessor_op_function #(KAD_node_t * self))
		library: Libkautodiff