tests
testKANN_data_t_printOn
	Libkann_data
		readFromFileNamed: (self dataPath / 'mnist-train-x.knd.gz') fullName
		with: [ :x | 
			self halt.	"leave a breakpoint to inspect the following dataset before releasing x"
			x asDataset: KANNDatasetMNIST ]