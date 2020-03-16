tests
testMNistFNN1
	| anInteger |
	"First load observations."
	anInteger := Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Then load targets."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-train-y.knd.gz') fullName
				with: [ :y | 
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Build the network."
					(((Libkann inputLayer: x n_col) dense: 64) relu
						cost: y n_col
						type: 2)
						withKANN: [ :kann_t | 
							kann_t
								trainFNN1: 0.001
								miniSize: 64
								maxEpoch: 10
								maxDropStreak: 10
								fracVal: 0.1
								n: x n_row
								x: x x
								y: y x.
							self halt ] ] ]