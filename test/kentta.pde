import java.util.*;

class Kentta {
  private List<PVector> _reitti;
  private List<Ormy> _hirviot;
  private List<Tower> _rakennetut;
  private Tower temp_torni = null;
  private Tower valittu_torni = null;

  private Laskuri _hirvio_viesti_laskuri;

  private int taso = 1;
  
  private color _taustaVari;
  private color _reittiVari;

  boolean mouseClicked = false;
    
  Kentta(color taustaVari, color reittiVari) {
    _taustaVari = taustaVari;
    _reittiVari = reittiVari;
       
    // Määritellään ruudut jotka ovat osa hirviöiden reittiä
    // Huom. ensimmäinen ja viimeinen ruutu kentän "ulkopuolella"
    _reitti = new ArrayList<PVector>();
    _reitti.addAll(Arrays.asList(
      new PVector(6, -1), new PVector(6, 0),  new PVector(6, 1), new PVector(6, 2), // ...
      new PVector(6, 3),  new PVector(6, 4),  new PVector(6, 5), //alas
      new PVector(7, 5),  new PVector(8, 5),  new PVector(9, 5), // oikealle
      new PVector(9, 6),  new PVector(9, 7) , new PVector(9, 8), new PVector(9, 9), // alas
      new PVector(8, 9),  new PVector(7, 9),  new PVector(6, 9), new PVector(5, 9), // vasemmalle
      new PVector(5, 10), new PVector(5, 11), new PVector(5, 12) // alas
    ));
    
    _hirviot = new ArrayList<Ormy>();
    _rakennetut = new ArrayList<Tower>();

    _hirvio_viesti_laskuri = new Laskuri();
    aalto_laskuri.setTime(2); // ensimmäinen aalto 2s päästä
    _hirvio_viesti_laskuri.setTime(0); // näytä varoitusviesti
    aalto_laskuri.starttaaLaskuri();
    _hirvio_viesti_laskuri.starttaaLaskuri();
  }

  /* Tällä funktiolla luodaan uusi väliaikainen torni, jolla ei vielä 
   * ole lukittua sijaintia kentällä. 
   * Jos funktiota kutsutaan ennen kuin vanhaa tornia on sijoitettu kentälle,
   * uusi torni korvaa sen. */
  void aloitaRakentaminen(Tower uusi) {
    temp_torni = uusi;
  }
   
  /* Jos k osoittama kenttäkoordinaatti (0,0) - (11, 11) on vapaa
   * (ei ole osa hirviöiden reittiä / ei sisällä jo tornia)
   * palautetaan true, muuten false
   */
  boolean is_free(PVector ruutu_koordinaatti) {
    
    boolean toisenTorninPaalle = false;
    PVector mousepos = get_coord(mouseX, mouseY);
    
    Iterator torni_it = _rakennetut.iterator();
    while(torni_it.hasNext()) {
      Tower twr = (Tower)torni_it.next();

      PVector tornipos = get_coord(twr._x, twr._y);
      if((int)tornipos.x == (int)mousepos.x && (int)tornipos.y == (int)mousepos.y) {
        toisenTorninPaalle = true;
        break;
      }

    }

    //jos ei reitillä eikä toisen tornin päällä -> true
    return !_reitti.contains(ruutu_koordinaatti) && !toisenTorninPaalle;
  }

  void peruutaRakennus() {
    temp_torni = null;
  }

  void mouseClicked() {

    this.mouseClicked = true;
    valittu_torni = null;

    //rakennustilanne? Onko pelaajalla rahaa?
    if(temp_torni != null && pelaaja.muuta_rahoja(-temp_torni.hinta)) { 
      
      temp_torni.lock();
      _rakennetut.add(temp_torni);
      temp_torni = null; // "merkitse rakennetuksi"
    }
  }

  int getTaso() {
    return taso;
  }

  void poistaTorni(Tower tw) {
    _rakennetut.remove(tw);
  }

  void draw() {
    this.piirraTausta();
    this.piirraReitti();
    this.piirraHirviot();
    this.piirraTornit();
    this.ammuTorneilla();
    this.tarkistaLaskurit();

    this.mouseClicked = false; //palautetaan hiiren klikkaus
  }

  private void tarkistaLaskurit() {
    /* Hirviöiden spawnaamisesta vastaa @aalto_laskuri
     * @_hirvio_viesti_laskuri asetetaan laukeamaan pari sekunttia ennen @laskuria
     * jolloin näytetään varoitusviesti. 
     */
    if(aalto_laskuri.getTime() <= 0 || _hirviot.size() == 0) {
      spawnaaHirviot(taso);
      sivupalkki.set_level(taso);
      taso += 1;
      int seuraava_aalto = 8;
      aalto_laskuri.setTime(seuraava_aalto);
      _hirvio_viesti_laskuri.setTime(seuraava_aalto - 3); // näytä varoitusviesti 3s ennen aaltoa
    }
    
    // Kun viestilaskuri menee nollaan näytään varoitusviesti
    if(_hirvio_viesti_laskuri.getTime() <= 0) {
      fill(_reittiVari);
      textFont(valikkoFontti, 16);
      textAlign(LEFT);
      text("UUSI AALTO STARTTAA PIAN", 10, 20);
    }
  }

