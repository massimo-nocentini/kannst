training
accessor_n
	^ self
		ffiCall: #(int kann_accessor_n #(KANN_t * self))
		library: Libkann