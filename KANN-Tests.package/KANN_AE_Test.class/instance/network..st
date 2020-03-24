tests
network: x
	| z t w r n_in n_hidden |
	n_in := x n_col.
	n_hidden := 64.
	w := Libkann weight: n_hidden cols: n_in.
	r := Libkann
		flag: (Libkautodiff constants at: #KAD_VAR)
		scalar: (n_in / n_hidden) sqrt asFloat.
	z := (Libkautodiff feed: 1 feed: n_in)
		ext_flag: (Libkann constants at: #KANN_F_IN) update: true asBit;
		ext_flag: (Libkann constants at: #KANN_F_TRUTH) update: true asBit;
		yourself.
	t := ((((((z dropout: 0 asFloat) cmul: w)
		add: (Libkann bias: n_hidden)) tanh mul: r) matmul: w)
		add: (Libkann bias: n_in)) sigm.
	t ext_flag: (Libkann constants at: #KANN_F_OUT) update: false asBit.
	t := t ce_bin: z.
	^ t
		ext_flag: (Libkann constants at: #KANN_F_COST) update: false asBit;
		yourself