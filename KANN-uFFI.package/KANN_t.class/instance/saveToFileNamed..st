training
saveToFileNamed: fn
	^ self
		ffiCall: #(void kann_save #(const char * fn , KANN_t * self))
		library: Libkann