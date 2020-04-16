tests
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
	kann_t
		unroll: spec max_unroll
		with: [ :ua | 
			"Start the unrolled network and setup the connections with x and y."
			self unroll: ua spec: spec x: x y: y.

			"Allocate space in the external memory to use the same indexing strategy."
			tg data asExternalArrayOf: #int with: [ :dataFFIArray :handle :type | 
					"Running over epochs"
					1 to: spec max_epoch do: [ :epoch | 
						| cost tot |
						cost := 0 asFloat.
						tot := 0.
						1 to: batch_len by: step do: [ :i | 
							| pRows |
							
							"Compute the rows of the matrix p that have to be tails of `tg data`"
							pRows := self p: p first: pFirst array: dataFFIArray handle: handle type: type baseOffset: dataBaseOffset.

							"Update x values just for nodes that have a valid predecessor."
							ua nodes
								select: [ :kad_node_t | kad_node_t predecessor isNotNil ]
								thenDo: [ :kad_node_t | kad_node_t x_memset: 0 ].
								
							1 to: spec cs do: [ :c | 

								"Cleanup both matrices x and y."
								self x: x atAllPut: 0 asFloat y: y asAllPut: 0 asFloat size: size.
								
								"Complex step."
								self x: x y: y p: p type: type firstColumn: pFirst isFirst: c = 1 tg_data_t: tg size: size spec: spec.
								
								"Update costs and tots"
								cost := (ua cost: 0 grad: true asBit) * spec max_unroll * spec minibatch_size + cost.
								tot := (c > 1 ifTrue: [ spec max_unroll ] ifFalse: [ diff ]) * spec minibatch_size + tot.
								Transcript traceCr: cost.
	
								"Grad clips"										
								spec grad_clip > 0 ifTrue: [ Libkann grad_clip: spec grad_clip n: r size g: ua g ].
								
								Libkann
									RMSprop: r size
									lr: spec lr
									vlr: ExternalAddress null
									decay: 0.9
									gradient: ua g
									variables: ua x
									memory: r getHandle ] ].
						self halt.
						Transcript
							traceCr:
								('epoch: {1}; cost: {2}'
									format:
										{epoch.
										(cost / tot)}).
						kann_t saveToFileNamed: aPath fullName ] ] ]