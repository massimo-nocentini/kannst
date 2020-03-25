tests
test_MNISTDataset_generation
	Libkann
		loadFromFileNamed: self aeModelPath fullName
		with: [ :kann_t | 
			| out t n_gen f_out_flag generated |
			f_out_flag := Libkann constants at: #KANN_F_OUT.
			kann_t set_batch_size: 1.
			out := kann_t find_node: f_out_flag label: 0.
			t := kann_t find_node: 0 label: 1.

			"Generate 10 samples."
			n_gen := 100.
			generated := (1 to: n_gen)
				collect: [ :j | 
					| handle |
					t
						eval_state: false asBit;
						x_drand_normal.
					handle := kann_t fevalWithFlag: f_out_flag withLabel: 0.
					handle asArrayOf: #float size: out dimensions ].

			"Store new digits in a file"
			(self dataPath / 'mnist-generated-vae.knd') asFileReference
				writeStreamDo: [ :aStream | 
					aStream
						nextPutAll: '#no';
						tab;
						nextPutAll:
							(Character tab
								join:
									((0 to: out dimensions - 1)
										collect: [ :i | (i // 28) asString , ':' , (i \\ 28) asString ])).
					generated
						withIndexCollect: [ :anArray :i | 
							aStream
								crlf;
								nextPutAll: i asString;
								tab;
								nextPutAll: (Character tab join: (anArray collect: [ :f | f asString ])) ] ] ]