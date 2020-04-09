*KANN-Visualizations
gtInspectorComputationalGraphViewIn: composite
	<gtInspectorPresentationOrder: 31>
	^ composite roassal2
		title: 'Graph';
		initializeView: [ RTMondrian new ];
		painting: [ :b | self gtInspectorComputationalGraphUsingMondrianBuilder: b ];
		yourself