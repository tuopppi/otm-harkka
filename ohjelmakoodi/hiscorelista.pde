import java.io.*;

/*	Toplista lataa karttaa koskevat hiscorelistan (piste- ja nimitiedostot)
	ja tulostaa näitä vastaavan listan ruudulle. Luokkaan kuuluu myös
	mahdollinen uuden nimen (ja pisteiden) lisäys listaan 
	*/

class Hiscorelista {
	
	///listan yksittäinen elementti
	private class HiscoreElementti {

		HiscoreElementti(String nimi, int pisteet) {
			_nimi = nimi;
			_pisteet = pisteet;
		}

		//getterit nimelle ja pisteille stringeinä (tai inttinä)
		public String nimi() {
			return _nimi;
		}

		public int pisteet() {
			return _pisteet;
		}

		public String pisteetString() {
			return Integer.toString(_pisteet);
		}

		//kys. elementin tiedot
		private String _nimi;
		private int _pisteet;

	}

	private List<HiscoreElementti> _elementit;
	private int _karttaNro;

	///konstruktori listalle
	Hiscorelista(int karttaNro) {

		_elementit = new ArrayList<HiscoreElementti>();
		_karttaNro = karttaNro;

		try{
			lataaLista();
		} catch (IOException ioe) {
			//TODO: ilmoitus tiedoston lukemisen epäonnistumisesta
			return;
		}
		
	}

	///listan päivitys ajantasaiseksi
	public void paivitaLista(String omaNimi, int omatPisteet) {
		paivitaLista(omaNimi, omatPisteet, _karttaNro);
	}

	public void paivitaLista(String omaNimi, int omatPisteet, int karttaNro) {

		_karttaNro = karttaNro;

		if(lisaaNimi(omaNimi, omatPisteet)) {
			//jos nimi lisättiin se tallennetaan tiedostoihin

			try{
				tallennaLista();
			} catch (IOException ioe) {
				//TODO: ilmoitus tiedoston lukemisen epäonnistumisesta
				return;
			}
		}

		//nimi on lisätty mikäli tarvis ja listat on tallennettu oikein
		
	}

	///listan lataaminen tiedostosta
	private void lataaLista() throws IOException {

		//luodaan oma directory hiscoreille jos semmoista ei ole
		File kansio = new File("TornipuolustusHiscores");
		if(!kansio.isDirectory()) {
			kansio.mkdir();
		}

		//yritetään ladata hiscore-tiedostoa ja luodaan semmoinen jos
		//sitä ei löydy
		File hiscNimet =
			new File("TornipuolustusHiscores\\kentta"+_karttaNro+"HiscoreNimet.txt");
		File hiscPisteet =
			new File("TornipuolustusHiscores\\kentta"+_karttaNro+"HiscorePisteet.txt");
		
		if(!hiscNimet.exists()) {
			hiscNimet.createNewFile();
		}
		if(!hiscPisteet.exists()) {
			hiscPisteet.createNewFile();
		}

		///tässä vaiheessa oikea tiedosto on auki

		//yritetään lukea tiedostoja (heitetään tarvittaessa IOException)
		boolean tiedostotKorruptoituneet = false;

		BufferedReader nimiLukija =
			new BufferedReader(new FileReader(hiscNimet));
		BufferedReader pisteLukija =
			new BufferedReader(new FileReader(hiscPisteet));
		
		String luettuNimi;
		String luettuPisteString;
		
		//luetaan nimiä ja pisteitä niin kauan kuin niitä löytyy
		while((luettuNimi = nimiLukija.readLine()) != null ) {

			//jos ei löydy riittävästi pisteitä verrattuna nimiin,
			//tiedostot ovat korruptoituneet
			if((luettuPisteString = pisteLukija.readLine()) == null) {
				tiedostotKorruptoituneet = true;
				break;
			} 

			//muutoin luetut rivit ovat OK, luodaan niistä uusi elementti listaan
			_elementit.add(new HiscoreElementti(luettuNimi, Integer.parseInt(luettuPisteString)));

		}

		//jos vielä löytyy pisteitä, tiedostot ovat korruptoituneet
		if((luettuPisteString = pisteLukija.readLine()) != null) {
			tiedostotKorruptoituneet = true;
		}

		
		if(tiedostotKorruptoituneet) {
			// TODO: korruptoituneiden tiedostojen tyhjentäminen ja ilmoitus
		}

		/// tässä vaiheessa käsillä on täydellinen lista elementeistä
		nimiLukija.close(); pisteLukija.close();
	}

