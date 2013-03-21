class Sivupalkki {

  int _level = 0;
  int _testi = 0;
  PFont f;
  Laskuri laskuri;
  boolean halytysAnnettu = false;
  Sivupalkki() {
    laskuri = new Laskuri();
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
    laskuri.starttaaLaskuri();
    f = createFont("Georgia",20,true); 
    textFont(f,32);                 
    fill(20);
      
    text(laskuri.getTime(),30,60);  //Display Text
    text("s",70,60);
    
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

