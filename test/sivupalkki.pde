class Sivupalkki {

  PVector offset;
  
  int _level = 0;
  PFont f;
  private Laskuri _laskuri;
  boolean _valikonNappiPohjassa = false;
  
  
  


  Nappi punaTykkiNappi;
  static final int puna_idx = 1;
  Nappi vihrTykkiNappi;
  static final int sini_idx = 2;
  Nappi siniTykkiNappi;
  static final int vihr_idx = 3;
  
  int hiiri_napin_paalla_index = 0;
    
  Sivupalkki(Laskuri laskuri) {
    _laskuri = laskuri;
    offset = new PVector(width-200, 0);
    
    //sivupalkin napit
    punaTykkiNappi = new Nappi(20, 150, 50, 50, color(255,0,0));
    vihrTykkiNappi = new Nappi(20+55, 150, 50, 50, color(0,255,0));
    siniTykkiNappi = new Nappi(20+110, 150, 50, 50, color(0,0,255));
    
    f = createFont("Georgia",10,true); 
    textFont(f,12);   
  }
  
  void set_level(int lvl) {
    _level = lvl;
  }
  
  /* Pääohjelman mouseMoved funktio kutsuu tätä jos hiiri on sivupalkin yläpuolella */
  void mouseMoved() {
    int translated_x = mouseX - (int)offset.x;
    int translated_y = mouseY - (int)offset.y;
    
	/* Tarkistetaan onko hiiri jonkin napin päällä ja asetetaan 
	 * hiiri_napin_paalla_index muuttuja vastaamaan sitä nappia jonka 
	 * päällä hiiri on.
     */
    if(punaTykkiNappi.pressed(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = puna_idx;
    }
    else if(vihrTykkiNappi.pressed(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = vihr_idx;
    }
    else if(siniTykkiNappi.pressed(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = sini_idx;
    }
    else {
      hiiri_napin_paalla_index = 0;
    }  
  }
  
  /* Pääohjelman mouseClicked funktio kutsuu tätä funktiota jos painalluksen koordinaatit
   * ovat sivupalkin alueella */
  void mouseClicked() {
    int translated_x = mouseX - (int)offset.x;
    int translated_y = mouseY - (int)offset.y;
       
	///KAUPPANAPPIEN PAINAMINEN
	////punaisen tykin rakennusnappi
	if(punaTykkiNappi.pressed(translated_x, translated_y)) {      
	  if(_valikonNappiPohjassa) { tornienLkm--; } //jos jotain nappia on jo painettu kun tätä nappia painetaan, hävitetään edellinen torni
	  
	  tornit[tornienLkm] = new Tower(0, 0, color(255, 0, 0));
	  tornienLkm++;
	  _valikonNappiPohjassa = true;
	}
	
	////vihreän tykin rakennusnappi
	if(vihrTykkiNappi.pressed(translated_x, translated_y)) {
	  if(_valikonNappiPohjassa) { tornienLkm--; }
	  
	  tornit[tornienLkm] = new Tower(0, 0, color(0, 255, 0));
	  tornienLkm++;
	  _valikonNappiPohjassa = true;
	}
	
	////sinisen tykin rakennusnappi
	if(siniTykkiNappi.pressed(translated_x, translated_y)) {
	  if(_valikonNappiPohjassa) { tornienLkm--; }
	  
	  tornit[tornienLkm] = new Tower(0, 0, color(0, 0, 255));
	  tornienLkm++;
	  _valikonNappiPohjassa = true;
	}
    
  }
  
  void draw_torni_info() {
    /* piirretään laatikko jossa voidaan näyttää rakennettavissa olevien 
     * tornien tietoja */
    int offset_x = 20;
    int offset_y = 220;
    fill(230);
    rect(offset_x, offset_y, 160, 160);
    
    fill(20); // tekstin väri
    switch(hiiri_napin_paalla_index) {
      case puna_idx:
        text("PUNAINEN", offset_x + 10, offset_y + 20);  
        break;
      case sini_idx:
        text("SININEN", offset_x + 10, offset_y + 20);  
        break;
      case vihr_idx:
        text("VIHREÄ", offset_x + 10, offset_y + 20);  
        break;
    }
  }
  
  void draw() {
    translate(offset.x, offset.y);
     
    stroke(0);
    fill(200);
    rectMode(CORNER);
    rect(10, 10, 200-20, height-20, 5);
    text(_level, 20, 20);
    
    //Ylimpänä sivupalkissa on aika    
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
    
    println(tornienLkm);
 
    //Valitun (kentältä/kaupasta) tykin tiedot
	
	// indexi on nolla jos hiiri ei ole napin päällä
	if(hiiri_napin_paalla_index > 0) {
		
		draw_torni_info();
	}
	
    //Kentän numero
    
    
  }
  
}

