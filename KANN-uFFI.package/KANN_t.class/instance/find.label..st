accessing
find: ext_flag label: ext_label
	^ self
		ffiCall: #(int kann_find #(KANN_t * self , uint32 ext_flag , int32 ext_label))
		library: Libkann