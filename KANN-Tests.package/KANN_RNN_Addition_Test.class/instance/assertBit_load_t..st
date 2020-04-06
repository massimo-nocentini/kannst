tests
assertBit_load_t: d
	self
		assert: 2 equals: d n_in;
		assert: 15 equals: d ulen;
		assert: 30000 equals: d n;
		assert: 32768 equals: d m