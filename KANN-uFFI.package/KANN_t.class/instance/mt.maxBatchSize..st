training
mt: n_threads maxBatchSize: max_batch_size
	^ self
		ffiCall: #(void kann_mt #(KANN_t * self , int n_threads , int max_batch_size))
		library: Libkann