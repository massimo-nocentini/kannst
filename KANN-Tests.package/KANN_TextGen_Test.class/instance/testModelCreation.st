tests
testModelCreation
	| kad_node_t |
	Libkann srand: 11.
	kad_node_t := self
		network: self gruBlock
		input: self tg_data_t n_char
		neurons: {160 . 160 . 160}
		dropout: 0 asFloat.
	self assert: kad_node_t isNotNil