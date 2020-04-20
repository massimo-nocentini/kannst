tests
testKad_node_t_accessor_pre
	| kad_node_t tg |
	tg := self tg_data_t_Accelerando.
	kad_node_t := self
		network: self gruBlock
		input: tg n_char
		neurons: {160 . 160 . 160}
		dropout: 0 asFloat.
	kad_node_t
		withKANN: [ :kann_t | 
			self assert: kann_t dimIn equals: tg n_char.
			self
				deny:
					((kann_t nodes
						collect: [ :t | t pre getHandle = t accessor_pre getHandle ])
						allSatisfy: [ :shouldBeTrue | shouldBeTrue ]) ]