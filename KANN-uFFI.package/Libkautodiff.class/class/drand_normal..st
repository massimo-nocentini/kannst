as yet unclassified
drand_normal: d
	^ self ffiCall: #(double kad_drand_normal #(void * d))