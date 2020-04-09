as yet unclassified
role
	^ self
		ifFeed: [ 'feed' ]
		ifVar: [ 'var' ]
		ifConst: [ 'const' ]
		ifOperator: [ self accessor_op_name ]
		otherwise: [ self error ]