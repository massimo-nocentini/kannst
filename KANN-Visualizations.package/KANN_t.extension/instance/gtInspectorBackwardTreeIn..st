*KANN-Visualizations
gtInspectorBackwardTreeIn: composite
	<gtInspectorPresentationOrder: 10>
	^ composite fastTreeTable
		title: 'Backward tree';
		display: [ self sinks ];
		children: [ :each | each children ];
		column: 'flag' evaluated: [ :each | each flag ];
		"
		column: 'Value'
			evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];"
			beMultiple