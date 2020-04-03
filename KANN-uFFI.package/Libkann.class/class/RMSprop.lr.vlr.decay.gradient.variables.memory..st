as yet unclassified
RMSprop: n lr: h0 vlr: h decay: decay gradient: g variables: t memory: r
	^ self
		ffiCall:
			#(void kann_RMSprop #(int n , float h0 , const void * h , float decay , const void * g , void * t , void * r))