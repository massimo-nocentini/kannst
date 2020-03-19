*KANN-uFFI
asArrayOf: aType size: size
	^ self readArrayOf: aType until: [ :a :j | j > size ]