Remember to update the message ExternalAddress>>readArrayOf:until: with the following

```
readArrayOf: aType until: aBlock
	"Reads an array of aType until aBlock returns true.
	 this is an util to extract arrays from answers style char ** or int*, etc. 
	 Example: 
	
		someAddress readArrayOf: #uint32 until: [ :each | each isZero ].
		someAddress readArrayOf: #'void *' until: [ :each | each isNull ].
	"

	| externalType |
	"resolve type if needed"
	externalType := aType isString
		ifTrue: [ FFIExternalType resolveType: aType ]
		ifFalse: [ aType ].

	"then build the array"
	^ Array
		streamContents: [ :array | 
			| address last count |
			address := self.
			count := 0.
			[ address isNull
				or: [ last := externalType handle: address at: 1.
					count := count + 1.
					aBlock cull: last cull: count ] ]
				whileFalse: [ array nextPut: last.
					address := address + externalType typeSize ] ]
```