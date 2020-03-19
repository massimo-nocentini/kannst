unary operands
add: y
	"f(x,y) = x + y (generalized element-wise addition; f[i*n+j]=x[i*n+j]+y[j], n=kad_len(y), 0<j<n, 0<i<kad_len(x)/n)"

	^ self
		ffiCall: #(KAD_node_t * kad_add #(KAD_node_t * self , KAD_node_t * y))
		library: Libkautodiff