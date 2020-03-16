creating
withKANN: aBlock
	| kann |
	"Build the KANN."
	kann := self kann.
	^ [ aBlock value: kann ]
		ensure: [ kann delete ]