tests
initTg_data_t: tg
	| j st k slash_N |
	tg
		data:
			(self trainingSourcePath contents
				collect: [ :aCharacter | aCharacter asInteger ]
				as: Array).
	tg data asBag.	"for understanding."
	tg data do: [ :index | tg c2i at: index put: 1 ].
	j := 0.
	1 to: tg c2i size do: [ :index | 
		(tg c2i at: index) = 0
			ifTrue: [ tg c2i at: index put: -1 ]
			ifFalse: [ tg c2i at: index put: j.
				j := j + 1 ] ].
	tg n_char: j.

	"Paragraphs"
	slash_N := Character lf asInteger.
	st := 1.
	2 to: tg data size do: [ :i | 
		((tg data at: i - 1) = slash_N
			and: [ (tg data at: i) = slash_N and: [ i - st > 1 ] ])
			ifTrue: [ tg accessor: #n_para update: [ :np | np + 1 ].
				st := i + 1 ] ].
	tg data size - st > 0
		ifTrue: [ tg accessor: #n_para update: [ :np | np + 1 ] ].
	tg para: (Array new: tg n_para withAll: Array empty).
	tg para_len: (Array new: tg n_para withAll: 0).
	st := 1.
	k := 1.
	2 to: tg data size do: [ :i | 
		((tg data at: i - 1) = slash_N
			and: [ (tg data at: i) = slash_N and: [ i - st > 1 ] ])
			ifTrue: [ tg para at: k put: (tg data copyFrom: st to: i - 1).
				st := i + 1.
				k := k + 1 ] ].
	tg data size - st > 0
		ifTrue: [ tg para at: k put: (tg data copyFrom: st to: tg data size) ].
	1 to: tg data size do: [ :i | tg data at: i put: (tg c2i at: (tg data at: i)) ].
	self halt