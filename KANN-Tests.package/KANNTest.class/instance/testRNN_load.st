tests
testRNN_load
	Libkann
		loadFromFileNamed: (self modelsPath / 'RNN.kan') fullName
		with: [ :kann_t | 
			| random trues N |
			N := 1000.
			random := Random new.
			trues := OrderedCollection new.
			N
				timesRepeat: [ | a b result M |
					M := 1000.
					a := random nextInt: M.
					b := random nextInt: M.
					result := self apply: kann_t sum: a sum: b.
					a + b = result
						ifTrue: [ trues add: (Array with: a with: b with: result) ] ].
			self assert: trues size / N > 0.95 ]