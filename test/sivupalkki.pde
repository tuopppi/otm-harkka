class Sivupalkki {

  int _level = 0;
  
  Sivupalkki() {

  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  void draw() {
    translate(width-200, 0);

    fill(200);
    rectMode(CORNER);
    rect(0+10, 0+10, 200-20, height-20, 5);
    text(_level, 20, 20);

  }
  
}

