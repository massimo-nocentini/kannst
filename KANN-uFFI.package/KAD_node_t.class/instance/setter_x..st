accessing
setter_x: x
	^ self
		ffiCall: #(KAD_node_t * kad_setter_x #(KAD_node_t * self , void * x))
		library: Libkautodiff