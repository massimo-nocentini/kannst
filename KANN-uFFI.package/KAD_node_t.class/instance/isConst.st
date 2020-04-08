#define
isConst
	^ self isExt
		and: [ | bit |
			bit := self accessor_flag
				bitAnd: (Libkautodiff constants at: #KAD_CONST).
			bit ~= 0 ]