as yet unclassified
loadFromFileNamed: fn with: aBlock
	| kann |
	kann := self loadFromFileNamed: fn.
	^ [ aBlock value: kann ]
		ensure: [ kann delete ]