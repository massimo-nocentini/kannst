accessing
accessor_flag
	"type of the node; see KAD_F_* for valid flags"

	^ self
		ffiCall: #(uint8 kad_accessor_flag #(KAD_node_t * self))
		library: Libkautodiff