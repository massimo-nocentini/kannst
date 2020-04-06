tests
index: j data: bit_data_t mini_size: mini_size shuffle: shuf x: x y: y
	0 to: bit_data_t ulen - 1 do: [ :k | 
		0 to: mini_size - 1 do: [ :b | 
			| s array |
			s := shuf at: j + b + 1.
			array := FFIArray
				fromHandle: (x at: k + 1) getHandle
				type: #float
				size: mini_size * bit_data_t n_in.
			1 to: bit_data_t n_in do: [ :i | 
				| aFloat |
				aFloat := ((bit_data_t x at: s * bit_data_t n_in + i) >> k & 1)
					asFloat.
				array at: b * bit_data_t n_in + i put: aFloat ].
			(FFIArray
				fromHandle: (y at: k + 1) getHandle
				type: #float
				size: mini_size * 2)
				at: b * 2 + 1 put: 0 asFloat;
				at: b * 2 + 2 put: 0 asFloat;
				at: b * 2 + ((bit_data_t y at: s + 1) >> k & 1) + 1
					put: 1 asFloat ] ]