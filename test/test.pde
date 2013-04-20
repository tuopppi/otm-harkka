//käytetään comicsanssia valikossa (ja vähän muuallakin)
PFont valikkoFontti = createFont("Comic Sans MS", 60, true);

static final int jotaki = 300;// git testi, tata ei tarvi mihinkaan

Sivupalkki sivupalkki;
Kentta kentta;
Pelaaja pelaaja;
Laskuri aalto_laskuri;

void setup() {
  size(800, 600);
  
  aalto_laskuri = new Laskuri();
  kentta = new Kentta(color(0,0,200), color(200,0,0));
  sivupalkki = new Sivupalkki();
  
  // TODO: siirrä oikeaan paikkaan tila systeemissä
  pelaaja = new Pelaaja("Pelaaja1");
}

void draw() {
  kentta.draw();
  sivupalkki.draw();
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


