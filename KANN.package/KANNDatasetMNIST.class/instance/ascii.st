modes
ascii
	^ String
		streamContents: [ :aStream | 
			kann_data_t rowsStream contents
				do: [ :anAssoc | 
					aStream
						nextPutAll: '===> ' , anAssoc key , ' <===';
						crlf;
						nextPutAll: (self ascii: anAssoc value);
						crlf ] ]