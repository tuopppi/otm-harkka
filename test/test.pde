Tower tw;
Sivupalkki sivupalkki;
Kentta kentta;

void setup() {
  size(800, 600);
  sivupalkki = new Sivupalkki();
  kentta = new Kentta();
  tw = new Tower(0, 0);
}

void draw() {
  PVector k = kentta.get_coord(mouseX, mouseY);
  tw.set_location(k);
  
  background(255);
  
  tw.draw();
  kentta.draw();
  sivupalkki.draw();
}

/* -------------------------------- */

void mouseReleased() {
  PVector k = kentta.get_coord(mouseX, mouseY);
  kentta.set_color(k);
}

void mousePressed() {
  tw.lock();
}


