initialization
initialize
	super initialize.
	len := n_char := n_para := 0.
	para_len := Array empty.
	data := Array empty.
	para := Array empty.
	c2i := Array new: 256 withAll: 0