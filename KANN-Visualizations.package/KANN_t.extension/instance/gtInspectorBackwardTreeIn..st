*KANN-Visualizations
gtInspectorBackwardTreeIn: composite
	<gtInspectorPresentationOrder: 30>
	composite fastTreeTable
		title: 'Backward tree';
		display: [ self sinks ];
		children: [ :each | each children ];
		column: 'type' evaluated: [ :each | each role ] width: 800;
		column: 'flag' evaluated: [ :each | each flag ] width: 50;
		column: 'ext_flag' evaluated: [ :each | each ext_flag ] width: 80;
		column: 'ext_label' evaluated: [ :each | each ext_label ] width: 80;
		shouldAllExpand: true