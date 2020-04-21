training
unroll: ua spec: spec x: x y: y
	ua
		urnn_start: spec minibatch_size;
		mt: spec n_threads maxBatchSize: spec minibatch_size;
		feed_bind: (Libkann constants at: #KANN_F_IN)
			label: 100
			arrays: x getHandle;
		feed_bind: (Libkann constants at: #KANN_F_TRUTH)
			label: 0
			arrays: y getHandle;
		switchToTraining