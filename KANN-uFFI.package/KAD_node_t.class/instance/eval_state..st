as yet unclassified
eval_state: can_eval
	^ self
		ffiCall: #(void kad_eval_state #(KAD_node_t * self , int32 can_eval))
		library: Libkautodiff