as yet unclassified
generate: kann_t seed: seed length: len
	| i2c c |
	"Invert the index to character relation."
	i2c := Array new: self c2i size withAll: 0.
	c2i
		withIndexDo: [ :code :i | 
			code >= 0
				ifTrue: [ i2c at: code + 1 put: i ] ].
	kann_t nodes
		select: [ :kad_node_t | kad_node_t predecessor isNotNil ]
		thenDo: [ :kad_node_t | 
			| x |
			x := kad_node_t values.
			x allSatisfy: [ :each | each = 0 ].
			1 to: x size do: [ :i | x at: i put: (Libkautodiff drand * 2 - 1) asFloat ] ].
	c := seed
		ifNil: [ c2i at: Character space asInteger ]
		ifNotNil: [ self shouldBeImplemented ].
	^ String
		streamContents: [ :aStream | 
			| yHandle y s r |
			FFIArray
				externalNewTypeOf: #float
				size: n_char
				with: [ :x | 
					len
						timesRepeat: [ | continue |
							x
								atAllPut: 0 asFloat;
								at: c + 1 put: 1 asFloat.
							yHandle := kann_t apply1: x getHandle.
							y := yHandle asArrayOf: #float size: kann_t dimOut.

							"Generate"
							c := 1.
							s := 0 asFloat.
							r := Libkautodiff drand.
							continue := true.
							[ continue and: [ c <= y size ] ]
								whileTrue: [ | ss |
									ss := s + (y at: c).
									ss < r
										ifTrue: [ s := ss.
											c := c + 1 ]
										ifFalse: [ c := c - 1.
											continue := false ] ].
							aStream nextPut: (i2c at: c + 1) asCharacter ] ] ]