accessing platform
unixLibraryName
	"^ ((IceRepository
		registeredRepositoryIncludingPackage: 'KANN' asPackage)
		basicCodeDirectory / 'kann-libs' / 'libkautodiff.so') asPath fullName"

	^ 'libkautodiff.so'