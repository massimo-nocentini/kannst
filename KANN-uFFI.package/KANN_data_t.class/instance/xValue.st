accessing structure variables
xValue
	^ (self x asArrayOf: #'float *' size: self n_row)
		collect: [ :each | each asArrayOf: #float size: self n_col ]