accessing structure variables
feed_bind: ext_flag label: ext_label arrays: x
	^ self
		ffiCall:
			#(int kann_feed_bind #(KANN_t * self , uint32 ext_flag , int32 ext_label , void * x))
		library: Libkann