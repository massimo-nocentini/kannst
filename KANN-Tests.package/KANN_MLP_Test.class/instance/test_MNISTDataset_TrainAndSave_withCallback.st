tests
test_MNISTDataset_TrainAndSave_withCallback
	self
		onMNISTDataset_build: [ :x :y | 
			({64 . 64 . 64 . 64}
				inject: (Libkann inputLayer: x n_col)
				into: [ :t :n_h_neurons | (t dense: n_h_neurons) relu dropout: 0 asFloat ])
				cost: y n_col
				type: (Libkann constants at: #KANN_C_CEB) ]
		train: [ :kann_t :x :y | 
			| epochs title stream |
			stream := Array new writeStream.
			epochs := 50.
			title := 'MLP training on MNIST data: '.

			"Start progressing"
			UIManager default
				displayProgress: title
				from: 1
				to: epochs
				during: [ :bar | 
					| handler |
					handler := LibkannTrainFNN1Handler new
						job: bar;
						title: title;
						stream: stream;
						ffiClosure.

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
						with: handler ].

			"Return stats."
			stream contents ]
		save: self mlpModelPath fullName