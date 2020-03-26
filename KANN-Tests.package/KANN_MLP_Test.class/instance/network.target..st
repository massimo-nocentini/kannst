tests
network: x target: y
	^ ({64 . 64 . 64 . 64}
		inject: (Libkann inputLayer: x n_col)
		into: [ :t :n_h_neurons | (t dense: n_h_neurons) relu dropout: 0 asFloat ])
		cost: y n_col
		type: (Libkann constants at: #KANN_C_CEB)