	///uuden nimen/pisteen lisäys listaan (BOOLEAN)
	private boolean lisaaNimi(String nimi, int pisteetInt) {
		//mikä on pisteiden suuruus iteraattorin kohdalla
		int nykyinen;
		boolean lisatty = false; //onko uusi piste lisätty listaan
		List<HiscoreElementti> uusiHiscorelista = new ArrayList<HiscoreElementti>();

		//jos listassa ei ole ennestään yhtäkään nimeä, lisätään
		if(_elementit.size() == 0) {
			uusiHiscorelista.add(new HiscoreElementti(nimi, pisteetInt));
			lisatty = true;
		}
		else if(!lisatty) {

			for(int i = 0; i < _elementit.size(); ++i) {

				//jos i:s piste on listalla pienempi kuin pisteetInt,
				//lisätään pisteetInt sen yläpuolelle
				if(!lisatty && _elementit.get(i).pisteet() < pisteetInt) {
					uusiHiscorelista.add(new HiscoreElementti(nimi, pisteetInt));
					lisatty = true;
				}
				
				if((i < 10 && !lisatty) || (i < 9 && lisatty)) { //listalle otetaan tasan 10 elementtiä
						uusiHiscorelista.add(_elementit.get(i));
				}
			}
		}

		//jos listassa on alle 10 elementtiä ja ei lisätty loopissa,
		//lisätään listan pohjimmaiseksi
		if(_elementit.size() < 10 && !lisatty) {
			uusiHiscorelista.add(new HiscoreElementti(nimi, pisteetInt));
			lisatty = true;
		}

		//uusi lista ok, asetetaan uusi vanhan päälle
		_elementit.clear();
		Iterator<HiscoreElementti> it = uusiHiscorelista.iterator();
		while(it.hasNext()) {
			HiscoreElementti foo = it.next();
			_elementit.add(foo);
		}

		return lisatty;
	}

	///listan tallennus (sisältäen 10 nimeä/pistettä)
	private void tallennaLista() throws IOException {

		//lisaaLista-metodi on suoritettu, joten kansiot on kunnossa ja
		//tiedostot olemassa
		
		//valitaan tiedostot
		File hiscNimet =
			new File("TornipuolustusHiscores\\kentta"+_karttaNro+"HiscoreNimet.txt");
		File hiscPisteet =
			new File("TornipuolustusHiscores\\kentta"+_karttaNro+"HiscorePisteet.txt");

		//ladataan tiedostot tiedostokirjoittajaan joka ladataan kirjoituspuskuriin
		BufferedWriter nimiKirjoittaja = new BufferedWriter(new FileWriter(hiscNimet));	
		BufferedWriter pisteKirjoittaja = new BufferedWriter(new FileWriter(hiscPisteet));

		//käydään lista läpi ja kirjoitetaan jokainen elementti tiedostoon
		Iterator<HiscoreElementti> it = _elementit.iterator();
		while(it.hasNext()) {

			HiscoreElementti temp = it.next();
			nimiKirjoittaja.write(temp.nimi());
			pisteKirjoittaja.write(temp.pisteetString());
			if(it.hasNext()) {
				nimiKirjoittaja.newLine();
				pisteKirjoittaja.newLine();
			}
		}

		//lista kirjoitettu tiedostoon
		nimiKirjoittaja.close(); pisteKirjoittaja.close();
	}

	///listan piirto rivi riviltä
	public void piirraLista() {

		Iterator<HiscoreElementti> it = _elementit.iterator();
		int ySijainti = 0;
		while(it.hasNext()) {

			++ySijainti;
			HiscoreElementti obj = it.next();
			text(obj.nimi()+" - "+obj.pisteetString(), 60, 60+30*ySijainti);			
		}

	}
}