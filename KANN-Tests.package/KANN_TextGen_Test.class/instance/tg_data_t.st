tests
tg_data_t
	| corpus |
	corpus := self trainingSourcePath
		readStreamEncoded: ZnCharacterEncoder iso88591
		do: [ :aStream | aStream contents ].
	^ Tg_data_t fromCorpusString: corpus