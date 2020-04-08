training
nodes_do: aFFICallback
	^ self
		ffiCall: #(void kann_nodes_do #(KANN_t * self , FFICallback aFFICallback))
		library: Libkann