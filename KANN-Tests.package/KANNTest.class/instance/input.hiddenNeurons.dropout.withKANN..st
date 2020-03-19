tests
input: n_in hiddenNeurons: n_hidden dropout: i_dropout withKANN: aBlock
	| x t w r |
	self halt.
	w := Libkann weight: n_hidden cols: n_in.
	r := Libkann
		flag: (Libkautodiff constants at: #KAD_VAR)
		scalar: (n_in / n_hidden) sqrt asFloat.
	x := Libkautodiff feed: 1 feed: n_in.
	x
		ext_flag:
			(x ext_flag
				bitOr:
					((Libkann constants at: #KANN_F_IN)
						bitOr: (Libkann constants at: #KANN_F_TRUTH))).
	t := ((((((x dropout: i_dropout) cmul: w)
		add: (Libkann bias: n_hidden)) tanh mul: r) matmul: w)
		add: (Libkann bias: n_in)) sigm.
	t ext_flag: (Libkann constants at: #KANN_F_OUT).
	t := t ce_bin: x.
	t ext_flag: (Libkann constants at: #KANN_F_COST).
	^ t withKANN: aBlock