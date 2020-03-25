tests
test_MNISTDataset_LoadAndApply
	| predicted |
	predicted := self
		onMNISTDataset_load: self aeModelPath fullName
		collect: [ :x :p | 
			self encodingPath
				writeStreamDo: [ :aStream | 
					aStream
						nextPutAll: '#no:truth';
						tab;
						nextPutAll: (Character tab join: x cnameValue).
					x rowsStream contents
						do: [ :anAssoc | 
							aStream
								crlf;
								nextPutAll: anAssoc key;
								nextPut: Character tab;
								nextPutAll:
									(Character tab
										join: (anAssoc value collect: [ :aFloat | aFloat asString ])) ] ] ].

	"Read the data just written and load a KANN_data_t to save the ascii representation."
	Libkann_data
		readFromFileNamed: self encodingPath fullName
		with: [ :kann_data_t | 
			| ds |
			ds := kann_data_t asDataset: KANNDatasetMNIST.
			(self encodingPath fullName , '.ascii') asFileReference
				writeStreamDo: [ :aStream | aStream nextPutAll: ds ascii ] ]