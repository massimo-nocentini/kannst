accessing structure variables
xValue
	^ self x_rows
		collect: [ :each | each asArrayOf: #float size: self n_col ]