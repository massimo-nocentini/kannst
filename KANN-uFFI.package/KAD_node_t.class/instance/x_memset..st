as yet unclassified
x_memset: v
	^ self
		ffiCall: #(void kad_x_memset #(const KAD_node_t * self , float v))
		library: Libkautodiff