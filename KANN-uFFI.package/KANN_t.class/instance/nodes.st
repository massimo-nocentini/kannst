training
nodes
	| nodes wrong result type |
	nodes := self v asArrayOf: #'KAD_node_t *' size: self n.
	^ nodes
		collect: [ :externalAddress | "

	type := FFIExternalType resolveType: #KAD_node_t.
	result := Array
		streamContents: [ :aStream | 
			self
				nodesWithIndexDo: [ :i :each | aStream nextPut: (type basicHandle: each at: 1) ] ].

	
	self
		assert: (wrong collect: #getHandle) = (result collect: #getHandle).

	^ result" KAD_node_t fromHandle: externalAddress ]