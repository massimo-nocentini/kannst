utilities
feed: x feed: y feed: w feed: z
	^ self
		ffiCall: #(KAD_node_t * kad_feed #(int 4 , int x , int y , int w , int z))