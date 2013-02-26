class Kentta {
  
  Kentta() {
    background(244);
  }
  
  PVector get_coord(int x, int y) {
    return new PVector((int)(x/50), (int)(y/50));
  }
  
  void set_color(PVector kk) {
    fill(24);
    rectMode(CORNER);
    rect(kk.x*50, kk.y*50, 50, 50);
  }
  
  void draw() {

    /* Kaikki funktiokutsut jotka piirtää beginDraw ja endDraw väliin */
    
    
    fill(0);
    for(int i = 1; i < 12; i++) {
      line(i * 50,0, i*50,height);
      line(0, i * 50, width, i*50);
    }
    

  }
  
}

