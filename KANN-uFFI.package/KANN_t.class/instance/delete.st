training
delete
	^ self ffiCall: #(void kann_delete #(KANN_t * self)) library: Libkann