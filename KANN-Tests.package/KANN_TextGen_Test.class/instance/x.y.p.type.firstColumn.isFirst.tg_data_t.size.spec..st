as yet unclassified
x: x y: y p: p type: type firstColumn: pFirst isFirst: isFirst tg_data_t: tg size: size spec: spec
	1 to: spec minibatch_size do: [ :b | 
		| pArray baseIndex |
		baseIndex := (b - 1) * tg n_char + 1.
		pArray := FFIArray
			fromHandle: (p at: b)
			type: #int
			size: spec max_unroll.
		1 to: spec max_unroll do: [ :u | 
			| xArray |
			xArray := FFIArray fromHandle: (x at: u) type: #float size: size.
			xArray
				at: baseIndex + (pArray at: u - 1 ifAbsent: [ pFirst at: b ])
				put: 1 asFloat.
			(isFirst not or: [ u - 1 >= spec burnin_length ])
				ifTrue: [ | yArray |
					yArray := FFIArray fromHandle: (y at: u) type: #float size: size.
					yArray at: baseIndex + (pArray at: u) put: 1 asFloat ] ].
		pFirst at: b put: pArray last.
		p at: b put: (p at: b) + (pArray size * type typeSize)
		"
				(type
					handle: (p at: b) + ((spec max_unroll - 1) * type typeSize)
					at: 1)"
		"self halt.
									FFIArray
										fromHandle: (p at: b)
										type: #int
										size: spec max_unroll" ]