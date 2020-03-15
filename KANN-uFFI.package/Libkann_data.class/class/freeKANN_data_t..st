creating
freeKANN_data_t: d
	^ self ffiCall: #(void kann_data_free #(KANN_data_t * d))