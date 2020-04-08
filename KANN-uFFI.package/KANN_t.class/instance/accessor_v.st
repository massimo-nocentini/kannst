training
accessor_v
	^ self
		ffiCall: #(void * kann_accessor_v #(KANN_t * self))
		library: Libkann