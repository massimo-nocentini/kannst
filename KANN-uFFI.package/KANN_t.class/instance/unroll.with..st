accessing structure variables
unroll: len with: aBlock
	| ua |
	ua := self unroll: len.
	^ [ aBlock value: ua ]
		ensure: [ ua delete_unrolled ]