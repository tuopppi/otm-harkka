PFont f;
OutPutStream striimi;
Textbox nimilaatikko;

// Tämä varmaan jatkossa Pelaaja luokan sisällä
String pelaajan_nimi = "";

// Pelin globaalit tilat
final static int KysyNimi_tila = 0;
final static int TervehdiPelaajaa_tila = 1;
final static int AloitaPeli_tila = 2;
int tila;

void setup() {
  size(1024,768);
  background(0,150,200,40);
  striimi = new OutPutStream();
  tila = KysyNimi_tila;
  nimilaatikko = new Textbox(width/2-100, height/2-30, "Pelaajan nimi");
}

void keyPressed() {
  switch(tila) {
  case KysyNimi_tila:
    nimilaatikko.read_key(); // kerro textboxille että uutta dataa key-muuttujassa
    break;
  }
}


void draw() {
  
  switch(tila) {
  case KysyNimi_tila:
    nimilaatikko.display();
    if(nimilaatikko.is_ready()) {
      pelaajan_nimi = nimilaatikko.get_data();
      tila = TervehdiPelaajaa_tila;
    }
    break;
    
  case TervehdiPelaajaa_tila:
    striimi.tervehdiPelaaja(pelaajan_nimi);
    tila = AloitaPeli_tila;
    break;
    
  case AloitaPeli_tila:
    striimi.aloitaPeli();
    tila = TervehdiPelaajaa_tila;
    break;
  }
  
}
