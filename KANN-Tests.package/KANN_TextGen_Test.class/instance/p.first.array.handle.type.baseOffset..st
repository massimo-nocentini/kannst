as yet unclassified
p: p first: pFirst array: anArray handle: handle type: type baseOffset: dataBaseOffset
	"
			for (b = 0; b < mbs; ++b) {
				int offset = (int)((tg->len - ulen * cs - 1) * kad_drand(0)) + 1;
				p[b] = tg->data + offset;				
			}"

	^ (1 to: p size)
		collect: [ :b | 
			| offset pArray |
			offset := (Libkautodiff drand * dataBaseOffset) truncated.
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