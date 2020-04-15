initialization
initialize
	super initialize.
	len := n_char := 0.
	data := Array empty.
	para := Array empty.
	c2i := Array new: 256 withAll: 0