accessing structure variables
x_rows
	^ self x getHandle
		readArrayOf: #'float *'
		until: [ :a :j | j > self n_row ]