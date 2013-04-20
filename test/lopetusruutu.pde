

class Lopetusruutu {
    
  private color _taustaVari;
  private color _ilmoitusvari;
  Lopetusruutu(color taustavari, color ilmoitusvari){
    _taustaVari = taustavari;
    _ilmoitusvari = ilmoitusvari;
  }
  
  void draw() {   
    this.piirraTausta();
  }
  
  private void piirraTausta() {
    
    noStroke();   
    final int koko = 20;
      
    int aika1 = (millis()/100)%500 + 12;
    if(aika1 > 256) {
      aika1 = 256 - (aika1 - 256);
    }
      
    pushMatrix();
    translate(width/2, 0);
    for(int y = 0; y < height/koko; ++y) {
      for(int x = width/(-2*koko); x < width/(2*koko); ++x) {
        //huippuunsa viritetty matrix-efektialgoritmi
        fill(((red(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10))%255-230,
                 ((green(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10)%255)-230,
                 ((blue(_taustaVari)*sin(-1*sqrt(y*aika1)/200-x*aika1/200)*aika1/10)%255)-230);
        rect(x*koko, y*koko, koko, koko);
      }
    }
    
    
    popMatrix();
    
      fill(_ilmoitusvari);
      textFont(valikkoFontti, 36);
      textAlign(LEFT);
      text("Delasit.", width/2-100, height/2-30);
      textAlign(RIGHT);
     
  }
}
  
  


