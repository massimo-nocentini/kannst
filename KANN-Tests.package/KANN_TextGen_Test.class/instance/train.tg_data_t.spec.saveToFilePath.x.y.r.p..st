training
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y r: r p: p
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
					| trainingData pFirst prod |
					"Some inits"
					prod := spec max_unroll * spec cs.
					pFirst := Array new: p size withAll: nil.

					"Prepare the data for training, lots of them so pack into a single object."
					trainingData := KANN_TextGen_TrainingData new
						batch_len: (spec batch_len min: tg len);
						step: spec minibatch_size * prod;
						pFirst: pFirst;
						dataFFIArray: dataFFIArray;
						handle: handle;
						type: type;
						dataBaseOffset: tg len - 1 - prod;
						ua: ua;
						spec: spec;
						size: tg n_char * spec minibatch_size;
						diff: spec max_unroll - spec burnin_length;
						yourself.

					"Running over epochs"
					(1 to: spec max_epoch)
						collect: [ :epoch | 
							| stats |
							"One more level of delegation."
							stats := self
								train: ua
								tg_data_t: tg
								spec: spec
								saveToFilePath: aPath
								x: x
								y: y
								r: r
								p: p
								data: trainingData.

							"Show the progress into the Transcript."
							Transcript
								traceCr:
									('epoch: {1}; cost: {2} (class error: {3})'
										format:
											{epoch.
											stats first.
											stats second}).

							"Finally, save the current model."
							kann_t saveToFileNamed: aPath fullName.

							"Return the tuple to collect stats."
							stats ] ] ]