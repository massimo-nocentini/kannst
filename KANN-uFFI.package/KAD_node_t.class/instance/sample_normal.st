accessing structure variables
sample_normal
	"f(x) = x * r, where r is drawn from a standard normal distribution"

	^ self
		ffiCall: #(KAD_node_t * kad_sample_normal #(KAD_node_t * self))
		library: Libkautodiff