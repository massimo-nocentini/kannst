training
nodesWithIndexDo: twoArgsBlock
	| callback |
	callback := FFICallback
		signature: #(void #(int i , KAD_node_t * a))
		block: twoArgsBlock.
	^ self nodes_do: callback