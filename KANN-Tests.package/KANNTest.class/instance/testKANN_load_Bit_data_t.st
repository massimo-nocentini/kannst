tests
testKANN_load_Bit_data_t
	| d |
	d := Bit_data_t new.
	(self dataPath / 'add100-train.txt') contents lines
		do: [ :line | 
			| array type |
			array := (line splitOn: Character tab)
				collect: [ :s | Number readFrom: s trim ]
				as: Array.
			d n_in: array size - 1.
			d n = d m
				ifTrue: [ d
						accessor: #m
						update: [ :m | 
							m = 0
								ifTrue: [ 256 ]
								ifFalse: [ m << 1 ] ].
					d realloc: #x size: d m * d n_in * 8.
					d realloc: #y size: d m * 8 ].

			"resolve the type for uint64"
			type := FFIExternalType resolveType: #'uint64 *'.

			"Build the corresponding external array"
			array
				asExternalArrayOf: #uint64
				with: [ :ea | 
					"and use it to access the given handler."
					LibC uniqueInstance
						memCopy: ea getHandle
						to: (type handle: d x getHandle at: d n * d n_in + 1)
						size: d n_in * 8 ].

			"Equivalent increment as in `d->y[d->n++]` because Smalltalk uses 1-based indexing."
			d accessor: #n update: [ :n | n + 1 ].

			"Set the value for `y` too."
			type
				handle: d y getHandle
				at: d n
				put: ((array at: d n_in + 1) asExternalAddressOfType: #uint64) ].
	self halt