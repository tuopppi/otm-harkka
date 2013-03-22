class Sivupalkki {

  int _level = 0;
  PFont f;
  private Laskuri _laskuri;
  boolean _valikonNappiPohjassa = false;
  
  Sivupalkki(Laskuri laskuri) {
    _laskuri = laskuri;
  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  void draw() {
    pushMatrix();
    translate(VTRANSX, VTRANSY);
     
    stroke(0);
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
    
    println(tornienLkm);
    
    ///KAUPPANAPPIEN PAINAMINEN
    ////punaisen tykin rakennusnappi
    if(punaTykkiNappi.pressed()) {      
      if(_valikonNappiPohjassa) { tornienLkm--; } //jos jotain nappia on jo painettu kun tätä nappia painetaan, hävitetään edellinen torni
      
      tornit[tornienLkm] = new Tower(0, 0, color(255, 0, 0));
      tornienLkm++;
      _valikonNappiPohjassa = true;
    }
    
    ////vihreän tykin rakennusnappi
    if(vihrTykkiNappi.pressed()) {
      if(_valikonNappiPohjassa) { tornienLkm--; }
      
      tornit[tornienLkm] = new Tower(0, 0, color(0, 255, 0));
      tornienLkm++;
      _valikonNappiPohjassa = true;
    }
    
    ////sinisen tykin rakennusnappi
    if(siniTykkiNappi.pressed()) {
      if(_valikonNappiPohjassa) { tornienLkm--; }
      
      tornit[tornienLkm] = new Tower(0, 0, color(0, 0, 255));
      tornienLkm++;
      _valikonNappiPohjassa = true;
    }
    
    popMatrix();
    //Valitun (kentältä/kaupasta) tykin tiedot
    //Kentän numero
    popMatrix();
  }
  
}

