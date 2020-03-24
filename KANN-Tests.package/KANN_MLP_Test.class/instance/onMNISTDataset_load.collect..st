tests
onMNISTDataset_load: aFilename collect: aBlock
	^ Libkann
		loadFromFileNamed: aFilename
		with: [ :kann_t | 
			| predictions |
			kann_t switchToPrediction.
			"Apply it."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-test-x.knd.gz') fullName
				with: [ :x | 
					"Ensure dimensions match."
					self assert: kann_t dimIn equals: x n_col.

					"Load the test observations"
					predictions := x x_rows
						collect: [ :aFloatAddress | 
							| handle probs |
							"Apply the network."
							handle := kann_t apply1: aFloatAddress.

							"and return the array with probabilities"
							probs := handle asArrayOf: #float size: kann_t dimOut.

							"Check that it is actually a distribution"
							"self assert: (probs sum closeTo: 1 precision: 1e-1)."

							"Finally return the predicted array"
							probs ].
					Libkann_data
						readFromFileNamed: (self dataPath / 'mnist-test-y.knd.gz') fullName
						with: [ :y | aBlock value: x value: y value: predictions ] ] ]