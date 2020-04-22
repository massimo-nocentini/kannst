as yet unclassified
train: ua tg_data_t: tg spec: spec saveToFilePath: aPath x: x y: y r: r p: p data: trainingData
	| cost tot ctot n_cerr |
	cost := 0 asFloat.
	tot := 0.
	ctot := 0.
	n_cerr := 0.

	"Start iterating by batches."
	1 to: trainingData batch_len by: trainingData step do: [ :i | 
		| pRows |
		"Compute the rows of the matrix p that have to be tails of `tg data`"
		pRows := self
			p: p
			first: trainingData pFirst
			array: trainingData dataFFIArray
			handle: trainingData handle
			type: trainingData type
			baseOffset: trainingData dataBaseOffset.

		"Update x values just for nodes that have a valid predecessor."
		ua nodes
			select: [ :kad_node_t | kad_node_t predecessor isNotNil ]
			thenDo: [ :kad_node_t | kad_node_t values atAllPut: 0 asFloat ].

		"Iterate again."
		1 to: spec cs do: [ :c | 
			"Cleanup both matrices x and y."
			self
				x: x
				atAllPut: 0 asFloat
				y: y
				asAllPut: 0 asFloat
				size: trainingData size.

			"Complex step."
			self
				x: x
				y: y
				p: p
				type: trainingData type
				firstColumn: trainingData pFirst
				isFirst: c = 1
				tg_data_t: tg
				size: trainingData size
				spec: spec.

			"Update costs and tots"
			cost := (ua cost: 0 grad: true asBit) * spec max_unroll
				* spec minibatch_size + cost.
			tot := (c > 1
				ifTrue: [ spec max_unroll ]
				ifFalse: [ trainingData diff ]) * spec minibatch_size + tot.
			ctot := ctot
				+
					(spec minibatch_size
						asExternalAddressOfType: #int
						with: [ :intHandle | n_cerr := n_cerr + (ua class_error: intHandle) ]).

			"Grad clips"
			spec grad_clip > 0
				ifTrue: [ Libkann grad_clip: spec grad_clip n: r size g: ua g ].

			"Do one-step training"
			Libkann
				RMSprop: r size
				lr: spec lr
				vlr: ExternalAddress null
				decay: 0.9
				gradient: ua g
				variables: ua x
				memory: r getHandle ] ].

	"Finally return stats."
	^ Array
		with: (cost / tot) asFloat
		with: (n_cerr / ctot * 100) asFloat