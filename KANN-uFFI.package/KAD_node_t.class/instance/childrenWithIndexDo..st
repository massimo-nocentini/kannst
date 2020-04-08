accessing
childrenWithIndexDo: twoArgsBlock
	| callback |
	callback := FFICallback
		signature: #(void #(int i , KAD_node_t * a))
		block: twoArgsBlock.
	^ self children_do: callback