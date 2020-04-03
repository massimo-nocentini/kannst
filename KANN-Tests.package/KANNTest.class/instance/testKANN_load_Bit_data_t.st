tests
testKANN_load_Bit_data_t
	| d max |
	d := Bit_data_t new.
	(self dataPath / 'add100-train.txt') contents lines
		do: [ :line | 
			| array |
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
								ifFalse: [ m << 1 ] ];
						accessor: #x
							update:
								[ :x | (Array new: d m * d n_in withAll: 0) replaceFrom: 1 to: x size with: x ];
						accessor: #y
							update: [ :y | (Array new: d m withAll: 0) replaceFrom: 1 to: y size with: y ] ].
			d
				accessor: #x
				update: [ :x | 
					| chunk start |
					chunk := array copyFrom: 1 to: d n_in.
					start := d n * d n_in.
					x replaceFrom: start + 1 to: start + chunk size with: chunk ].

			"Equivalent increment as in `d->y[d->n++]` because Smalltalk uses 1-based indexing."
			d accessor: #n update: [ :n | n + 1 ].
			d y at: d n put: (array at: d n_in + 1) ].

	"Computing the max"
	max := Float negativeInfinity.
	0 to: d n - 1 do: [ :i | 
		| t |
		t := i * d n_in.
		1 to: d n_in do: [ :j | max := max max: (d x at: t + j) ].
		max := max max: (d y at: i + 1) ].

	"Set a final slot"
	[ max = 0 ]
		whileFalse: [ d accessor: #ulen update: [ :ulen | ulen + 1 ].
			max := max >> 1 ].

	"Return the built structure"
	^ d