accessing
children
	| children |
	children := self accessor_child
		asArrayOf: #'KAD_node_t *'
		size: self accessor_n_child.
	^ children collect: [ :h | self class fromHandle: h ]