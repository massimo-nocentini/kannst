tests
testLoad
	| tg corpus |
	Libkann srand: 11.
	corpus := self trainingSourcePath
		readStreamEncoded: ZnCharacterEncoder iso88591
		do: [ :aStream | aStream contents ].
	tg := Tg_data_t fromCorpusString: corpus.
	self halt