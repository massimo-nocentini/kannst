utilities
mlpStatsBlockForJob: bar title: title stream: aStream
	^ [ :i :train_cost :n_train_base :class_error :n_val :val_cost :n_val_base :validation_class_error | 
	| msg |
	aStream
		nextPut:
			(Dictionary new
				at: #i put: i;
				at: #train_cost put: train_cost;
				at: #n_train_base put: n_train_base;
				at: #class_error put: class_error;
				at: #n_val put: n_val;
				at: #val_cost put: val_cost;
				at: #n_val_base put: n_val_base;
				at: #validation_class_error put: validation_class_error;
				yourself).
	msg := String
		streamContents: [ :s | 
			s
				nextPutAll:
					('epoch: {1}; training cost: {2}'
						format:
							{i.
							train_cost}).
			n_train_base = 0
				ifFalse: [ s nextPutAll: (' (class error: {1})' format: {class_error}) ].
			n_val > 0
				ifTrue: [ s nextPutAll: ('; validation cost: {1}' format: {val_cost}).
					n_val_base = 0
						ifFalse: [ ' (class error: {1}' format: {validation_class_error} ] ] ].
	bar
		current: i;
		title: title , msg ]