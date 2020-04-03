*KANN-uFFI
newArrayTypeOf: aTypeName size: elements with: aBlock
	| array |
	array := self externalNewType: aTypeName size: elements.
	^ [ aBlock value: array ]
		ensure: [ array free ]