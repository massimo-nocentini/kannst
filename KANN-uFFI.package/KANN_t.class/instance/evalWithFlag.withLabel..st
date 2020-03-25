as yet unclassified
evalWithFlag: ext_flag withLabel: ext_label
	^ self
		ffiCall: #(int kann_eval #(KANN_t * self , uint32 ext_flag , int ext_label))
		library: Libkann