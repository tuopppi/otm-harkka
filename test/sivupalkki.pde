class Sivupalkki {

  PVector offset;
  
  int _level = 0;
  PFont f;
  private Laskuri _laskuri;
  
    //luodaan napit
  Nappi punaTykkiNappi;
  Nappi vihrTykkiNappi;
  Nappi siniTykkiNappi;
  
  Sivupalkki(Laskuri laskuri) {
    _laskuri = laskuri;
    offset = new PVector(width-200, 0);
    
    //sivupalkin napit
    punaTykkiNappi = new Nappi(20, 150, 50, 50, color(255,0,0));
    vihrTykkiNappi = new Nappi(20+55, 150, 50, 50, color(0,255,0));
    siniTykkiNappi = new Nappi(20+110, 150, 50, 50, color(0,0,255));
  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  /* Pääohjelman mouseClicked funktio kutsuu tätä funktiota jos painalluksen koordinaatit
   * ovat sivupalkin alueella */
  void mouseClicked() {
    int translated_x = mouseX - (int)offset.x;
    int translated_y = mouseY - (int)offset.y;
    
    if( this.punaTykkiNappi.pressed(translated_x, translated_y) ) {
      print("puna");
      if(pelaaja.muuta_rahoja(-260)) {
        tornit[tornienLkm] = new Tower(12, 3);
        tornienLkm++;
      }
    }
    
    else if( this.vihrTykkiNappi.pressed(translated_x, translated_y) ) {
      print("vihr");
    }
    
    else if( this.siniTykkiNappi.pressed(translated_x, translated_y) ) {
      print("sini");
    }
    
  }
  
  void draw() {

    translate(offset.x, offset.y);
     
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
    text("Rahat:",30,80);
    text(pelaaja.get_rahat(), 70, 80);
    
    //Ostettavat tykit (KAUPPA)
    punaTykkiNappi.draw();
    vihrTykkiNappi.draw();
    siniTykkiNappi.draw();
    
    //Valitun (kentältä/kaupasta) tykin tiedot
    //Kentän numero
  }
  
}

