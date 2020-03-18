training
apply1: x
	^ self
		ffiCall: #(float * kann_apply1 #(KANN_t * self , float * x))
		library: Libkann