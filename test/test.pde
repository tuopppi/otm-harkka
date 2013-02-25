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
//tw.upgrade();

  

}

void mousePressed() {
  if(tw.is_locked()) {  
    if(tw.clicked(mouseX, mouseY)) {
      tw.show_info();
    }
  } else {
    tw.lock();
  }
  
    
   
}

/* -------------------------------- */

void update(int x, int y) {
  tw.set_location(x, y);
}


