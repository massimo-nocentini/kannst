as yet unclassified
ifFeed: fBlock ifVar: vBlock ifConst: cBlock ifOperator: oBlock otherwise: ooBlock
	^ self accessor_n_child > 0
		ifTrue: [ oBlock cull: self ]
		ifFalse: [ self isFeed
				ifTrue: [ fBlock cull: self ]
				ifFalse: [ self isVar
						ifTrue: [ vBlock cull: self ]
						ifFalse: [ self isConst
								ifTrue: [ cBlock cull: self ]
								ifFalse: [ ooBlock cull: self ] ] ] ]