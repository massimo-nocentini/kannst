#define
isBack
	^ (self accessor_flag bitAnd: (Libkautodiff constants at: #KAD_VAR))
		~= 0