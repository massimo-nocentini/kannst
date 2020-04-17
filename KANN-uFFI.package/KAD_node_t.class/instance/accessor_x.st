accessing
accessor_x
	^ self
		ffiCall: #(void * kad_accessor_x #(KAD_node_t * self))
		library: Libkautodiff