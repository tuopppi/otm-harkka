class Sivupalkki {

  PVector offset;
  
  int _level = 0;
  PFont f;

  private Nappi punaTykkiNappi;
  private Nappi vihrTykkiNappi;
  private Nappi siniTykkiNappi;

  private Nappi paivitaNappi;
  private Nappi myyNappi;
  
  private Tower infoTorni; //torni josta piirretään inforuutua, muutoin null
  
  // Tämä indeksi vastaa Tower luokan sisällä asetettuja staattisia indeximuuttujia
  // jotka kertovat tornin tyypin
  int hiiri_napin_paalla_index = 0;
    
  Sivupalkki() {
    offset = new PVector(width-200, 0);
    
    //sivupalkin napit
    punaTykkiNappi = new Nappi(20, 150, 50, 50, color(255,0,0));
    vihrTykkiNappi = new Nappi(20+55, 150, 50, 50, color(0,255,0));
    siniTykkiNappi = new Nappi(20+110, 150, 50, 50, color(0,0,255));

    paivitaNappi = new Nappi(0, 0, 140, 30, color(0,0,0));
    myyNappi     = new Nappi(0, 0, 140, 30, color(0,0,0));
    
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
     * päällä hiiri on. */
    if(punaTykkiNappi.mouseOver(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = Tower.puna_idx;
      kentta.valittu_torni = null; //poistetaan kentältä mahdollinen valinta
    }
    else if(vihrTykkiNappi.mouseOver(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = Tower.vihr_idx;    
      kentta.valittu_torni = null;
    }
    else if(siniTykkiNappi.mouseOver(translated_x, translated_y)) { 
      hiiri_napin_paalla_index = Tower.sini_idx;
      kentta.valittu_torni = null;
    }
    else if(myyNappi.mouseOver(translated_x, translated_y)) {
      hiiri_napin_paalla_index = -1; //myyNappi
    }
    else if(paivitaNappi.mouseOver(translated_x, translated_y)) {
      hiiri_napin_paalla_index = -2; //paivitaNappi
    }
    else {
      hiiri_napin_paalla_index = 0;
    }  
  }
    
  /* Pääohjelman mouseClicked funktio kutsuu tätä funktiota jos painalluksen koordinaatit
   * ovat sivupalkin alueella */
  void mouseClicked() {
    /* Kun tähän funktioon saavutaan, mouseMoved() funktion perusteella tiedetään jo minkä
     * napin päällä hiiri on/ei ole, joten sitä ei tarvitse enää uudelleen tutkia */
     
    // KAUPPANAPPIEN PAINAMINEN
    if(hiiri_napin_paalla_index > 0) {
      // jos jotain nappia on jo painettu kun tätä nappia painetaan, hävitetään edellinen torni
      try {
        Tower uusi = new Tower(hiiri_napin_paalla_index);
        if(pelaaja.get_rahat() >= uusi.hinta) {
          kentta.aloitaRakentaminen(uusi);
        }
      } catch(Exception e) {
        // rakentaja heittää poikkeuksen jos hiiri_napin_paalla 
        // indeksia ei tunnisteta
        print(e);
        return;
      }

    }
    else if(hiiri_napin_paalla_index == -2 && kentta.valittu_torni != null) { //paivita-nappia painettu

      if(pelaaja.get_rahat() >= kentta.valittu_torni.upgradeHinta()) {
        pelaaja.muuta_rahoja(-1*kentta.valittu_torni.upgradeHinta());
        kentta.valittu_torni.upgrade();
      }
    }
    else if(hiiri_napin_paalla_index == -1  && kentta.valittu_torni != null) { //myy-nappia painettu
        pelaaja.muuta_rahoja(kentta.valittu_torni.myyntiHinta());
        kentta.valittu_torni._elossa = false;
        kentta.valittu_torni = null;
        infoTorni = null;
    }
  }
  

  /* Piirretään hiiren alla olevan tornin (kentällä olevan) tiedot
   */

  void draw_torni_info() {
     
      if(infoTorni == null) { /*mikäli kentältä ei olla valittu tornia,
                              ei piirretä mittään*/
        
        return;
      }
    
      int offset_x = 20;
      int offset_y = 220;
      fill(230);
      rect(offset_x, offset_y, 160, 160);

      // Tulostetaan tiedot
      fill(20);
      textAlign(LEFT);
      text(infoTorni.nimi, offset_x + 10, offset_y + 20);  
      text("Arvo: "+infoTorni.myyntiHinta(), offset_x + 10, offset_y + 40);
      text("Upgrade: "+infoTorni.upgradeHinta(), offset_x + 10, offset_y + 60);

      //jos torni on valittu (klikattu hiirellä, piirretään myös nappulat)
      if(infoTorni == kentta.valittu_torni) {

        paivitaNappi.setPosCol(offset_x + 10, offset_y + 85, kentta.valittu_torni._color);
        paivitaNappi.draw();
        fill(20);
        text("Upgrade", offset_x + 45, offset_y + 105);
        if(pelaaja.get_rahat() < kentta.valittu_torni.upgradeHinta()) {
          piirraRuksi(paivitaNappi);
        }

        myyNappi.setPosCol(offset_x + 10, offset_y + 120, kentta.valittu_torni._color);
        myyNappi.draw();
        fill(20);
        text("Myy torni", offset_x + 35, offset_y + 140);
      }
  }
  
  /* Piirretään hiiren alla olevan tornin ostonappulan tiedot
   */
  void draw_osto_info() {   
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
      textAlign(LEFT);
      text(infotw.nimi, offset_x + 10, offset_y + 20);  
      text("Ostohinta: "+infotw.hinta, offset_x + 10, offset_y + 40);  
    }
  }
  
  void draw() {
    translate(offset.x, offset.y);
     
    stroke(0);
    fill(kentta._taustaVari);
    rectMode(CORNER);
    rect(10, 10, 200-20, height-20, 5);
    
    //Ylimpänä sivupalkissa on aika
    
    pushMatrix();
  
    textAlign(CENTER);
    fill(kentta._reittiVari);
    
    textFont(valikkoFontti, 16);
    text("Seuraava aalto",100,40);
    
    textFont(valikkoFontti, 60);
    text(aalto_laskuri.getTime(),100,105);  //Display Text
    //text("s",45,60);
    
    //Rahatilanne
    
    textFont(valikkoFontti, 16);
    textAlign(LEFT);
    text("Rahat:",50,140);
    textAlign(RIGHT);
    text(pelaaja.get_rahat(), 140, 140);
    
    // Pelaajan elamat 
    
    textFont(valikkoFontti, 16);
    textAlign(LEFT);
    text("Elämät:",50,540);
    textAlign(RIGHT);
    text(pelaaja.get_elamat(), 140, 540);
    
    popMatrix();
    
    //Ostettavat tykit (KAUPPA)
    punaTykkiNappi.draw();
    vihrTykkiNappi.draw();
    siniTykkiNappi.draw();
    
    if(pelaaja._rahat < PUNAHINTA) { piirraRuksi(punaTykkiNappi); }
    if(pelaaja._rahat < SINIHINTA) { piirraRuksi(siniTykkiNappi); }
    if(pelaaja._rahat < VIHRHINTA) { piirraRuksi(vihrTykkiNappi); }
    
    draw_osto_info();
    draw_torni_info();
    
        
    //Kentän numero
    
    textAlign(CENTER);
    fill(kentta._reittiVari);
    textFont(valikkoFontti, 16);
    text("Kenttä",100,440);
    
    textFont(valikkoFontti, 60);
    text(_level, 100, 500);
        
  }
  
  void piirraRuksi(Nappi nappi) {
    
    strokeWeight(10);
    stroke(0);
    line(nappi._x, nappi._y, nappi._x+nappi._w, nappi._y+nappi._h);
    line(nappi._x, nappi._y+nappi._h, nappi._x+nappi._w, nappi._y);
    strokeWeight(1);
  }
  
  void asetaTorninInfonPiirto(Tower torni) {
    
    infoTorni = torni;
  }    
  
  void kiellaTorninInfonPiirto() {
    
    infoTorni = null;
  }
}


