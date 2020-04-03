tests
train: kann_t data: bit_data_t lr: lr mini_size: mini_size max_epoch: max_epoch n_threads: n_threads
	| n_var |
	self halt.
	n_var := kann_t size_var.
	FFIArray
		newArrayTypeOf: #float
		size: n_var
		with: [ :r | 
			FFIArray
				newArrayTypeOf: #'float *'
				size: bit_data_t ulen
				with: [ :x | 
					FFIArray
						newArrayTypeOf: #'float *'
						size: bit_data_t ulen
						with: [ :y | 
							1 to: bit_data_t ulen do: [ :i | 
								x
									at: i
									put: (FFIArray newArrayTypeOf: #float size: mini_size * bit_data_t n_in).
								y
									at: i
									put: (FFIArray newArrayTypeOf: #float size: mini_size * 2) ].
							FFIArray
								newArrayTypeOf: #int
								size: bit_data_t n
								with: [ :shuf | 
									| ua best_cost |
									best_cost := Float infinity.
									Libkann shuffle: bit_data_t n array: shuf.
									ua := (kann_t unroll: bit_data_t ulen)
										set_batch_size: mini_size;
										mt: n_threads maxBatchSize: mini_size;
										feed_bind: (Libkann constants at: #KANN_F_IN)
											label: 0
											arrays: x;
										feed_bind: (Libkann constants at: #KANN_F_TRUTH)
											label: 0
											arrays: y;
										switchToTraining;
										yourself.

									"Loops."
									1 to: max_epoch do: [ :epoch | 
										| cost tot |
										tot := cost := 0.
										0 to: bit_data_t n - mini_size - 1 by: mini_size do: [ :j | 
											0 to: bit_data_t ulen - 1 do: [ :k | 
												0 to: mini_size - 1 do: [ :b | 
													| s |
													s := shuf at: j + b + 1.
													1 to: bit_data_t n_in do: [ :i | 
														(x at: k + 1)
															at: b * bit_data_t n_in + i
															put: (bit_data_t x at: s * bit_data_t n_in + i) >> k & 1 ].
													(y at: k + 1)
														at: b * 2 + 1 put: 0;
														at: b * 2 + 2 put: 0.
													(y at: k + 1)
														at: b * 2 + ((bit_data_t y at: s) >> k & 1) + 1
														put: 1 ] ].

											"some increments."
											cost := (ua cost: 0 grad: 1) * bit_data_t ulen * mini_size
												+ cost.
											tot := bit_data_t ulen * mini_size + tot.

											"RMS propogation."
											Libkann
												RMSprop: n_var
												lr: lr
												vlr: 0
												decay: 0.9
												gradient: ua g
												variables: ua x
												memory: r ].

										"update the best cost and save the model in case of a new record."
										cost < best_cost
											ifTrue: [ best_cost := cost.
												kann_t
													saveToFileNamed: (self modelsPath / 'RNN.kan') fullName ] ] ].

							"release inner external arrays"
							x do: #free.
							y do: #free ] ] ]