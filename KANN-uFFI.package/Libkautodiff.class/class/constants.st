utilities
constants
	^ Dictionary new
		at: #KAD_MAX_DIM put: 4;
		"max dimension"
			at: #KAD_MAX_OP put: 64;
		"max number of operators"
			at: #KAD_VAR put: 1;
		at: #KAD_CONST put: 2;
		at: #KAD_POOL put: 4;
		at: #KAD_SHARE_RNG put: 10;
		"with this flag on, different time step shares the same RNG status after unroll"
			yourself