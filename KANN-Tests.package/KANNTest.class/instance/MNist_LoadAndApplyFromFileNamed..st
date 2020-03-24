tests
MNist_LoadAndApplyFromFileNamed: aFilename
	| predictions indicators contents trues falses |
	predictions := Libkann
		loadFromFileNamed: aFilename
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
							| handle probs |
							"Apply the network."
							handle := kann_t apply1: aFloatAddress.

							"and return the array with probabilities"
							probs := handle asArrayOf: #float size: kann_t dimOut.

							"Check that it is actually a distribution"
							"self assert: (probs sum closeTo: 1 precision: 1e-1)."

							"Finally return the predicted array"
							probs ] ] ].
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
	self halt.
	trues := contents at: true.
	falses := contents at: false.
	self assert: trues >= falses.
	self assert: trues / (trues + falses) > 0.95