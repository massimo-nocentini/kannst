tests
testRNN
	| d rnn_flag kad_node_t |
	rnn_flag := (Libkann constants at: #KANN_RNN_VAR_H0)
		| (Libkann constants at: #KANN_RNN_NORM).
	d := self testKANN_load_Bit_data_t.
	kad_node_t := {64}
		inject: (Libkann inputLayer: d n_in)
		into: [ :n_h_neurons :t | (t gru: n_h_neurons flag: rnn_flag) dropout: 0.2 ].
	(kad_node_t cost: 2 type: (Libkann constants at: #KANN_C_CEM))
		withKANN: [ :kann_t | 
			self
				train: kann_t
				data: d
				lr: 0.01
				mini_size: 64
				max_epoch: 50
				n_threads: 1 ]