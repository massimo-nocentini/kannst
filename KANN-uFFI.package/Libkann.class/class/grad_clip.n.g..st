as yet unclassified
grad_clip: thres n: n g: g
	^ self
		ffiCall: #(float kann_grad_clip #(float thres , int n , void * g))