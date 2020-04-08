accessing
accessor_n_child
	"number of operands/child nodes"

	^ self
		ffiCall: #(int32 kad_accessor_n_child #(KAD_node_t * self))
		library: Libkautodiff