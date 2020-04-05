as yet unclassified
rnn_end
	^ self
		ffiCall: #(void kann_rnn_end #(KANN_t * self))
		library: Libkann