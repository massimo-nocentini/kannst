as yet unclassified
statsHandler: anObject
	^ [ :i :train_cost :n_train_base :class_error :n_val :val_cost :n_val_base :validation_class_error | 
	| stats ce vce vc |
	stats := Dictionary new
		at: #i put: i;
		at: #train_cost put: train_cost;
		at: #n_train_base put: n_train_base;
		at: #class_error put: class_error;
		at: #n_val put: n_val;
		at: #val_cost put: val_cost;
		at: #n_val_base put: n_val_base;
		at: #validation_class_error put: validation_class_error;
		yourself.
	ce := n_train_base = 0
		ifFalse: [ class_error ].
	n_val > 0
		ifTrue: [ vc := val_cost.
			n_val_base = 0
				ifFalse: [ vce := validation_class_error ] ].
	anObject
		epoch: i
		costs: train_cost -> vc
		errors: ce -> vce
		stats: stats ]