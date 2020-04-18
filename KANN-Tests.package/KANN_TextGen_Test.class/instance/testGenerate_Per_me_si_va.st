tests
testGenerate_Per_me_si_va
	| tg |
	"Prepare the corpus"
	tg := Tg_data_t fromCorpusPath: self dataPath / 'inferno.txt'.

	"Load the trained network."
	Libkann
		srand: 11;
		loadFromFileNamed: (self modelsPath / 'text-inferno.kan') fullName
			with: [ :kann_t | 
			| temperature |
			"Prepare the initial node"
			temperature := 0.4.
			(kann_t find_node: 0 label: -1) values
				at: 1
				put: temperature reciprocal asFloat.
			kann_t
				switchToPrediction;
				rnn_run: [ self
						assert: (tg generate: kann_t seed: 'Per me si va' length: 1000)
						equals:
							'Per me si va i crendessate,
la somma sapienza e ''l primo amore.

Dinanzi a me non fuor cose create
se non etterne, e io etterno duro.
Lasciate ogne speranza, voi ch''intrate''.

Queste parole di colore oscuro
vid'' io scritte al sommo d''una porta;
per ch''io: <<Maestro, il senso lor m''e` duro>>.

Ed elli a me, come persona accorta:
<<Qui si convien lasciare ogne sospetto;
ogne vilta` convien che qui sia morta.

Noi siam venuti al loco ov'' i'' t''ho detto
che tu vedrai le genti dolorose
c''hanno perduto il ben de l''intelletto>>.

E poi che la sua mano a la mia puose
con lieto volto, ond'' io mi confortai,
mi mise dentro a le segrete cose.

Quivi sospiri, pianti e alti guai
risonavan per l''aere sanza stelle,
per ch''io al cominciar ne lagrimai.

Diverse lingue, orribili favelle,
parole di dolore, accenti d''ira,
voci alte e fioche, e suon di man con elle

facevano un tumulto, il qual s''aggira
sempre in quell'' aura sanza tempo tinta,
come la rena quando turbo spira.

E io ch''avea d''error la testa cinta,
dissi: ' ] ]