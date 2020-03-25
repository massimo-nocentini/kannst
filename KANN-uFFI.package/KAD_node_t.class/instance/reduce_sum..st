layers composition
reduce_sum: axis
	"tf.reduce_sum(x, axis)"

	^ self
		ffiCall: #(KAD_node_t * kad_reduce_sum #(KAD_node_t * self , int axis))
		library: Libkautodiff