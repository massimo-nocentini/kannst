training
apply1: x
	^ self
		ffiCall: #(void * kann_apply1 #(KANN_t * self , float * x))
		library: Libkann