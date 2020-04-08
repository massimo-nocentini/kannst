accessing
children_do: aFFICallback
	^ self
		ffiCall:
			#(void kad_children_do #(const KAD_node_t * self , FFICallback aFFICallback))
		library: Libkautodiff