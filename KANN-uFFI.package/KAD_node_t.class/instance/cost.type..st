layers composition
cost: n type: type
	^ self
		ffiCall:
			#(KAD_node_t * kann_layer_cost #(KAD_node_t * self , int n , int type))
		library: Libkann