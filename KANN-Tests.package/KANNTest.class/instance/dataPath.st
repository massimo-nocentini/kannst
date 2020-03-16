tests
dataPath
	^ (IceRepository
		registeredRepositoryIncludingPackage: 'KANN' asPackage)
		basicCodeDirectory / 'data-and-models' / 'kann-data'