utilities
MNistFNN1_TrainAndSave_with: aBlock
	""

	Libkann srand: 11.	"Initialize the random generator."

	"Load training data."
	^ Libkann_data
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
						hiddenLayersWithNeurons: {64 . 64 . 64 . 64}
						dropout: 0
						withKANN: [ :kann_t | 
							| result |
							"Leave the given block to train the network and provide a result."
							result := aBlock value: kann_t value: x value: y.

							"Save the trained network before returning."
							kann_t saveToFileNamed: self mlpModelPath fullName.

							"Finally return the computed result."
							result ] ] ]