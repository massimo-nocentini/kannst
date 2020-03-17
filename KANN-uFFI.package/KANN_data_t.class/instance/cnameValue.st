accessing structure variables
cnameValue
	^ (self cname getHandle
		readArrayOf: #'char *'
		until: [ :a :i | i > self n_col ]) collect: #readString