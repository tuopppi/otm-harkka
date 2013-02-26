class Sivupalkki {
  PGraphics buf;
  
  Sivupalkki() {
    buf = createGraphics(200, height);
  }
  
  void draw() {
    
    /* Kaikki funktiokutsut jotka piirtää beginDraw ja endDraw väliin */
    buf.beginDraw();
    
    buf.background(128);
    buf.text("hello", 20, 20);
   
    buf.endDraw();
    
    // piirrä ruudullesivupalkki    
    image(buf, width-200, 0);
  }
  
}
