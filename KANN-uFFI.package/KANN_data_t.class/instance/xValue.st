accessing structure variables
xValue
	^ (self x getHandle
		readArrayOf: #'float *'
		until: [ :a :i | i > self n_row ])
		collect: [ :each | each readArrayOf: #float until: [ :f :i | i > self n_col ] ]