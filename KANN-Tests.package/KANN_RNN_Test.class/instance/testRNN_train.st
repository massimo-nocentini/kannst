tests
testRNN_train
	| d kad_node_t |
	"	Libkautodiff trap_fe."
	Libkann srand: self seed.
	d := self testKANN_load_Bit_data_t.
	kad_node_t := self h_layers
		inject: (Libkann inputLayer: d n_in)
		into:
			[ :t :n_h_neurons | (t gru: n_h_neurons flag: self rnn_flag) dropout: 0.2 ].
	(kad_node_t cost: 2 type: (Libkann constants at: #KANN_C_CEM))
		withKANN: [ :kann_t | 
			self
				train: kann_t
				data: d
				lr: self lr
				mini_size: self miniSize
				max_epoch: self epochs
				n_threads: self n_threads ]