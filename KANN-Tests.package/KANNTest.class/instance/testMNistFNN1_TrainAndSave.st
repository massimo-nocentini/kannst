tests
testMNistFNN1_TrainAndSave
	self
		MNistFNN1_TrainAndSave_with: [ :kann_t :x :y | 
			kann_t
				trainFNN1: 0.001
				miniSize: 64
				maxEpoch: 50
				maxDropStreak: 10
				fracVal: 0.1
				n: x n_row
				x: x x
				y: y x ]