tests
train: kann_t data: bit_data_t mini_size: mini_size withArraysDo: aBlock
	FFIArray
		newArrayTypeOf: #float
		size: kann_t size_var
		with: [ :r | 
			r atAllPut: 0 asFloat.	"to simulate `calloc` behavior"
			FFIArray
				newArrayTypeOf: #'void *'
				size: bit_data_t ulen
				with: [ :x | 
					FFIArray
						newArrayTypeOf: #'void *'
						size: bit_data_t ulen
						with: [ :y | 
							1 to: bit_data_t ulen do: [ :j | 
								self row: j size: mini_size * bit_data_t n_in array: x.
								self row: j size: mini_size * 2 array: y ].
							[ FFIArray
								newArrayTypeOf: #int
								size: bit_data_t n
								with: [ :shuf | 
									shuf atAllPut: 0.
									Libkann shuffle: bit_data_t n array: shuf getHandle.

									"Evaluate the given block."
									aBlock
										value: r
										value: x
										value: y
										value: shuf ] ]
								ensure: [ "release inner external arrays"
									x do: #free.
									y do: #free ] ] ] ]