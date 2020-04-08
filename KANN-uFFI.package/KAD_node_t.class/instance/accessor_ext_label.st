accessing
accessor_ext_label
	"labels for external uses (not modified by the kad_* APIs) "

	^ self
		ffiCall: #(int32 kad_accessor_ext_label #(KAD_node_t * self))
		library: Libkautodiff