as yet unclassified
dimensions
	^ self
		ffiCall: #(int kad_dimensions #(const KAD_node_t * self))
		library: Libkautodiff