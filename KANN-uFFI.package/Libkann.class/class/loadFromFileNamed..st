as yet unclassified
loadFromFileNamed: fn
	^ self ffiCall: #(KANN_t * kann_load #(char * fn)) library: self