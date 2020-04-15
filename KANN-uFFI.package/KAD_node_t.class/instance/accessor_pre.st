accessing
accessor_pre
	^ self
		ffiCall: #(void * kad_accessor_pre #(KAD_node_t * self))
		library: Libkautodiff