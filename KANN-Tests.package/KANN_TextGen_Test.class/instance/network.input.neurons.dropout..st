tests
network: trainingBlock input: anInteger neurons: aCollection dropout: dropout
	| input kad_node_t t1 |
	input := (Libkann inputLayer: anInteger)
		ext_label: 100 update: false asBit;
		yourself.
	kad_node_t := aCollection
		inject: input
		into:
			[ :t :n_h_neurons | (trainingBlock value: t value: n_h_neurons) dropout: dropout ].

	"t1 is the inverse of temperature"
	t1 := (Libkann const_scalar: 1 asFloat)
		ext_label: -1 update: false asBit;
		yourself.
	kad_node_t := ((kad_node_t dense: anInteger) mul: t1) softmax
		ext_flag: (Libkann constants at: #KANN_F_OUT) update: true asBit;
		yourself.
	t1 := (Libkautodiff feed: 1 feed: anInteger)
		ext_flag: (Libkann constants at: #KANN_F_TRUTH) update: true asBit;
		yourself.
	^ (kad_node_t ce_multi: t1)
		ext_flag: (Libkann constants at: #KANN_F_COST) update: true asBit;
		yourself