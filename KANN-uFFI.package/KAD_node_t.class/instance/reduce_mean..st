layers composition
reduce_mean: axis
	"tf.reduce_mean(x, axis)"

	^ self
		ffiCall: #(KAD_node_t * kad_reduce_mean #(KAD_node_t * self , int axis))
		library: Libkautodiff