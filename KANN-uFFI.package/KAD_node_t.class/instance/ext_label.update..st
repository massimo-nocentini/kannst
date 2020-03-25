accessing structure variables
ext_label: label update: shouldUpdate
	^ self
		ffiCall:
			#(void kad_ext_label #(KAD_node_t * self , int32 label , int shouldUpdate))
		library: Libkautodiff