as yet unclassified
loadFromFileNamed: fn
	^ self
		ffiCall: #(KANN_t * kann_load #(const char * fn))
		library: Libkann