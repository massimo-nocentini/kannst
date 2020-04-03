as yet unclassified
realloc: aSelector size: aSize
	self
		perform: aSelector asMutator
		with: (LibC uniqueInstance realloc: (self perform: aSelector) size: aSize)