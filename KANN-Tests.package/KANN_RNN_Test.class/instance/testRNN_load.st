tests
testRNN_load
	self halt.
	Libkann
		loadFromFileNamed: self rnnModelPath fullName
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
					result := self apply: kann_t args: (Array with: a with: b).
					(self value: a value: b) = result
						ifTrue: [ trues add: (Array with: a with: b with: result) ] ].
			self assert: trues size / N > 0.95 ]