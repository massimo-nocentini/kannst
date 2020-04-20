tests
testTrain
	| kad_node_t tg |
	Libkann srand: 11.
	tg := self tg_data_t_Accelerando.
	kad_node_t := self
		network: self gruBlock
		input: tg n_char
		neurons: {128}
		dropout: 0 asFloat.
	kad_node_t
		withKANN: [ :kann_t | 
			| spec |
			"Build the spec for training"
			spec := KANN_TextGen_TrainingSpec new
				lr: 0.01;
				max_unroll: 70;
				burnin_length: 10;
				cs: 100;
				minibatch_size: 64;
				max_epoch: 2;
				grad_clip: 10 asFloat;
				batch_len: 1000000;
				n_threads: 1;
				yourself.

			"Train, really."
			self
				train: kann_t
				tg_data_t: tg
				spec: spec
				saveToFilePath: self modelsPath / 'textgen-gru.kan' ]