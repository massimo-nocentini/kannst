accessing
accessor_child
	^ self
		ffiCall: #(void * kad_accessor_child #(KAD_node_t * self))
		library: Libkautodiff