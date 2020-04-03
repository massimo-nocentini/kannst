as yet unclassified
size_var: n nodes: v
	^ self ffiCall: #(int kad_size_var #(int n , void * v))