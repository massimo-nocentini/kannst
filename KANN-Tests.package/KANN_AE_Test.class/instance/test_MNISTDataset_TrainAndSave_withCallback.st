tests
test_MNISTDataset_TrainAndSave_withCallback
	self
		onMNISTDataset_build: [ :x :y | self network: x ]
		train: [ :kann_t :x :y | 
			| epochs title stream |
			stream := Array new writeStream.
			epochs := 50.
			title := 'AE training on MNIST data: '.

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
					kann_t
						trainFNN1: 0.01
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
		save: self aeModelPath fullName