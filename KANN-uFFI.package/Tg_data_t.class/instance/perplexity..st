as yet unclassified
perplexity: kann_t
	^ kann_t
		rnn_run: [ | tiny |
			tiny := 1e-6.
			FFIArray
				externalNewTypeOf: #float
				size: 256
				with: [ :x :type | 
					| loss |
					loss := 0 asFloat.
					1 to: self len - 1 do: [ :i | 
						| y yIndex p |
						x atAllPut: 0 asFloat.
						x at: (self data at: i) put: 1 asFloat.
						y := kann_t apply1: x getHandle.
						yIndex := self data at: i + 1.
						p := type handle: y getHandle + (yIndex * type typeSize) at: 1.
						loss := loss + (p max: tiny) log ].
					(loss / (1 - self len)) exp ] ]