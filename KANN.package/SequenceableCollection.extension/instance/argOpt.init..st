*KANN
argOpt: aBlock init: init
	| opt arg |
	opt := init.
	self
		doWithIndex: [ :each :i | 
			(aBlock value: each value: opt)
				ifTrue: [ opt := each.
					arg := i ] ].
	^ arg