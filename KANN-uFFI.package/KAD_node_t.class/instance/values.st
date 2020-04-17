unary operands
values
	^ FFIArray
		fromHandle: self accessor_x getHandle
		type: #float
		size: self len