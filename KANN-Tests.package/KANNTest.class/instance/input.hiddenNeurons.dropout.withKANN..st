tests
input: n_in hiddenNeurons: n_hidden dropout: i_dropout withKANN: aBlock
	| x t w r |
	w := Libkann weight: n_hidden cols: n_in.
	r := Libkann
		scalar: (n_in / n_hidden) sqrt
		flag: (Libkautodiff constants at: #KAD_VAR).
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
	t ext_flag: (Libkautodiff constants at: #KANN_F_OUT).
	t := t ce_bin: x.
	t ext_flag: (Libkautodiff constants at: #KANN_F_COST).
	^ t withKANN: aBlock