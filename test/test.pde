//käytetään comicsanssia valikossa (ja vähän muuallakin)
PFont valikkoFontti = createFont("Trebuchet MS Bold", 60, true);

OutPutStream striimi;
Sivupalkki sivupalkki;
Kentta kentta;
Pelaaja pelaaja;
Laskuri aalto_laskuri;
Lopetusruutu lopetusruutu;
Textbox nimilaatikko;
int timer = 0;

// Pelin globaalit tilat
final static int KysyNimi_tila = 0;
final static int TervehdiPelaajaa_tila = 1;
final static int AloitaPeli_tila = 2;
final static int PiirraKentta_tila = 3;
final static int Lopetusruutu_tila = 4;
int tila;

void setup() {
  size(800, 600);
  tila = AloitaPeli_tila;
  striimi = new OutPutStream();
  pelaaja = new Pelaaja(); // init_new_game tarvitsee "defaulttipelaajan"
  init_new_game();
  lopetusruutu = new Lopetusruutu(color(0,0,200), color(200,0,0));
  nimilaatikko = new Textbox(width/2-100, height/2-30, "Pelaajan nimi");
}

void init_new_game() {
  // lopetusruudussa kun painetaan ENTER alustetaan uusi peli samoilla pelaajatiedoilla
  String exnimi = pelaaja.get_nimi();
  pelaaja = new Pelaaja();
  pelaaja.set_nimi(exnimi);
  aalto_laskuri = new Laskuri();
  kentta = new Kentta(color(0,0,200), color(200,0,0));
  sivupalkki = new Sivupalkki();
}

void draw() {
  switch(tila) {
  case KysyNimi_tila:
    
    nimilaatikko.draw();
    if(nimilaatikko.is_ready()) {
      // Käyttäjä kirjoittanut nimensä ja painanut enteriä
      pelaaja.set_nimi(nimilaatikko.get_data());
      tila = TervehdiPelaajaa_tila;
    }
    break;
    
  case TervehdiPelaajaa_tila:
      striimi.tervehdiPelaaja(pelaaja.get_nimi());
      odota_ja_siirry(1000, AloitaPeli_tila);
      break;
    
  case AloitaPeli_tila:
    striimi.aloitaPeli();
    odota_ja_siirry(500, PiirraKentta_tila);
    break;
  
  case PiirraKentta_tila:
    kentta.draw();
    sivupalkki.draw();  

    if (pelaaja.get_elamat() <= 0) {
      odota_ja_siirry(500, Lopetusruutu_tila);
    }
    break;

  case Lopetusruutu_tila:
    lopetusruutu.draw();     
    break;
  }
}

void mouseMoved() {
  //onko hiiri sivupalkin napin päällä?
  if(mouseX > sivupalkki.offset.x) {
    sivupalkki.mouseMoved();
  }
  else { //onko hiiri kentän päällä?
    kentta.mouseMoved();
  }
}

void mouseClicked() {
  if(mouseX > sivupalkki.offset.x) {    //jos painetaan valikon nappia...
    sivupalkki.mouseClicked();
  }
  else {
    kentta.mouseClicked(); // painettiin kenttää
  }
}

void keyPressed() {
  switch(tila) {
  case KysyNimi_tila:
    nimilaatikko.read_key(); // kerro textboxille että uutta dataa key-muuttujassa
    break;
  case PiirraKentta_tila:
    if(key == ESC) {
      key = 0; // Estää ohjelmaa sulkeutumasta
      kentta.peruutaRakennus();
      break;
    }
  case Lopetusruutu_tila:
    if(key == ENTER) {
      init_new_game();
      tila = AloitaPeli_tila;
    }
  }
}

// Käyttää globaaleja muuttujia timer, tila
void odota_ja_siirry(int time, int next_state) {
  if(timer == 0) {
    timer = millis() + time;
  } else if(timer < millis()) {
    tila = next_state;
    timer = 0;
  }
}
