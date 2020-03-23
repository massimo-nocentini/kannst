training
apply1: x
	^ self
		ffiCall: #(void * kann_apply1 #(KANN_t * self , void * x))
		library: Libkann