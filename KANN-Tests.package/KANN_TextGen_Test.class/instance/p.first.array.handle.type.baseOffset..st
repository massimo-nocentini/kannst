training
p: p first: pFirst array: anArray handle: handle type: type baseOffset: dataBaseOffset
	^ (1 to: p size)
		collect: [ :b | 
			| offset pArray |
			offset := (Libkautodiff drand * dataBaseOffset) floor.
			pFirst
				at: b
				put: (type handle: handle + (type typeSize * offset) at: 1).
			offset := offset + 1.
			pArray := FFIArray
				fromHandle: handle + (type typeSize * offset)
				type: #int
				size: anArray size - offset.
			p at: b put: pArray getHandle.
			pArray ]