tests
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y r: r p: p
	| batch_len step dataBaseOffset diff size pFirst |
	"Some inits"
	step := spec minibatch_size * spec cs * spec max_unroll.
	batch_len := spec batch_len min: tg len.
	dataBaseOffset := tg len - 1 - (spec max_unroll * spec cs).
	diff := spec max_unroll - spec burnin_length.
	size := size := tg n_char * spec minibatch_size.
	pFirst := Array new: p size withAll: nil.

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

			"Allocate space in the external memory to use the same indexing strategy."
			tg data
				asExternalArrayOf: #int
				with: [ :dataFFIArray :type | 
					| handle |
					handle := dataFFIArray getHandle.
					"Running over epochs"
					1 to: spec max_epoch do: [ :epoch | 
						| cost tot |
						cost := 0 asFloat.
						tot := 0.
						1 to: batch_len by: step do: [ :i | 
							1 to: p size do: [ :b | 
								| offset pArray |
								offset := (Libkautodiff drand * dataBaseOffset) truncated.
								pFirst
									at: b
									put: (type handle: handle + (type typeSize * offset) at: 1).
								offset := offset + 1.
								pArray := FFIArray
									fromHandle: handle + (type typeSize * offset)
									type: #int
									size: dataFFIArray size - offset.
								p at: b put: pArray getHandle ].
							ua nodes
								reject: [ :kad_node_t | kad_node_t pre isNull ]
								thenDo: [ :kad_node_t | kad_node_t x_memset: 0 ].
							1 to: spec cs do: [ :c | 
								| ce_len |
								ce_len := c > 1
									ifTrue: [ spec max_unroll ]
									ifFalse: [ diff ].
								x
									do: [ :xHandle | 
										(FFIArray fromHandle: xHandle type: #float size: size)
											atAllPut: 0 asFloat ].
								y
									do: [ :yHandle | 
										(FFIArray fromHandle: yHandle type: #float size: size)
											atAllPut: 0 asFloat ].
								1 to: spec minibatch_size do: [ :b | 
									| pHandle pArray baseIndex |
									baseIndex := (b - 1) * tg n_char.
									pHandle := p at: b.
									pArray := FFIArray
										fromHandle: pHandle
										type: #int
										size: spec max_unroll.
									1 to: spec max_unroll do: [ :u | 
										| xArray |
										xArray := FFIArray
											fromHandle: (x at: u)
											type: #float
											size: size.
										xArray
											at: baseIndex + (pArray at: u - 1 ifAbsent: [ pFirst at: b ])
											put: 1 asFloat.
										(c > 1 or: [ u - 1 >= spec burnin_length ])
											ifTrue: [ | yArray |
												yArray := FFIArray
													fromHandle: (y at: u)
													type: #float
													size: size.
												yArray at: baseIndex + (pArray at: u) put: 1 asFloat ] ].
									p at: b put: pHandle + (spec max_unroll * type typeSize).
									self halt.
									FFIArray
										fromHandle: (p at: b)
										type: #int
										size: spec max_unroll ].
								cost := (ua cost: 0 type: 1) * spec max_unroll
									* spec minibatch_size + cost.
								tot := ce_len * spec minibatch_size.
								spec grad_clip > 0 asFloat
									ifTrue: [ Libkann grad_clip: spec grad_clip n: r size g: ua g ].
								Libkann
									RMSprop: r size
									lr: spec lr
									vlr: ExternalAddress null
									decay: 0.9
									gradient: ua g
									variables: ua x
									memory: r getHandle ] ].
						Transcript
							traceCr:
								('epoch: {1}; cost: {2}'
									format:
										{epoch.
										(cost / tot)}).
						kann_t saveToFileNamed: aPath fullName ] ] ]