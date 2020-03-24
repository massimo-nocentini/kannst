tests
test_MNISTDataset_LoadAndApply
	| predicted |
	predicted := self
		onMNISTDataset_load: self aeModelPath fullName
		collect: [ :x :p | 
			self dataPath / 'mnist-test-x-ae.knd'
				writeStreamDo: [ :aStream | 
					aStream nextPutAll: (Character tab join: x cnameValue).
					x rowsStream contents
						do: [ :anAssoc | 
							aStream
								crlf;
								nextPutAll: anAssoc key;
								nextPut: Character tab;
								nextPutAll:
									(Character tab
										join: (anAssoc value collect: [ :aFloat | aFloat asString ])) ] ] ]