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
			| kad_node_t |
			"Compose the network topology"
			kad_node_t := buildBlock value: x value: x.

			"Build the network object"
			kad_node_t
				withKANN: [ :kann_t | 
					| result |
					"Leave the given block to train the network and provide a result."
					result := trainingBlock value: kann_t value: x value: x.

					"Save the trained network before returning."
					kann_t saveToFileNamed: aFilename.

					"Finally return the computed result."
					result ] ]