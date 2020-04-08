training
nodes
	| nodes |
	"First build the array of pointers to KAD_node_t structures."
	nodes := self accessor_v
		asArrayOf: #'KAD_node_t *'
		size: self accessor_n.

	"Then promote them as first class Smalltalk object"
	^ nodes
		collect: [ :externalAddress | KAD_node_t fromHandle: externalAddress ]