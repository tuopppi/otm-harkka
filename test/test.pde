Tower tw;
Sivupalkki sivupalkki;
Kentta kentta;
int time = 0;

void setup() {
  size(800, 600);
  sivupalkki = new Sivupalkki();
  kentta = new Kentta();
  tw = new Tower(0, 0);
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
}

/* -------------------------------- */

void mouseReleased() {
}

void mousePressed() {
  tw.lock();
}


