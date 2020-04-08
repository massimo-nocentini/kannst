*KANN-Visualizations
gtInspectorBackwardTreeIn: composite
	<gtInspectorPresentationOrder: 30>
	composite fastTreeTable
		title: 'Backward tree';
		display: [ self sinks ];
		children: [ :each | each children ];
		column: 'type'
			evaluated: [ :each | self describeTypeOfKAD_node_t: each ];
		column: 'flag' evaluated: [ :each | each flag ];
		column: 'ext_flag' evaluated: [ :each | each ext_flag ];
		column: 'ext_label' evaluated: [ :each | each ext_label ];
		shouldAllExpand: true