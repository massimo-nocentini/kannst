tests
network: z
	| x t s mu sigma n_in n_hidden n_code |
	"Settings up some parameters"
	n_in := z n_col.
	n_hidden := 64.
	n_code := 2.

	"Encoder"
	x := (Libkautodiff feed: 1 feed: n_in)
		ext_flag: (Libkann constants at: #KANN_F_IN) update: true asBit;
		ext_flag: (Libkann constants at: #KANN_F_TRUTH) update: true asBit;
		yourself.
	t := (x dense: n_hidden) tanh.
	mu := t dense: n_code.
	sigma := (t dense: n_code) relu.
	t := sigma sample_normal add: mu.
	t ext_label: 1 update: false asBit.

	"Decoder"
	t := ((t dense: n_hidden) tanh dense: n_in) sigm.
	t ext_flag: (Libkann constants at: #KANN_F_OUT) update: false asBit.
	t := (t ce_bin: x) mul: (Libkann const_scalar: n_in asFloat).

	"Latent loss"
	s := sigma square add: (Libkann const_scalar: 1e-6).	"sigma^2, plus a pseudo-count"
	s := s sub: s log.	"sigma^2 - log(sigma^2)"
	s := s add: mu square.	"mu^2 + sigma^2 - log(sigma^2)"
	s := s sub: (Libkann const_scalar: 1 asFloat).	"mu^2 + sigma^2 - log(sigma^2) - 1"
	s := s reduce_sum: 1.
	s := s mul: (Libkann const_scalar: 0.5).
	s := s reduce_mean: 0.

	"Finalizing"
	t := (t add: s)
		mul: (Libkann const_scalar: (1 / (2 * n_code + n_in)) asFloat).
	^ t
		ext_flag: (Libkann constants at: #KANN_F_COST) update: true asBit;
		yourself