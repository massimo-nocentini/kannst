accessing
accessor_op
	"operator; kad_op_list[op] is the actual function"

	^ self
		ffiCall: #(uint8 kad_accessor_op #(KAD_node_t * self))
		library: Libkautodiff