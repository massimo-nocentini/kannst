accessing platform
unixLibraryName
	"^ ((IceRepository
		registeredRepositoryIncludingPackage: 'KANN' asPackage)
		basicCodeDirectory / 'kann-libs' / 'libkann.so') asPath fullName"

	^ 'libkann.so'