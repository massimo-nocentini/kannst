tests
testMNistFNN1_TrainAndSave_withCallback
	self
		MNistFNN1_TrainAndSave_with: [ :kann_t :x :y | 
			| epochs title stream |
			stream := Array new writeStream.
			epochs := 50.
			title := 'Training on MNIST data: '.

			"Start progressing"
			UIManager default
				displayProgress: title
				from: 1
				to: epochs
				during: [ :bar | 
					"Train the network."
					(kann_t mt: 10 maxBatchSize: 64)
						trainFNN1: 0.001
						miniSize: 64
						maxEpoch: epochs
						maxDropStreak: 10
						fracVal: 0.1
						n: x n_row
						x: x x
						y: y x
						with: (self mlpStatsBlockForJob: bar title: title stream: stream) ].

			"Return stats."
			stream contents ]