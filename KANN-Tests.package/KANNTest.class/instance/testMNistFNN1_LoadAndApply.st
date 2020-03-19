tests
testMNistFNN1_LoadAndApply
	| predictions indicators contents trues falses |
	predictions := Libkann
		loadFromFileNamed: self mlpModelPath fullName
		with: [ :kann_t | 
			kann_t switchToPrediction.
			"Apply it."
			Libkann_data
				readFromFileNamed: (self dataPath / 'mnist-test-x.knd.gz') fullName
				with: [ :xx | 
					"Ensure dimensions match."
					self assert: kann_t dimIn equals: xx n_col.

					"Load the test observations"
					xx x_rows
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
					argMax := each
						argOpt: [ :f :opt | f > opt ]
						init: Float negativeInfinity.
					(Array new: y n_col withAll: 0)
						at: argMax put: 1;
						yourself ].
			(y xValue collect: #truncated)
				with: P
				collect: [ :target :predicted | target = predicted ] ].
	contents := indicators asBag valuesAndCounts.
	trues := contents at: true.
	falses := contents at: false.
	self assert: trues >= falses.
	self assert: trues / (trues + falses) > 0.95