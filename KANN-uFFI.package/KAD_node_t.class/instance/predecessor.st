accessing
predecessor
	| aHandle |
	aHandle := self accessor_pre getHandle.
	^ aHandle isNull
		ifTrue: [ nil ]
		ifFalse: [ self class fromHandle: aHandle ]