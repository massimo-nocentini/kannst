tests
x: x atAllPut: vx y: y asAllPut: vy size: size
	x do: [ :xHandle | (FFIArray fromHandle: xHandle type: #float size: size) atAllPut: vx ].
	y do: [ :yHandle | (FFIArray fromHandle: yHandle type: #float size: size) atAllPut: vy ]