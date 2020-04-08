accessing
children
	| children |
	"	children := self child asArrayOf: #'KAD_node_t *' size: self n_child.
	^ children collect: [ :h | self class fromHandle: h ]"
	"	children := self accessor_child asArrayOf: #'KAD_node_t *' size: self accessor_n_child.
	^ children collect: [ :h | self class fromHandle: h ]"
	"self halt.
	
	^ Array
		streamContents: [ :aStream | 
			self
				childrenWithIndexDo: [ :i :each | aStream nextPut: (self class fromHandle: each) ] ]"
	children := self accessor_child
		asArrayOf: #'KAD_node_t *'
		size: self accessor_n_child.
	^ children collect: [ :h | self class fromHandle: h ]