tests
network: x target: y
	| t n_h_flt dropout n_h_fc |
	"Setting up some parameters"
	n_h_flt := 32.
	dropout := 0.2.
	n_h_fc := 128.

	"Network topology"
	t := Libkautodiff
		feed: 1
		feed: 1
		feed: 28
		feed: 28.
	t ext_flag: (Libkann constants at: #KANN_F_IN) update: true asBit.
	t := (t
		conv2d: n_h_flt
		rows: 3
		cols: 3
		row_stride: 1
		col_stride: 1
		row_pad: 0
		col_pad: 0) relu.
	t := (t
		conv2d: n_h_flt
		rows: 3
		cols: 3
		row_stride: 1
		col_stride: 1
		row_pad: 0
		col_pad: 0) relu.
	t := t
		max2d: 2
		width: 2
		row_stride: 2
		col_stride: 2
		row_pad: 0
		col_pad: 0.
	^ (((t dropout: dropout) dense: n_h_fc) relu dropout: dropout)
		cost: y n_col
		type: (Libkann constants at: #KANN_C_CEB)