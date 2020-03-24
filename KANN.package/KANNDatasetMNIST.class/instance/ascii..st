as yet unclassified
ascii: anArray
	^ String
		streamContents: [ :aStream | 
			| symbols |
			symbols := ' .:-=+*#%@'.
			anArray
				groupsOf: kann_data_t n_col sqrt
				atATimeDo: [ :each | 
					aStream
						nextPutAll:
							(each
								collect: [ :x | symbols at: ((x * 10) truncated + 1 min: 10) ]
								as: String);
						crlf ] ]