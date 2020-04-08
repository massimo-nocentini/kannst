accessing
accessor_n_child
	^ self
		ffiCall: #(int32 kad_accessor_n_child #(KAD_node_t * self))
		library: Libkautodiff