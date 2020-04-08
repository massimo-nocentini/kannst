accessing
accessor_ext_flag
	"flags for external uses (not modified by the kad_* APIs) "

	^ self
		ffiCall: #(uint32 kad_accessor_ext_flag #(KAD_node_t * self))
		library: Libkautodiff