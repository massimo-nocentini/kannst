*KANN-uFFI
asArrayOf: aType size: size
	^ self getHandle readArrayOf: aType until: [ :a :j | j > size ]