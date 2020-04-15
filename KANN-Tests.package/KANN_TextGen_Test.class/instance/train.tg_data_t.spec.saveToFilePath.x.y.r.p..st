tests
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y r: r p: p
	| batch_len step dataBaseOffset |
	"Some inits"
	step := spec minibatch_size * spec cs * spec max_unroll.
	batch_len := spec batch_len min: tg len.
	dataBaseOffset := tg len - 1 - (spec max_unroll * spec cs).

	"Unroll the network."
	kann_t
		unroll: spec max_unroll
		with: [ :ua | 
			ua
				urnn_start: spec minibatch_size;
				mt: spec n_threads maxBatchSize: spec minibatch_size;
				feed_bind: (Libkann constants at: #KANN_F_IN)
					label: 100
					arrays: x getHandle;
				feed_bind: (Libkann constants at: #KANN_F_TRUTH)
					label: 0
					arrays: y getHandle;
				switchToTraining.

			"Running over epochs"
			1 to: spec max_epoch do: [ :epoch | 
				| cost |
				cost := 0 asFloat.
				1 to: batch_len by: step do: [ :i | 
					1 to: p size do: [ :b | 
						| subarray end |
						end := (Libkautodiff drand * dataBaseOffset) truncated + 1.
						subarray := tg data copyFrom: 1 to: end.
						p at: b put: subarray as ] ] ] ]