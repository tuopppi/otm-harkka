Tower tw;
Sivupalkki sivupalkki;
Kentta kentta;
Ormy ormy;
int time = 0;

void setup() {
  size(800, 600);
  sivupalkki = new Sivupalkki();
  kentta = new Kentta();
  tw = new Tower(0, 0);
  ormy = new Ormy(kentta);
}

void draw() {
  PVector k = kentta.get_coord(mouseX, mouseY);
  if(kentta.is_free(k)) {
    tw.set_location(k);
  }
  
  background(140,199,78); // kentän taustaväri (vihreä)
  
  kentta.draw();
  tw.draw();
  ormy.draw();
  if(millis() > time + 100) {
    ormy.move();
    time = millis();
  }
  sivupalkki.draw();
}

/* -------------------------------- */

void mouseReleased() {
  PVector k = kentta.get_coord(mouseX, mouseY);
}

void mousePressed() {
  tw.lock();
}


