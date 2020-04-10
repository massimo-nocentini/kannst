*KANN-Visualizations
gtInspectorComputationalGraphUsingMondrianBuilder: aMondrian
	(self
		withNodes: [ :mapping | 
			mapping values
				flatCollect: [ :kad_node_t | 
					kad_node_t children
						collect:
							[ :child | (mapping at: child getHandle) -> (mapping at: kad_node_t getHandle) ] ] ])
		asGraph
		gtInspectorGraphViewUsingMondrianBuilder: aMondrian
		vertex: [ :shape | 
			shape text
				text: [ :vertex | vertex content role ];
				color: Color black ]
		edge: [ :shape | shape arrowedBezier ]
		layout: [ :b | 
			b cluster
				horizontalGap: 100;
				verticalGap: 100;
				yourself ]