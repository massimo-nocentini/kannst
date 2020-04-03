accessing structure variables
unroll: len
	^ self
		ffiCall: #(KANN_t * kann_unroll #(KANN_t * self , int len))
		library: Libkann