as yet unclassified
fevalWithFlag: ext_flag withLabel: ext_label
	^ self
		ffiCall:
			#(void * kann_feval #(KANN_t * self , uint32 ext_flag , int ext_label))
		library: Libkann