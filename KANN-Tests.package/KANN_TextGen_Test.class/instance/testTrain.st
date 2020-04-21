tests
testTrain
	| kad_node_t tg |
	Libkann srand: 11.
	tg := self tg_data_t_Accelerando_small.
	kad_node_t := self
		network: self gruBlock
		input: tg n_char
		neurons: {64}
		dropout: 0 asFloat.
	kad_node_t
		withKANN: [ :kann_t | 
			| spec stats |
			"Build the spec for training"
			spec := KANN_TextGen_TrainingSpec new
				lr: 0.01;
				max_unroll: 70;
				burnin_length: 10;
				cs: 100;
				minibatch_size: 64;
				max_epoch: 4;
				grad_clip: 10 asFloat;
				batch_len: 1000000;
				n_threads: 1;
				yourself.

			"Train, really."
			stats := self
				train: kann_t
				tg_data_t: tg
				spec: spec
				saveToFilePath: self modelsPath / 'textgen-gru.kan'.

			"Assertions"
			self
				assert: (stats at: 1)
					equals: (Array with: 1.8541372564217564 with: 50.73609620886982);
				assert: (stats at: 2)
					equals: (Array with: 1.1122198435711077 with: 29.81066702432046);
				assert: (stats at: 3)
					equals: (Array with: 0.7818368182161847 with: 20.293052575107296);
				assert: (stats at: 4)
					equals: (Array with: 0.5892095999400503 with: 14.465084048640916) ]