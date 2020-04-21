utilities
lstmBlock
	^ [ :t :n_h_neurons | t lstm: n_h_neurons flag: self rnn_flag ]