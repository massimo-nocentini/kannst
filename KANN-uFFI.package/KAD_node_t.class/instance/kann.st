creating
kann
	^ self
		ffiCall:
			#(KANN_t *kann_new #(KAD_node_t *self , int 0))
		library: Libkann