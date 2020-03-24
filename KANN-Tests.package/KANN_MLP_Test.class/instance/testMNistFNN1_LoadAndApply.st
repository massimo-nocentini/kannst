tests
testMNistFNN1_LoadAndApply
	| indicators contents trues falses |
	indicators := self
		onMNISTDataset_load: self mlpModelPath fullName
		collect: [ :x :y :predictions | 
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