tests
train: kann_t data: bit_data_t lr: lr mini_size: mini_size max_epoch: max_epoch n_threads: n_threads
	| n_var |
	n_var := kann_t size_var.
	self
		train: kann_t
		data: bit_data_t
		mini_size: mini_size
		withArraysDo: [ :r :x :y :shuf | 
			| best_cost |
			"Some init"
			best_cost := Float infinity.

			"Unroll the RNN"
			kann_t
				unroll: bit_data_t ulen
				with: [ :ua | 
					ua
						set_batch_size: mini_size;
						mt: n_threads maxBatchSize: mini_size;
						feed_bind: (Libkann constants at: #KANN_F_IN)
							label: 0
							arrays: x getHandle;
						feed_bind: (Libkann constants at: #KANN_F_TRUTH)
							label: 0
							arrays: y getHandle;
						switchToTraining.

					"Loops."
					1 to: max_epoch do: [ :epoch | 
						| cost tot |
						tot := 0.
						cost := 0 asFloat.
						0 to: bit_data_t n - mini_size - 1 by: mini_size do: [ :j | 
							"Update x and y matrices."
							self
								index: j
								data: bit_data_t
								mini_size: mini_size
								shuffle: shuf
								x: x
								y: y.

							"some increments."
							cost := (ua cost: 0 grad: true asBit) * bit_data_t ulen
								* mini_size + cost.
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
						cost < best_cost
							ifTrue: [ best_cost := cost.
								kann_t saveToFileNamed: self rnnModelPath fullName.
								Transcript traceCr: 'model saved' ].

						"simple debug, sostitute it with the progress bar."
						Transcript
							traceCr:
								('epoch: {1}; cost: {2}'
									format:
										{epoch.
										(cost / tot)}) ] ] ]