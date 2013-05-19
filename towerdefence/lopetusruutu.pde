

class Lopetusruutu {
    
  private color _taustaVari;
  private color _ilmoitusvari;
  private Hiscorelista _hiscorelista;
  public boolean _hiscorePaivitetty;

  Lopetusruutu(color taustavari, color ilmoitusvari){
    _taustaVari = taustavari;
    _ilmoitusvari = ilmoitusvari;
    _hiscorelista = new Hiscorelista(0);
    _hiscorePaivitetty = false;
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

    String aloitauusi = "Paina ENTER aloittaaksesi uuden pelin";
    String loppuinfo = "Peli loppui. \nPääsit tasolle " + Integer.toString(kentta.getTaso());

    text(loppuinfo, width/2-textWidth(loppuinfo)/2+200, height/2-30);
    text(aloitauusi, width/2-textWidth(aloitauusi)/2, height-150);

    if(!_hiscorePaivitetty) {
      _hiscorelista.paivitaLista(pelaaja.get_nimi(), pelaaja.get_pisteet());
      _hiscorePaivitetty = true;
    }

    text("HISCORES", 10, 50);
    _hiscorelista.piirraLista();
     
  }
}
  
  


