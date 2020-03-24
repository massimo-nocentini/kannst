tests
test_MNISTDataset_TrainAndSave
	self
		onMNISTDataset_build: [ :x :y | self network: x ]
		train: [ :kann_t :x :y | 
			kann_t
				trainFNN1: 0.01
				miniSize: 64
				maxEpoch: 50
				maxDropStreak: 10
				fracVal: 0.1
				n: x n_row
				x: x x
				y: y x ]
		save: self aeModelPath fullName