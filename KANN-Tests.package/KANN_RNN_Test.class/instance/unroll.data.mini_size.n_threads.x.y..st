tests
unroll: kann_t data: bit_data_t mini_size: mini_size n_threads: n_threads x: x y: y
	^ (kann_t unroll: bit_data_t ulen)
		set_batch_size: mini_size;
		mt: n_threads maxBatchSize: mini_size;
		feed_bind: (Libkann constants at: #KANN_F_IN)
			label: 0
			arrays: x getHandle;
		feed_bind: (Libkann constants at: #KANN_F_TRUTH)
			label: 0
			arrays: y getHandle;
		switchToTraining;
		yourself