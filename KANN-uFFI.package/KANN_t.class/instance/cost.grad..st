as yet unclassified
cost: cost_label grad: cal_grad
	^ self
		ffiCall: #(float kann_cost #(KANN_t * self , int cost_label , int cal_grad))
		library: Libkann