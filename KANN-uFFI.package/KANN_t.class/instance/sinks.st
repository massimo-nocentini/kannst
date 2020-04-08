training
sinks
	^ self nodes select: [ :kad_node_t | kad_node_t n_child > 0 ]