*KANN-uFFI
realloc: ptr size: size
	^ self ffiCall: #(void * realloc #(void * ptr , size_t size))