training
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y r: r p: p
	| batch_len step dataBaseOffset diff size pFirst prod |
	"Some inits"
	batch_len := spec batch_len min: tg len.
	prod := spec max_unroll * spec cs.
	step := spec minibatch_size * prod.
	dataBaseOffset := tg len - 1 - prod.
	diff := spec max_unroll - spec burnin_length.
	size := tg n_char * spec minibatch_size.
	pFirst := Array new: p size withAll: nil.

	"Unroll the network."
	^ kann_t
		unroll: spec max_unroll
		with: [ :ua | 
			"Start the unrolled network and setup the connections with x and y."
			self
				unroll: ua
				spec: spec
				x: x
				y: y.

			"Allocate space in the external memory to use the same indexing strategy."
			tg data
				asExternalArrayOf: #int
				with: [ :dataFFIArray :handle :type | 
					"Running over epochs"
					1 to: spec max_epoch do: [ :epoch | 
						| cost tot ctot n_cerr |
						cost := 0 asFloat.
						tot := 0.
						ctot := 0.
						n_cerr := 0.

						"Start iterating by batches."
						1 to: batch_len by: step do: [ :i | 
							| pRows |
							"Compute the rows of the matrix p that have to be tails of `tg data`"
							pRows := self
								p: p
								first: pFirst
								array: dataFFIArray
								handle: handle
								type: type
								baseOffset: dataBaseOffset.

							"Update x values just for nodes that have a valid predecessor."
							ua nodes
								select: [ :kad_node_t | kad_node_t predecessor isNotNil ]
								thenDo: [ :kad_node_t | kad_node_t values atAllPut: 0 asFloat ].

							"Iterate again."
							1 to: spec cs do: [ :c | 
								"Cleanup both matrices x and y."
								self
									x: x
									atAllPut: 0 asFloat
									y: y
									asAllPut: 0 asFloat
									size: size.

								"Complex step."
								self
									x: x
									y: y
									p: p
									type: type
									firstColumn: pFirst
									isFirst: c = 1
									tg_data_t: tg
									size: size
									spec: spec.

								"Update costs and tots"
								cost := (ua cost: 0 grad: true asBit) * spec max_unroll
									* spec minibatch_size + cost.
								tot := (c > 1
									ifTrue: [ spec max_unroll ]
									ifFalse: [ diff ]) * spec minibatch_size + tot.
								ctot := ctot
									+
										(spec minibatch_size
											asExternalAddressOfType: #int
											with: [ :intHandle | n_cerr := n_cerr + (ua class_error: intHandle) ]).

								"Grad clips"
								spec grad_clip > 0
									ifTrue: [ Libkann grad_clip: spec grad_clip n: r size g: ua g ].

								"Do one-step training"
								Libkann
									RMSprop: r size
									lr: spec lr
									vlr: ExternalAddress null
									decay: 0.9
									gradient: ua g
									variables: ua x
									memory: r getHandle ] ].

						"Show the progress into the Transcript."
						Transcript
							traceCr:
								('epoch: {1}; cost: {2} (class error: {3})'
									format:
										{epoch.
										(cost / tot) asFloat.
										(n_cerr / ctot * 100) asFloat}).

						"Finally, save the current model."
						kann_t saveToFileNamed: aPath fullName.

						"Return the tuple to collect stats."
						Array
							with: (cost / tot) asFloat
							with: (n_cerr / ctot * 100) asFloat ] ] ]