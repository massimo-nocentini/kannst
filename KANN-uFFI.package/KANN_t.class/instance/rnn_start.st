as yet unclassified
rnn_start
	^ self
		ffiCall: #(void kann_rnn_start #(KANN_t * self))
		library: Libkann