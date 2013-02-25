Tower tw;

void setup() {
  size(640, 480);
  tw = new Tower(0, 0);
}

void draw() {
  update(mouseX, mouseY);
  
  background(255);
  tw.draw();  
}

/* -------------------------------- */

void mouseReleased() {
  tw.hide_info();
}

void mousePressed() {
  tw.lock();
  tw.show_info();
  tw.upgrade();
}

/* -------------------------------- */

void update(int x, int y) {
  tw.set_location(x, y);
}


