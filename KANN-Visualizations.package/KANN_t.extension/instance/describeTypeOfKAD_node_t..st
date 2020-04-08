*KANN-Visualizations
describeTypeOfKAD_node_t: each
	^ each
		ifFeed: [ 'feed' ]
		ifVar: [ 'var' ]
		ifConst: [ 'const' ]
		ifOperator: [ each accessor_op_name ]
		otherwise: [ self error ]