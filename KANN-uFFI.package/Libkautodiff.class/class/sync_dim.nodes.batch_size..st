as yet unclassified
sync_dim: n nodes: v batch_size: b
	^ self ffiCall: #(int kad_sync_dim #(int n , void * v , int b))