tests
testGenerate_EmptySeed
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
						assert: (tg generate: kann_t seed: '' length: 1000)
						equals:
							'iron di tua verna e graviena
ne/ so che fa i siemenza il fuso e conte;

cosi` fui d''Arno, dove in un punto
salto` e dal proposto lor si sciolse.

Di che ciascun di colpa fu compunto,
ma quei piu` che cagion fu del difetto;
pero` si mosse e grido`: <<Tu se'' giunto!>>.

Ma poco i valse: che/ l''ali al sospetto
non potero avanzar; quelli ando` sotto,
e quei drizzo` volando suso il petto:

non altrimenti l''anitra di botto,
quando ''l falcon s''appressa, giu` s''attuffa,
ed ei ritorna su` crucciato e rotto.

Irato Calcabrina de la buffa,
volando dietro li tenne, invaghito
che quei campasse per aver la zuffa;

e come ''l barattier fu disparito,
cosi` volse li artigli al suo compagno,
e fu con lui sopra ''l fosso ghermito.

Ma l''altro fu bene sparvier grifagno
ad artigliar ben lui, e amendue
cadder nel mezzo del bogliente stagno.

Lo caldo sghermitor su`bito fue;
ma pero` di levarsi era neente,
si` avieno inviscate l''ali sue.

Barbariccia, con li altri suoi dolente,
quattro ne fe/ volar da l''altra ' ] ]