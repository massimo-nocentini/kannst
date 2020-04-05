tests
train: kann_t data: bit_data_t lr: lr mini_size: mini_size max_epoch: max_epoch n_threads: n_threads
	| n_var |
	n_var := kann_t size_var.
	self
		train: kann_t
		data: bit_data_t
		mini_size: mini_size
		withArraysDo: [ :r :x :y :shuf | 
			| ua best_cost cost tot |
			"Some init"
			best_cost := Float infinity.

			"Unroll the RNN"
			ua := (kann_t unroll: bit_data_t ulen)
				set_batch_size: mini_size;
				mt: n_threads maxBatchSize: mini_size;
				feed_bind: (Libkann constants at: #KANN_F_IN)
					label: 0
					arrays: x getHandle;
				feed_bind: (Libkann constants at: #KANN_F_TRUTH)
					label: 0
					arrays: y getHandle;
				switchToTraining;
				yourself.

			"Loops."
			1 to: max_epoch do: [ :epoch | 
				tot := 0.
				cost := 0 asFloat.
				0 to: bit_data_t n - mini_size - 1 by: mini_size do: [ :j | 
					0 to: bit_data_t ulen - 1 do: [ :k | 
						0 to: mini_size - 1 do: [ :b | 
							| s array |
							s := shuf at: j + b + 1.
							array := FFIArray
								fromHandle: (x at: k + 1) getHandle
								type: #float
								size: mini_size * bit_data_t n_in.
							1 to: bit_data_t n_in do: [ :i | 
								| aFloat |
								aFloat := ((bit_data_t x at: s * bit_data_t n_in + i) >> k & 1)
									asFloat.
								array at: b * bit_data_t n_in + i put: aFloat ].
							(FFIArray
								fromHandle: (y at: k + 1) getHandle
								type: #float
								size: mini_size * 2)
								at: b * 2 + 1 put: 0 asFloat;
								at: b * 2 + 2 put: 0 asFloat;
								at: b * 2 + ((bit_data_t y at: s + 1) >> k & 1) + 1
									put: 1 asFloat ] ].

					"some increments."
					cost := (ua cost: 0 grad: 1) * bit_data_t ulen * mini_size + cost.
					tot := bit_data_t ulen * mini_size + tot.

					"RMS propogation."
					Libkann
						RMSprop: n_var
						lr: lr
						vlr: ExternalAddress null
						decay: 0.9
						gradient: ua g
						variables: ua x
						memory: r getHandle ].

				"update the best cost and save the model in case of a new record."
				"										cost < best_cost
											ifTrue: [ best_cost := cost.
												kann_t
													saveToFileNamed: (self modelsPath / 'RNN.kan') fullName.
												Transcript traceCr: 'model saved' ].
"
				Transcript
					traceCr:
						('epoch: {1}; cost: {2}'
							format:
								{epoch.
								(cost / tot)}) ] ]