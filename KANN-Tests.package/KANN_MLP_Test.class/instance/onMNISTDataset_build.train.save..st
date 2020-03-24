utilities
onMNISTDataset_build: buildBlock train: trainingBlock save: aFilename
	""

	"Trap on division by zero and initialize the random generator."

	Libkautodiff trap_fe.
	Libkann srand: 11.

	"Load training data."
	^ Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Then load targets."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-train-y.knd.gz') fullName
				with: [ :y | 
					| kad_node_t |
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Compose the network topology"
					kad_node_t := buildBlock value: x value: y.

					"Build the network object"
					kad_node_t
						withKANN: [ :kann_t | 
							| result |
							"Leave the given block to train the network and provide a result."
							result := trainingBlock value: kann_t value: x value: y.

							"Save the trained network before returning."
							kann_t saveToFileNamed: aFilename.

							"Finally return the computed result."
							result ] ] ]