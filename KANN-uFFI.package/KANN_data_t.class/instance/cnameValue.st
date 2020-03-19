accessing structure variables
cnameValue
	^ (self cname asArrayOf: #'char *' size: self n_col)
		collect: #readString