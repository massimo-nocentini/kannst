accessing
accessor_op_name
	"operator; kad_op_name[op] is the name of function"

	^ self
		ffiCall: #(char * kad_accessor_op_name #(KAD_node_t * self))
		library: Libkautodiff