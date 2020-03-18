accessing structure variables
rnameValue
	^ (self rname getHandle
		readArrayOf: #'char *'
		until: [ :a :i | i > self n_row ]) collect: #readString