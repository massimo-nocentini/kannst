as yet unclassified
rowsStream
	^ Generator
		on: [ :g | 
			self rnameValue
				with: self x_rows
				do:
					[ :rname :externalAddress | g yield: rname -> (externalAddress asArrayOf: #float size: self n_col) ] ]