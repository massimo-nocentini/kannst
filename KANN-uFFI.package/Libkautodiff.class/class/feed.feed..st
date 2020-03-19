utilities
feed: x feed: y
	^ self ffiCall: #(KAD_node_t * kad_feed #(int 2 , int x , int y))