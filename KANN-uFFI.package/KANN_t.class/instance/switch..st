training
switch: isTrain
	^ self
		ffiCall: #(void kann_switch #(KANN_t * self , int isTrain))
		library: Libkann