utilities
trap_fe
	"abort on divide-by-zero and NaN"

	^ self ffiCall: #(void kad_trap_fe #(void))