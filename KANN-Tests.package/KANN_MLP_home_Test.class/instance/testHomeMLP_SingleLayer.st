tests
testHomeMLP_SingleLayer
	"Load the features of the train set."

	Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Then load the targets of the train set."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-train-y.knd.gz') fullName
				with: [ :y | 
					| kad_node_t |
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Compose the network topology, 1 hidden layer of 64 neurons, simply."
					kad_node_t := ((Libkann inputLayer: x n_col) dense: 64) relu
						cost: y n_col
						type: (Libkann constants at: #KANN_C_CEM).

					"Build the network object cleaning up C heap memory after ourselves."
					kad_node_t
						withKANN: [ :kann_t | 
							"Train the network."
							kann_t
								trainFNN1: 0.001
								miniSize: 64
								maxEpoch: 25
								maxDropStreak: 10
								fracVal: 0.1
								n: x n_row
								x: x x
								y: y x.

							"Save the model to be loaded for further applications."
							kann_t saveToFileNamed: self mlpModelPath fullName.

							"Then switch to prediction."
							kann_t switchToPrediction.

							"Load the train set."
							Libkann_data
								readFromFileNamed: (self dataPath / 'mnist-test-x.knd.gz') fullName
								with: [ :xx | 
									| predictions |
									"Ensure dimensions match."
									self assert: kann_t dimIn equals: x n_col.

									"Load the test observations"
									predictions := xx x_rows
										collect: [ :aFloatAddress | 
											| handle |
											"Apply the network."
											handle := kann_t apply1: aFloatAddress.

											"and return the array with probabilities"
											handle asArrayOf: #float size: kann_t dimOut ].

									"Load the validation set."
									Libkann_data
										readFromFileNamed: (self dataPath / 'mnist-test-y.knd.gz') fullName
										with: [ :yy | 
											| P indicators contents trues falses |
											P := predictions
												collect: [ :each | 
													| argMax |
													argMax := each
														argOpt: [ :f :opt | f > opt ]
														init: Float negativeInfinity.
													(Array new: yy n_col withAll: 0)
														at: argMax put: 1;
														yourself ].

											"Build the indicators of correct predictions."
											indicators := (yy xValue collect: #truncated)
												with: P
												collect: [ :target :predicted | target = predicted ].

											"Check precision."
											contents := indicators asBag valuesAndCounts.
											trues := contents at: true.
											falses := contents at: false.
											self assert: (trues / (trues + falses)) asFloat > 0.95 ] ] ] ] ]