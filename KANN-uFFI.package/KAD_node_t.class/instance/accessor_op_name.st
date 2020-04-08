accessing
accessor_op_name
	^ self
		ffiCall: #(char * kad_accessor_op_name #(KAD_node_t * self))
		library: Libkautodiff