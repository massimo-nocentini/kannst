tests
train: kann_t tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y
	^ FFIArray
		externalNewTypeOf: #float
		size: kann_t size_var
		with: [ :r | 
			r atAllPut: 0 asFloat.
			FFIArray
				externalNewTypeOf: #'int *'
				size: spec minibatch_size
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
						p: p ] ]