accessing platform
unixLibraryName
	"^ ((IceRepository
		registeredRepositoryIncludingPackage: 'KANN' asPackage)
		basicCodeDirectory / 'kann-libs' / 'libkann_data.so') asPath fullName"

	^ 'libkann_data.so'