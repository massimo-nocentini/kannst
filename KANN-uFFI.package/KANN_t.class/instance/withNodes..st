as yet unclassified
withNodes: aBlock
	| dict |
	dict := Dictionary new.
	self nodes
		do: [ :kad_node_t | dict at: kad_node_t getHandle put: kad_node_t ].
	^ aBlock value: dict