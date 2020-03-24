as yet unclassified
epoch: i costs: costs errors: errors stats: stats
	| msg |
	msg := String
		streamContents: [ :s | 
			s
				nextPutAll:
					('epoch: {1}; training cost: {2}'
						format:
							{i.
							costs key}).
			errors key
				ifNotNil: [ :ce | s nextPutAll: (' (class error: {1})' format: {ce}) ].
			costs value
				ifNotNil: [ :vc | s nextPutAll: ('; validation cost: {1}' format: {vc}) ].
			errors value
				ifNotNil: [ :vce | ' (class error: {1}' format: {vce} ] ].
	job
		current: i;
		title: title , msg