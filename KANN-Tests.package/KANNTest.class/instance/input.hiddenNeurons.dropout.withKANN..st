tests
input: n_in hiddenNeurons: n_hidden dropout: i_dropout withKANN: aBlock
	| x t w r |
	w := Libkann weight: n_hidden cols: n_in.
	r := Libkann
		flag: (Libkautodiff constants at: #KAD_VAR)
		scalar: (n_in / n_hidden) sqrt asFloat.
	x := Libkautodiff feed: 1 feed: n_in.
	x
		ext_flag: (Libkann constants at: #KANN_F_IN) update: true asBit;
		ext_flag: (Libkann constants at: #KANN_F_TRUTH) update: true asBit.
	t := ((((((x dropout: i_dropout) cmul: w)
		add: (Libkann bias: n_hidden)) tanh mul: r) matmul: w)
		add: (Libkann bias: n_in)) sigm.
	t ext_flag: (Libkann constants at: #KANN_F_OUT) update: false asBit.
	t := t ce_bin: x.
	t ext_flag: (Libkann constants at: #KANN_F_COST) update: false asBit.
	^ t withKANN: aBlock