test
testXValue
	| matrix |
	matrix := Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-test-x-small.knd') fullName
		with: [ :kann_data_t | 
			self halt.
			kann_data_t xValue ].
	self halt