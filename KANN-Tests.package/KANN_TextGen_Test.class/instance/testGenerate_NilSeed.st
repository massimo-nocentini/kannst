tests
testGenerate_NilSeed
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
						assert: (self tg_data_t_Inferno generate: kann_t seed: nil length: 1000)
						equals:
							'lor disse: <<Or denti e` Noi anza!>>,
disse ''l maestro, <<che ''l tuo non e` stato;
pero` d''ogne trestizia ti disgrava.

E fa ragion ch''io ti sia sempre allato,
se piu` avvien che fortuna t''accoglia
dove sien genti in simigliante piato:

che/ voler cio` udire e` bassa voglia>>.

Canto XXXI

Una medesma lingua pria mi morse,
si` che mi tinse l''una e l''altra guancia,
e poi la medicina mi riporse;

cosi` od'' io che solea far la lancia
d''Achille e del suo padre esser cagione
prima di trista e poi di buona mancia.

Noi demmo il dosso al misero vallone
su per la ripa che ''l cinge dintorno,
attraversando sanza alcun sermone.

Quiv'' era men che notte e men che giorno,
si` che ''l viso m''andava innanzi poco;
ma io senti'' sonare un alto corno,

tanto ch''avrebbe ogne tuon fatto fioco,
che, contra se/ la sua via seguitando,
dirizzo` li occhi miei tutti ad un loco.

Dopo la dolorosa rotta, quando
Carlo Magno perde/ la santa gesta,
non sono` si` terribilmente Orlando.

Poco portai in la` volta la test' ] ]