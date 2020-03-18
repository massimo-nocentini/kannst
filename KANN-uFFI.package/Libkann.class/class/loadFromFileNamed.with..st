as yet unclassified
loadFromFileNamed: fn with: aBlock
	| kann |
	kann := self
		ffiCall: #(KANN_t * kann_load #(const char * fn))
		library: self.
	^ [ aBlock value: kann ]
		ensure: [ kann delete ]