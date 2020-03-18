tests
testMNistFNN1_LoadAndApply
	| predictions indicators contents |
	predictions := Libkann
		loadFromFileNamed: (self modelsPath / 'mlp.kan') fullName
		with: [ :kann_t | 
			kann_t switchToPrediction.
			"Apply it."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-test-x.knd.gz') fullName
				with: [ :xx | 
					(xx x getHandle
						readArrayOf: #'float *'
						until: [ :a :j | j > xx n_row ])
						collect: [ :aFloatAddress | 
							(kann_t apply1: aFloatAddress) getHandle
								readArrayOf: #float
								until: [ :f :j | j > kann_t dimOut ] ] ] ].
	indicators := Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-test-y.knd.gz') fullName
		with: [ :y | 
			| P |
			P := predictions
				collect: [ :each | 
					| argMax |
					argMax := each argOpt: #> init: Float negativeInfinity.
					(Array new: y n_col withAll: 0)
						at: argMax put: 1;
						yourself ].
			(y xValue collect: #truncated) with: P collect: #= ].
	contents := indicators asBag valuesAndCounts.
	self assert: (contents at: true) >= (contents at: false)