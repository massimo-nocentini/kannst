training
urnn_start: batch_size
	"taken from the textgen example"

	^ self
		ffiCall: #(int kann_urnn_start #(KANN_t * self , int batch_size))
		library: Libkann