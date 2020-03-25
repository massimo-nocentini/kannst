accessing
find_node: ext_flag label: ext_label
	^ self
		ffiCall:
			#(KAD_node_t * kann_find_node #(const KANN_t * self , uint32 ext_flag , int32 ext_label))
		library: Libkann