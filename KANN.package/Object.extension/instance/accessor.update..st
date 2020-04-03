*KANN
accessor: aSymbol update: aBlock
	| value newValue |
	value := self perform: aSymbol.
	newValue := aBlock cull: value.
	^ self perform: aSymbol asMutator with: newValue