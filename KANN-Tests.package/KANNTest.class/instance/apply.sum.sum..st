tests
apply: kann_t sum: a sum: b
	| array result |
	result := 0.
	array := Array with: a with: b.
	kann_t rnn_start.
	0 to: 63 do: [ :k | 
		(array collect: [ :each | (each >> k & 1) asFloat ])
			asExternalArrayOf: #float
			with: [ :x | 
				| y |
				y := (kann_t apply1: x getHandle)
					asArrayOf: #float
					size: kann_t dimOut.
				y second > y first
					ifTrue: [ result := result bitOr: 1 << k ] ] ].
	kann_t rnn_end.
	^ result