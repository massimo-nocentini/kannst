tests
testRNN_load
	Libkann
		loadFromFileNamed: self rnnModelPath fullName
		with: [ :kann_t | 
			| random trues N M |
			N := 1000.
			M := self maxInteger.
			random := Random new.
			trues := OrderedCollection new.
			N
				timesRepeat: [ | a b result |
					a := self firstArg: (random nextInt: M).
					b := self secondArg: (random nextInt: M).
					result := self apply: kann_t args: (Array with: a with: b).
					(self value: a value: b) = result
						ifTrue: [ trues add: (Array with: a with: b with: result) ] ].
			self halt.
			self assert: trues size / N > 0.95 ]