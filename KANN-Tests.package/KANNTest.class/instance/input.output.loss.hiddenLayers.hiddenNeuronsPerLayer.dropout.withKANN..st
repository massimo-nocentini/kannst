tests
input: n_in output: n_out loss: loss_type hiddenLayers: n_h_layers hiddenNeuronsPerLayer: n_h_neurons dropout: h_dropout withKANN: aBlock
	| kad_node_t |
	kad_node_t := ((1 to: n_h_layers)
		inject: (Libkann inputLayer: n_in)
		into: [ :t :each | (t dense: n_h_neurons) relu dropout: h_dropout ])
		cost: n_out
		type: loss_type.
	^ kad_node_t withKANN: aBlock