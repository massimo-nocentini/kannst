tests
testLoad
	| tg corpus |
	Libkann srand: 11.
	corpus := self trainingSourcePath
		readStreamEncoded: ZnCharacterEncoder iso88591
		do: [ :aStream | aStream contents ].
	tg := Tg_data_t fromCorpusString: corpus.
	self assert: tg n_para equals: 2835.
	self assert: tg n_char equals: 91.
	self assert: tg len equals: 854339