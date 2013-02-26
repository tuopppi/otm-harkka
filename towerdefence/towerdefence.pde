PFont f;
OutPutStream striimi;
Textbox nimilaatikko;
int[] k1X = {100, 100, 200, 200, 500, 500, 600, 600, 300, 300}; //{0,0}; //
int[] k1Y = {500, 100, 100, 300, 300, 500, 500, 200, 200, 000}; //{0,1}; //  
Kentta kentta1;

Pelaaja pelaaja;

// Pelin globaalit tilat
final static int KysyNimi_tila = 0;
final static int TervehdiPelaajaa_tila = 1;
final static int AloitaPeli_tila = 2;
final static int PiirraKentta_tila = 3;
int tila;

int timer = 0;

void setup() {
  size(1024,768);
  background(0,150,200,40);
  striimi = new OutPutStream();
  tila = KysyNimi_tila;
  nimilaatikko = new Textbox(width/2-100, height/2-30, "Pelaajan nimi");
 kentta1 = new Kentta(color(0,0,140), color(255,255,0), k1X, k1Y);
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
    nimilaatikko.draw();
    if(nimilaatikko.is_ready()) {
      // Käyttäjä kirjoittanut nimensä ja painanut enteriä
      pelaaja = new Pelaaja(nimilaatikko.get_data());
      tila = TervehdiPelaajaa_tila;
    }
    break;
    
  case TervehdiPelaajaa_tila:
      striimi.tervehdiPelaaja(pelaaja.get_nimi());
      odota_ja_siirry(2000, AloitaPeli_tila);
      break;
    
    
  case AloitaPeli_tila:
    striimi.aloitaPeli();
    odota_ja_siirry(2000, PiirraKentta_tila);
    break;
  
  
  case PiirraKentta_tila:
     kentta1.piirraKentta();
     break;
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
