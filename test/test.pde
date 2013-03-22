Tower[] tornit;
int tornienLkm = 0;

Sivupalkki sivupalkki;
Kentta kentta;
Pelaaja pelaaja;
Laskuri laskuri;

//sivupalkin napit
int time = 0;

boolean mouseClick = false;

void setup() {
  size(800, 600);
  
  laskuri = new Laskuri();
  kentta = new Kentta(laskuri);
  sivupalkki = new Sivupalkki(laskuri);
  
  laskuri.starttaaLaskuri();

  //taulukko torneista (kentällä maksimissaan (teoriassa) 12*12=124 tornia)
  tornit = new Tower[124];
   
  // TODO: siirrä oikeaan paikkaan tila systeemissä
  pelaaja = new Pelaaja("Pelaaja1");
}

void draw() {
  
  PVector grid_coord = kentta.get_coord(mouseX, mouseY);
  
  background(140,199,78); // kentän taustaväri (vihreä)
  kentta.draw();
  
 
  //piirretään kentälle tornit
  for(int i=0; i<tornienLkm; ++i) {
    tornit[i].draw();
  }
  
  sivupalkki.draw();
  
  //piirretään rakennettava, hiiren mukana kulkeva torni (mikäli tarpeen)
  if(tornienLkm > 0 && !tornit[tornienLkm-1].is_locked() && kentta.is_free(grid_coord)) {
    
    tornit[tornienLkm-1].set_location(grid_coord);
    
  }

}

/* -------------------------------- */

void mouseClicked() {
  if(mouseX > sivupalkki.offset.x) {
    sivupalkki.mouseClicked();
	sivupalkki._valikonNappiPohjassa = false;
  } 
  else {
    tornit[tornienLkm-1].lock();
  }
}


