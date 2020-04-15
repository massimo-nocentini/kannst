as yet unclassified
rnn_run: aBlock
	self rnn_start.
	^ [ aBlock cull: self ]
		ensure: [ self rnn_end ]