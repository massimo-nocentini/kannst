tests
testTg_data_t_dataAsExternalArray
	self tg_data_t data
		asExternalArrayOf: #int
		with: [ :aFFIArray :type :data | 
			| handle |
			handle := aFFIArray getHandle.
			self deny: handle isNull.


			"Element-wise check"
			self should: [ type handle: handle at: 0 ] raise: Error.
			aFFIArray
				withIndexDo: [ :each :i | 
					self
						assert: (type handle: handle + ((i - 1) * type typeSize) at: 1)
						equals: each ].

			"Tail-wise check"
			0 to: 10 do: [ :i | 
				| tail |
				tail := FFIArray
					fromHandle: handle + (i * type typeSize)
					type: #int
					size: aFFIArray size - i.
				self assert: (tail as: Array) equals: (data allButFirst: i) ].

			"The following attempt to read from an area not allocated still returns
			 and undefined value instead of raising some Error object."
			self
				shouldnt: [ type handle: handle at: aFFIArray size + 1 ]
				raise: Error ]