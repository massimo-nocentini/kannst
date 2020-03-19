utilities
srand: d seed: seed
	^ self ffiCall: #(void kad_srand #(void * d , ulonglong seed))