tests
testMNistFNN1
	| kann_t |
	kann_t := (((Libkann inputLayer: 784) dense: 64) relu
		cost: 10
		type: 2) kann