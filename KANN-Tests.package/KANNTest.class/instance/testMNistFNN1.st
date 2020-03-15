tests
testMNistFNN1
	| anInteger |
	anInteger := Libkann_data
		readFromFileNamed:
			'/home/mn/Developer/snapshots/pharoes/80-timezone/pharo-local/iceberg/massimo-nocentini/kannst/data-and-models/kann-data/mnist-train-x.knd.gz'
		with: [ :x | 
			Libkann_data
				readFromFileNamed:
					'/home/mn/Developer/snapshots/pharoes/80-timezone/pharo-local/iceberg/massimo-nocentini/kannst/data-and-models/kann-data/mnist-train-y.knd.gz'
				with: [ :y | 
					| kann_t |
					self assert: x n_row equals: y n_row.
					kann_t := (((Libkann inputLayer: x n_col) dense: 64) relu
						cost: y n_col
						type: 2) kann.
					kann_t
						trainFNN1: 0.001
						miniSize: 64
						maxEpoch: 25
						maxDropStreak: 10
						fracVal: 0.1
						n: x n_row
						x: x x
						y: y x ] ].
	self halt