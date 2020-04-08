accessing
accessor_flag
	^ self
		ffiCall: #(uint8 kad_accessor_flag #(KAD_node_t * self))
		library: Libkautodiff