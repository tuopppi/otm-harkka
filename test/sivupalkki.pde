class Sivupalkki {
  PGraphics sivupalkki;
  int _level = 0;
  
  Sivupalkki() {
    sivupalkki = createGraphics(200, height);
  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  void draw() {
    sivupalkki.beginDraw();
    /* Kaikki funktiokutsut jotka piirtää beginDraw ja endDraw väliin */
    
    sivupalkki.background(200);
    sivupalkki.text(_level, 20, 20);
    
    sivupalkki.endDraw();
    
    // piirrä ruudulle
    image(sivupalkki, width-200, 0);  
  }
  
}

