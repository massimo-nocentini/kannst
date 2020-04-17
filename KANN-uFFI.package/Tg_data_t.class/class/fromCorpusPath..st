instance creation
fromCorpusPath: aFileReference
	| corpus |
	corpus := aFileReference
		readStreamEncoded: ZnCharacterEncoder iso88591
		do: [ :aStream | aStream contents ].
	^ self fromCorpusString: corpus