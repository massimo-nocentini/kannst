training
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath
	| n_char ulen mbs |
	n_char := kann_t dimIn.
	ulen := spec max_unroll.
	mbs := spec minibatch_size.
	^ FFIArray
		externalNewTypeOf: #'float *'
		size: ulen
		with: [ :x | 
			FFIArray
				externalNewTypeOf: #'float *'
				size: ulen
				with: [ :y | 
					| size |
					size := n_char * mbs.

					"Prepare inner arrays for matrices x and y."
					1 to: ulen do: [ :u | 
						| xArray yArray |
						"For array of arrays x"
						xArray := (FFIArray externalNewType: #float size: size)
							atAllPut: 0 asFloat;
							yourself.
						x at: u put: xArray getHandle.

						"And for array of arrays y"
						yArray := (FFIArray externalNewType: #float size: size)
							atAllPut: 0 asFloat;
							yourself.
						y at: u put: yArray getHandle ].

					"Allocate new vectors"
					[ self
						train: kann_t
						tg_data_t: tg
						spec: spec
						saveToFilePath: aPath
						x: x
						y: y ]
						ensure: [ "Free arrays holded in both x and y"
							x do: [ :aFFIArray | aFFIArray free ].
							y do: [ :aFFIArray | aFFIArray free ] ] ] ]