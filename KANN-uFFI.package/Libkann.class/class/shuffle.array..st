as yet unclassified
shuffle: n array: s
	^ self ffiCall: #(void kann_shuffle #(int n , void * s))