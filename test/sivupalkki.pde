class Sivupalkki {

  PVector offset;
  
  int _level = 0;
  PFont f;
  private Laskuri _laskuri;
  boolean _valikonNappiPohjassa = false;

  Nappi punaTykkiNappi;
  Nappi vihrTykkiNappi;
  Nappi siniTykkiNappi;
  
  // Tämä indeksi vastaa Tower luokan sisällä asetettuja staattisia indeximuuttujia
  // jotka kertovat tornin tyypin
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
      hiiri_napin_paalla_index = Tower.puna_idx;
    }
    else if(vihrTykkiNappi.pressed(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = Tower.vihr_idx;
    }
    else if(siniTykkiNappi.pressed(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = Tower.sini_idx;
    }
    else {
      hiiri_napin_paalla_index = 0;
    }  
  }
  
  /* Pääohjelman mouseClicked funktio kutsuu tätä funktiota jos painalluksen koordinaatit
   * ovat sivupalkin alueella */
  void mouseClicked() {
    /* Kun tähän funktioon saavutaan, mouseMoved() funktion perusteella tiedetään jo minkä
     * napin päällä hiiri on/ei ole, joten sitä ei tarvitse enää uudelleen tutkia
     */

    // KAUPPANAPPIEN PAINAMINEN
    if(hiiri_napin_paalla_index > 0) {
      // jos jotain nappia on jo painettu kun tätä nappia painetaan, hävitetään edellinen torni
      if(_valikonNappiPohjassa) { tornienLkm--; } 

      try {
        tornit[tornienLkm] = new Tower(hiiri_napin_paalla_index);
      } catch(Exception e) {
        // rakentaja heittää poikkeuksen jos hiiri_napin_paalla 
        // indeksia ei tunnisteta
        print(e);
        return;
      }
      
      tornienLkm++;
      _valikonNappiPohjassa = true;
    }
  }
  
  /* Piirretään hiiren alla olevan torninappulan tiedot
   */
  void draw_torni_info() {   
    if(hiiri_napin_paalla_index > 0) {
      Tower infotw;
      try {
        infotw = new Tower(hiiri_napin_paalla_index);
      } catch(Exception e) {
        // rakentaja heittää poikkeuksen jos hiiri_napin_paalla 
        // indeksia ei tunnisteta
        print(e);
        return;
      }
    
      /* piirretään laatikko jossa voidaan näyttää rakennettavissa olevien 
       * tornien tietoja */
      int offset_x = 20;
      int offset_y = 220;
      fill(230);
      rect(offset_x, offset_y, 160, 160);

      // Tulostetaan tiedot
      fill(20);
      text(infotw.nimi, offset_x + 10, offset_y + 20);  
      text(infotw.hinta, offset_x + 10, offset_y + 40);  
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
    
    draw_torni_info();
    
    //Kentän numero
    
  }
  
}

