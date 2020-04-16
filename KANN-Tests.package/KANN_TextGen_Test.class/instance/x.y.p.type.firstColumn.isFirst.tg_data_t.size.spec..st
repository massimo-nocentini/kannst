as yet unclassified
x: x y: y p: p type: type firstColumn: pFirst isFirst: isFirst tg_data_t: tg size: size spec: spec
	1 to: spec minibatch_size do: [ :b | 
		| pHandle pArray baseIndex |
		baseIndex := (b - 1) * tg n_char.
		"pHandle := p at: b."
		"pArray := FFIArray fromHandle: pHandle type: #int size: spec max_unroll."
		pArray := FFIArray
			fromHandle: (p at: b)
			type: #int
			size: spec max_unroll.
		"pArray := pRows at: b."
		1 to: spec max_unroll do: [ :u | 
			| xArray |
			xArray := FFIArray fromHandle: (x at: u) type: #float size: size.
			xArray
				at: baseIndex + (pArray at: u - 1 ifAbsent: [ pFirst at: b ]) + 1
				put: 1 asFloat.
			(isFirst not or: [ u - 1 >= spec burnin_length ])
				ifTrue: [ | yArray |
					yArray := FFIArray fromHandle: (y at: u) type: #float size: size.
					yArray at: baseIndex + (pArray at: u) + 1 put: 1 asFloat ] ].
		p at: b put: pArray getHandle + (spec max_unroll * type typeSize).
		pFirst
			at: b
			put:
				(type
					handle: pArray getHandle + ((spec max_unroll - 1) * type typeSize)
					at: 1)
		"self halt.
									FFIArray
										fromHandle: (p at: b)
										type: #int
										size: spec max_unroll" ]