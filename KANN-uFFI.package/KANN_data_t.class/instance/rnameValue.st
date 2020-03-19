accessing structure variables
rnameValue
	^ (self rname asArrayOf: #'char *' size: self n_row)
		collect: #readString