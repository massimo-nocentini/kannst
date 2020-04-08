training
sinks
	^ self
		withNodes: [ :nodes | 
			| sinks |
			sinks := Dictionary new.
			nodes
				valuesDo: [ :kad_node_t | 
					sinks at: kad_node_t getHandle ifAbsentPut: [ true ].
					kad_node_t children
						do: [ :child | sinks at: child getHandle put: false ] ].
			sinks associations
				select: #value
				thenCollect: [ :assoc | nodes at: assoc key ] ]