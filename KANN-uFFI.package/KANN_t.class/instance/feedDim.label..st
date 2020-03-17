training
feedDim: ext_flag label: ext_label
	^ self
		ffiCall:
			#(int kann_feed_dim #(const KANN_t * self , uint ext_flag , int32 ext_label))
		library: Libkann