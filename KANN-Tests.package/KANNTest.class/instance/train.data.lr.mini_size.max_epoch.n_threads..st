tests
train: kann_t data: bit_data_t lr: lr mini_size: mini_size max_epoch: max_epoch n_threads: n_threads
	| n_var |
	n_var := kann_t size_var.
	FFIExternalArray
		newArrayTypeOf: #float
		size: n_var
		with: [ :r | 
			r atAllPut: 0.	"to simulate `calloc` behavior"
			FFIExternalArray
				newArrayTypeOf: #'float *'
				size: bit_data_t ulen
				with: [ :x | 
					FFIExternalArray
						newArrayTypeOf: #'float *'
						size: bit_data_t ulen
						with: [ :y | 
							1 to: bit_data_t ulen do: [ :j | 
								x
									at: j
									put:
										(FFIExternalArray
											externalNewType: #float
											size: mini_size * bit_data_t n_in) getHandle.
								y
									at: j
									put:
										(FFIExternalArray externalNewType: #float size: mini_size * 2)
											getHandle ].
							FFIExternalArray
								newArrayTypeOf: #int
								size: bit_data_t n
								with: [ :shuf | 
									| ua best_cost |
									"Some init"
									best_cost := Float infinity.
									Libkann shuffle: bit_data_t n array: shuf getHandle.

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
										| cost tot |
										tot := cost := 0.
										0 to: bit_data_t n - mini_size - 1 by: mini_size do: [ :j | 
											0 to: bit_data_t ulen - 1 do: [ :k | 
												0 to: mini_size - 1 do: [ :b | 
													| s |
													s := shuf at: j + b + 1.
													1 to: bit_data_t n_in do: [ :i | 
														(FFIExternalArray fromHandle: (x at: k + 1) getHandle type: #float)
															at: b * bit_data_t n_in + i
															put: (bit_data_t x at: s * bit_data_t n_in + i) >> k & 1 ].
													(FFIExternalArray
														fromHandle: (y at: k + 1) getHandle
														type: #float)
														at: b * 2 + 1 put: 0;
														at: b * 2 + 2 put: 0;
														at: b * 2 + ((bit_data_t y at: s + 1) >> k & 1) + 1
															put: 1 ] ].

											"some increments."
											cost := (ua cost: 0 grad: 1) * bit_data_t ulen * mini_size
												+ cost.
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
											ifTrue: [ Transcript traceCr: 'model saved'.
												best_cost := cost.
												kann_t
													saveToFileNamed: (self modelsPath / 'RNN.kan') fullName ].
										Transcript
											traceCr:
												('epoch: {1}; cost: {2}'
													format:
														{epoch.
														(cost / tot)}) ] ].

							"release inner external arrays"
							x do: #free.
							y do: #free ] ] ]