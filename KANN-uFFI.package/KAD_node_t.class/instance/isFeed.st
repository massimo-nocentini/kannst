#define
isFeed
	^ self isExt
		and: [ self isBack not
				and: [ | bit |
					bit := self accessor_flag
						bitAnd: (Libkautodiff constants at: #KAD_CONST).
					bit = 0 ] ]