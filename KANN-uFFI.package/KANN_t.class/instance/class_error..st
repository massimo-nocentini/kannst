as yet unclassified
class_error: base
	^ self
		ffiCall: #(int kann_class_error #(const KANN_t * self , int * base))
		library: Libkann