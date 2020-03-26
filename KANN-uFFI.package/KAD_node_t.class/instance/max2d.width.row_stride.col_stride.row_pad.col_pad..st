as yet unclassified
max2d: kernel_h width: kernel_w row_stride: r_stride col_stride: c_stride row_pad: r_pad col_pad: c_pad
	"2D max pooling"

	^ self
		ffiCall:
			#(KAD_node_t * kad_max2d #(KAD_node_t * self , int kernel_h , int kernel_w , int r_stride , int c_stride , int r_pad , int c_pad))
		library: Libkautodiff