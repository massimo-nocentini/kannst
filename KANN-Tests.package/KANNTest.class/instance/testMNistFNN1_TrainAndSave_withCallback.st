tests
testMNistFNN1_TrainAndSave_withCallback
	| modelPath |
	"File path to the model saved after training."
	modelPath := self modelsPath / 'mlp.kan'.

	"Load training data."
	Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			"Then load targets."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-train-y.knd.gz') fullName
				with: [ :y | 
					"Check that dimensions match."
					self assert: x n_row equals: y n_row.

					"Build the network"
					self
						input: x n_col
						output: y n_col
						loss: (Libkann constants at: #KANN_C_CEB)
						hiddenLayers: 1
						hiddenNeuronsPerLayer: 64
						dropout: 0 asFloat
						withKANN: [ :kann_t | 
							| epochs title |
							epochs := 50.
							title := 'Training on MNIST data: '.
							UIManager default
								displayProgress: title
								from: 1
								to: epochs
								during: [ :bar | 
									"Train the network."
									kann_t
										trainFNN1: 0.001
										miniSize: 64
										maxEpoch: 50
										maxDropStreak: 10
										fracVal: 0.1
										n: x n_row
										x: x x
										y: y x
										with:
											[ :i :train_cost :n_train_base :class_error :n_val :val_cost :n_val_base :validation_class_error | 
											| msg |
											msg := String
												streamContents: [ :s | 
													s
														nextPutAll:
															('epoch: {1}; training cost: {2}'
																format:
																	{i.
																	train_cost}).
													n_train_base = 0
														ifFalse: [ s nextPutAll: (' (class error: {1})' format: {class_error}) ].
													n_val > 0
														ifTrue: [ s nextPutAll: ('; validation cost: {1}' format: {val_cost}).
															n_val_base = 0
																ifFalse: [ ' (class error: {1}' format: {validation_class_error} ] ] ].
											bar
												current: i;
												title: title , msg ] ].

							"And save it."
							kann_t saveToFileNamed: modelPath fullName ] ] ]