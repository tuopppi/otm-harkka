class Sivupalkki {

  int _level = 0;
  PFont f;
  private Laskuri _laskuri;
  
  Sivupalkki(Laskuri laskuri) {
    _laskuri = laskuri;
  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  void draw() {
    pushMatrix();
    translate(VTRANSX, VTRANSY);
    //EI käytetä translate-funktiota sivupalkin ominaisuuksien kanssa, koska
    //se ja Xmouse/Ymouse ei sovellu ollenkaan yhteen -> nappien painalluksien
    //tunnistamisesta tulee aivan * vaikeaa.
    //translate(width-200, 0);
     
    fill(200);
    rectMode(CORNER);
    rect(10, 10, 200-20, height-20, 5);
    text(_level, 20, 20);
    
    //Ylimpänä sivupalkissa on aika

    f = createFont("Georgia",10,true); 
    textFont(f,12);                 
    fill(20);
    
    text("Seuraava aalto:",30,40);  
    text(_laskuri.getTime(),30,60);  //Display Text
    text("s",45,60);
    
    //Rahatilanne
    
    //Ostettavat tykit (KAUPPA)
    pushMatrix();
    translate(-1*VTRANSX, -1*VTRANSY);
    punaTykkiNappi.draw();
    vihrTykkiNappi.draw();
    siniTykkiNappi.draw();
    
    if(punaTykkiNappi.pressed()) {
      tornit[tornienLkm] = new Tower(0, 0);
      tornienLkm++;
    }
    popMatrix();
    //Valitun (kentältä/kaupasta) tykin tiedot
    //Kentän numero
    popMatrix();
  }
  
}

