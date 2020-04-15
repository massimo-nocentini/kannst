tests
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath
	| n_char ulen mbs |
	n_char := tg n_char.
	ulen := spec max_unroll.
	mbs := spec minibatch_size.
	FFIArray
		externalNewTypeOf: #'float *'
		size: ulen
		with: [ :x | 
			FFIArray
				externalNewTypeOf: #'float *'
				size: ulen
				with: [ :y | 
					| size |
					size := n_char * mbs.
					1 to: ulen do: [ :u | 
						| xArray yArray |
						"For array of arrays x"
						xArray := (FFIArray externalNewType: #float size: size)
							atAllPut: 0 asFloat;
							yourself.
						x at: u put: xArray getHandle.

						"And for y"
						yArray := (FFIArray externalNewType: #float size: size)
							atAllPut: 0 asFloat;
							yourself.
						y at: u put: yArray getHandle ].

					"Allocate new vectors"
					[ FFIArray
						externalNewTypeOf: #float
						size: kann_t size_var
						with: [ :r | 
							r atAllPut: 0 asFloat.
							FFIArray
								externalNewTypeOf: #'uint8 *'
								size: mbs
								with: [ :p | 
									p atAllPut: ExternalAddress null.
									self
										train: kann_t
										tg_data_t: tg
										spec: spec
										saveToFilePath: aPath
										x: x
										y: y
										r: r
										p: p ] ] ]
						ensure: [ x do: [ :aFFIArray | aFFIArray free ].
							y do: [ :aFFIArray | aFFIArray free ] ] ] ]