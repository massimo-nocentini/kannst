versions
version
	self flag: 'TODO'.
	^ self ffiCall: #(char * KANN_VERSION)