accessing structure variables
ext_flag: flag update: shouldUpdate
	^ self
		ffiCall: #(void kad_ext_flag #(KAD_node_t * self , uint32 flag , int shouldUpdate))
		library: Libkautodiff