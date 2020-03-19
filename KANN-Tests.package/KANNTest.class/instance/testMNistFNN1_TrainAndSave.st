tests
testMNistFNN1_TrainAndSave
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
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Build the network"
					self
						input: x n_col
						output: y n_col
						loss: (Libkann constants at: #KANN_C_CEB)
						hiddenLayersWithNeurons: {64}
						dropout: 0 asFloat
						withKANN: [ :kann_t | 
							"Train the network."
							kann_t
								trainFNN1: 0.001
								miniSize: 64
								maxEpoch: 50
								maxDropStreak: 10
								fracVal: 0.1
								n: x n_row
								x: x x
								y: y x.

							"And save it."
							kann_t saveToFileNamed: self mlpModelPath fullName ] ] ]