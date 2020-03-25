accessing structure variables
x_drand_normal
	^ self
		ffiCall: #(void kad_x_drand_normal #(KAD_node_t * self))
		library: Libkautodiff