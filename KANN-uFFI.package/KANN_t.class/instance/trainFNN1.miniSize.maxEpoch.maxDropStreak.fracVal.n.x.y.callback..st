training
trainFNN1: lr miniSize: mini_size maxEpoch: max_epoch maxDropStreak: max_drop_streak fracVal: frac_val n: n x: x y: y callback: cb
	^ self
		ffiCall:
			#(int kann_train_fnn1_cb #(KANN_t * self , float lr , int mini_size , int max_epoch , int max_drop_streak , float frac_val , int n , void * x , void * y , FFICallback cb))
		library: Libkann