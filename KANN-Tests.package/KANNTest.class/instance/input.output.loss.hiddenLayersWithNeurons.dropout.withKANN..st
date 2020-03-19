tests
input: n_in output: n_out loss: loss_type hiddenLayersWithNeurons: h_neurons dropout: h_dropout withKANN: aBlock
	| kad_node_t |
	kad_node_t := (h_neurons
		inject: (Libkann inputLayer: n_in)
		into: [ :t :n_h_neurons | (t dense: n_h_neurons) relu dropout: h_dropout ])
		cost: n_out
		type: loss_type.
	^ kad_node_t withKANN: aBlock