  private void piirraHirviot() {
    // Tarkistetaan onko hirviö kuollut, jos on poistetaan listalta
    Iterator hirvio_it = _hirviot.iterator();
    while(hirvio_it.hasNext()) {
      Ormy o = (Ormy)(hirvio_it.next()); // next() täytyy kutsua ENNEN poistoa
      if(o.elossa()) {
        o.draw();
      } else {
        hirvio_it.remove();
      }
    }
  }

  /* Väritellään reitin ruudut uudelleen, koska niiden yli on kulkenut 
   * örmyjä jotka muuten jättävät värivanan peräänsä */
  private void piirraReitti() {
    Iterator ruudut_it = _reitti.iterator();
    while(ruudut_it.hasNext()) {
      PVector ruutupos = (PVector)ruudut_it.next();
      noStroke();
      fill(_reittiVari);
      rectMode(CORNER);
      rect(ruutupos.x*50, ruutupos.y*50, 50, 50);
    }
  }

  private void piirraTornit() {
    // Piirretään rakennetut tornit

    Iterator torni_it = _rakennetut.iterator();
    boolean infoPiirretaan = false;
    
    while(torni_it.hasNext()) { 
      Tower t = (Tower)torni_it.next();
      t.draw();

      //käsketään sivupalkkia piirtämään tornin tiedot mikäli hiiri on sellaisen
      //päällä eikä olla rakentamassa uutta
      if((t.mouseOverlap() && temp_torni == null)
        || t == valittu_torni) { //tai jos tornia ollaan klikattu (se on valittu)
        
        infoPiirretaan = true;
        if(valittu_torni == null) { //jos ei olla painettu ja valittu mitään tornia
          sivupalkki.asetaTorninInfonPiirto(t);
        }
        else {
          sivupalkki.asetaTorninInfonPiirto(valittu_torni);
        }

        if(this.mouseClicked && t._wanhaTorni) {
          //jos kentällä klikattiin hiirtä (ja siis klikattiin vieläpä JO RAKENNETUN tornin päällä)
          // JA jos torni ei ole vastarakennettu, torni valitaan
          valittu_torni = t;
        }
      }
      
      t._wanhaTorni = true; //torni on wanha, se ei ole vastarakennettu eli sitä voidaan klikata kentällä
    }

    
    if(!infoPiirretaan) {
      sivupalkki.kiellaTorninInfonPiirto();
    }
    
    // Piirretään rakennuksessa oleva torni hiiren kohdalle
    if(temp_torni != null) {
      PVector grid_coord = kentta.get_coord(mouseX, mouseY);

      if (kentta.is_free(grid_coord)) {
        temp_torni.set_location(grid_coord);
      }

      temp_torni.draw();
    }
  }

  private void ammuTorneilla() {
    if(_hirviot.size() > 0) {
      
      // järjestetään ampumista varten
      Collections.sort(_hirviot);
       
      // Kaikki tornit ampuu sitä
      Iterator torni_it = _rakennetut.iterator();
      while(torni_it.hasNext()) {
        Tower t = (Tower)torni_it.next();
        t.ammu(_hirviot);
      }
    }
  }
  
  private void piirraTausta() {
    //20*20 pikseleistä jotain hienoa _taustaVariin liittyvää
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
  }

  private void spawnaaHirviot(int maara) {
    for(int i = 0; i < maara; i++) {
      _hirviot.add(new Ormy(_reitti, (int)random(200, 400), color(i*10 % 255)));
    }
  }
  
  /* Palauttaa pelilaudan koordinaatin joka vastaa hiiren koordinaattia
   * Vasen yläkulma on (0.0, 0.0) ja oikea alakulma (11.0, 11.0)
   */
  private PVector get_coord(int x, int y) {
    PVector tmpcoord = new PVector((int)(x/50), (int)(y/50));
    if(tmpcoord.x > 11) {
      tmpcoord.x = 11;
    }
    if(tmpcoord.y > 11) {
      tmpcoord.y = 11;
    }
    return tmpcoord;
  }
  
  void mouseMoved() { 
    //ollaanko liikutettu hiiri pois tornin päältä 
    if(sivupalkki.infoTorni == null) {
      sivupalkki.kiellaTorninInfonPiirto();
      sivupalkki.hiiri_napin_paalla_index = 0; //tämä täytyy olla koska muuten info välillä jumiutuu
    }
  }   
}