Tower[] tornit;
int tornienLkm = 0;

Sivupalkki sivupalkki;
Kentta kentta;
Pelaaja pelaaja;
Laskuri laskuri;

//sivupalkin vas-yläkulman sijainti.
final int VTRANSX = 600;
final int VTRANSY = 0;

//sivupalkin napit
  //luodaan napit
  Nappi punaTykkiNappi;
  Nappi vihrTykkiNappi;
  Nappi siniTykkiNappi;
  
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
  
  //sivupalkin napit
  punaTykkiNappi = new Nappi(20+0,   0+150, 50, 50, color(255,0,0), true);
  vihrTykkiNappi = new Nappi(20+55,  0+150, 50, 50, color(0,255,0), true);
  siniTykkiNappi = new Nappi(20+110, 0+150, 50, 50, color(0,0,255), true);
  
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
  if(tornienLkm > 0 && tornit[tornienLkm-1]._locked == false && kentta.is_free(grid_coord)) {
    
    tornit[tornienLkm-1].set_location(grid_coord);
    tornit[tornienLkm-1].draw();
    
    if(mouseClick) {
      
      sivupalkki._valikonNappiPohjassa = false;
      tornit[tornienLkm-1].lock();
    }
  }
  
  //seuraavat pidetään teknisistä syistä ihan drawin lopussa
  
  mouseClick = false;
}

/* -------------------------------- */
/*
void mouseReleased() {
}

void mousePressed() {
}

*/

boolean rectClicked(int x, int y, int w, int h) {
  
  if(x <= mouseX && mouseX <= x+w
  && y <= mouseY && mouseY <= y+h
  && mouseClick == true) {
    mouseClick = false; 
    return true;
  }
  
  return false;
}

void mouseClicked() {
  
  mouseClick = true;
}


