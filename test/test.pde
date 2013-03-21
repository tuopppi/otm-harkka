Tower tw;
Sivupalkki sivupalkki;
Kentta kentta;
Pelaaja pelaaja;
int time = 0;
int mouseWait = 0;


void setup() {
  size(800, 600);
  sivupalkki = new Sivupalkki();
  kentta = new Kentta();
  tw = new Tower(0, 0);
  // TODO: siirrä oikeaan paikkaan tila systeemissä
  pelaaja = new Pelaaja("Pelaaja1");
}

void draw() {
  PVector grid_coord = kentta.get_coord(mouseX, mouseY);
  if(kentta.is_free(grid_coord)) {
    tw.set_location(grid_coord);
  }
  
  background(140,199,78); // kentän taustaväri (vihreä)
  
  kentta.draw();
  tw.draw();
  sivupalkki.draw();
  //seuraavat pidetään teknisistä syistä ihan drawin lopussa
  if(mouseWait>0)
    mouseWait--;
}

/* -------------------------------- */

void mouseReleased() {
}

void mousePressed() {
  tw.lock();
}


boolean rectClicked(int x1, int x2, int y1, int y2, int trax, int tray) {
  if(x1+trax <= mouseX && mouseX <= x2+trax
  && y1+tray <= mouseY && mouseY <= y2+tray
  && mouseWait > 0) { 
    return true;
  }
  
  return false;
}

void mouseClicked() {
  
  mouseWait = 1;
  println(mouseWait);
}


