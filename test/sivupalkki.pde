class Sivupalkki {

  int _level = 0;
  int _testi = 0;
    
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
    
    //Ylimpänä sivupalkissa on aika
    //Rahatilanne
    //Ostettavat tykit
    fill(_testi);
    rect(30,100, 50,50);
    if(rectClicked(30,100, 80,150, width-200,0)) {
      _testi = (int)random(255);
    }
    //Valitun (kentältä/kaupasta) tykin tiedot
    //Kentän numero
    
  }
  
}

