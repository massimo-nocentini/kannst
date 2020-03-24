tests
test_MNISTDataset_TrainAndSave
	self
		onMNISTDataset_build: [ :x :y | 
			({64 . 64 . 64 . 64}
				inject: (Libkann inputLayer: x n_col)
				into: [ :t :n_h_neurons | (t dense: n_h_neurons) relu dropout: 0 asFloat ])
				cost: y n_col
				type: (Libkann constants at: #KANN_C_CEB) ]
		train: [ :kann_t :x :y | 
			kann_t
				trainFNN1: 0.001
				miniSize: 64
				maxEpoch: 50
				maxDropStreak: 10
				fracVal: 0.1
				n: x n_row
				x: x x
				y: y x ]
		save: self mlpModelPath fullName