as yet unclassified
drand: d
	^ self ffiCall: #(double kad_drand #(void * d))