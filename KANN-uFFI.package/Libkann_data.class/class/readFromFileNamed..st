creating
readFromFileNamed: aString
	^ self
		ffiCall: #(KANN_data_t * kann_data_read #(const char * aString))