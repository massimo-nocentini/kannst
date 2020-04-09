tests
testKANN_t_structureFieldAccessors
	Libkann
		loadFromFileNamed: (self modelsPath / 'mlp.kan') fullName
		with: [ :kann_t | 
			| uFFInodes |
			"First of all, the number of nodes in the computational graph should be preserved."
			self assert: kann_t n equals: kann_t accessor_n.

			"By uFFI, the construction is similar to the one coded in `kann_t nodes`
			except that here we use `kann_t v` and `kann_t n` instead of the corresponding
			`kann_t accessor_v` and `kann_t accessor_n`."
			uFFInodes := (kann_t v asArrayOf: #'KAD_node_t *' size: kann_t n)
				collect: [ :externalAddress | KAD_node_t fromHandle: externalAddress ].

			"Even if the number of children equals in those two collections"
			self
				assert: (kann_t nodes collect: [ :node | node accessor_n_child ])
				equals: (uFFInodes collect: [ :node | node n_child ]).

			"The double pointers kad_node_t->child are different."
			self
				deny: (kann_t nodes collect: [ :node | node accessor_child getHandle ])
				equals: (uFFInodes collect: [ :node | node child getHandle ]).

			"Hard debug"
			self halt ]