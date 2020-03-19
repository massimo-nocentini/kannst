tests
testMNistFNN1_TrainAndSave_withCallback
	""

	Libkann srand: 11.	"Initialize the random generator."

	"Load training data."
	Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Then load targets."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-train-y.knd.gz') fullName
				with: [ :y | 
					| stats |
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Build the network"
					stats := self
						input: x n_col
						output: y n_col
						loss: (Libkann constants at: #KANN_C_CEB)
						hiddenLayersWithNeurons: {64 . 64 . 64 . 64}
						dropout: 0
						withKANN: [ :kann_t | 
							| epochs title stream |
							stream := Array new writeStream.
							epochs := 50.
							title := 'Training on MNIST data: '.
							UIManager default
								displayProgress: title
								from: 1
								to: epochs
								during: [ :bar | 
									"Train the network."
									(kann_t mt: 10 maxBatchSize: 64)
										trainFNN1: 0.001
										miniSize: 64
										maxEpoch: epochs
										maxDropStreak: 10
										fracVal: 0.1
										n: x n_row
										x: x x
										y: y x
										with: (self mlpStatsBlockForJob: bar title: title stream: stream) ].

							"And save it."
							kann_t saveToFileNamed: self mlpModelPath fullName.

							"Return stats."
							stream contents ] ] ]