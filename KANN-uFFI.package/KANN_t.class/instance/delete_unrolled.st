as yet unclassified
delete_unrolled
	"delete a network generated by kann_unroll() "

	^ self
		ffiCall: #(void kann_delete_unrolled #(KANN_t * self))
		library: Libkann