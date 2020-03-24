as yet unclassified
gtInspectorTextIn: composite
	<gtInspectorPresentationOrder: 10>
	((kann_data_t rowsStream next: 10)
		collect: [ :anAssoc | anAssoc key -> (self ascii: anAssoc value) ])
		asDictionary gtInspectorItemsIn: composite