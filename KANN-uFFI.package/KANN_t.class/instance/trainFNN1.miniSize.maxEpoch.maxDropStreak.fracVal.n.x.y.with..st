training
trainFNN1: lr miniSize: mini_size maxEpoch: max_epoch maxDropStreak: max_drop_streak fracVal: frac_val n: n x: x y: y with: aBlock
	| callback |
	callback := FFICallback
		signature: #(void #(int , double , int , float , int , double , int , float))
		block: aBlock.
	^ self
		trainFNN1: lr
		miniSize: mini_size
		maxEpoch: max_epoch
		maxDropStreak: max_drop_streak
		fracVal: frac_val
		n: n
		x: x
		y: y
		callback: callback