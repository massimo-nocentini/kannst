utilities
rnnBlock
	^ [ :t :n_h_neurons | t rnn: n_h_neurons flag: self rnn_flag ]