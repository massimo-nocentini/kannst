as yet unclassified
constants
	^ Dictionary new
		at: #KANN_VERSION put: 'r536';
		at: #KANN_F_IN put: 1;
		"input"
			at: #KANN_F_OUT put: 2;
		"output"
			at: #KANN_F_TRUTH put: 4;
		"truth output"
			at: #KANN_F_COST put: 8;
		"final cost"
			at: #KANN_C_CEB put: 1;
		"binary cross-entropy cost, used with sigmoid"
			at: #KANN_C_CEM put: 2;
		"multi-class cross-entropy cost, used with softmax"
			at: #KANN_C_CEB_NEG put: 3;
		"binary cross-enytopy-like cost, used with tanh"
			at: #KANN_C_MSE put: 4;
		"mean square error"
			at: #KANN_RNN_VAR_H0 put: 1;
		"take the initial hidden values as variables"
			at: #KANN_RNN_NORM put: 2;
		"apply layer normalization"
			yourself