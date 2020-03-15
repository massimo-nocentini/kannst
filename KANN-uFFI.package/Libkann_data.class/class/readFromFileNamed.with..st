creating
readFromFileNamed: aString with: aBlock
	| kann_data_t |
	kann_data_t := self readFromFileNamed: aString.
	^ [ aBlock value: kann_data_t ]
		ensure: [ self freeKANN_data_t: kann_data_t ]