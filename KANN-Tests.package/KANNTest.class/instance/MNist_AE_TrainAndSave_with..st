utilities
MNist_AE_TrainAndSave_with: aBlock
	""

	"Trap on division by zero and initialize the random generator."

	Libkautodiff trap_fe.
	Libkann srand: 11.	"Initialize the random generator."

	"Load training data."
	^ Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Build the network"
			self
				input: x n_col
				hiddenNeurons: 64
				dropout: 0 asFloat
				withKANN: [ :kann_t | 
					| result |
					"Leave the given block to train the network and provide a result."
					result := aBlock value: kann_t value: x value: x.

					"Save the trained network before returning."
					kann_t saveToFileNamed: self aeModelPath fullName.

					"Finally return the computed result."
					result ] ]