import java.util.*;

class Kentta {
  private List<PVector> _reitti;
  private List<Ormy> _hirviot;
  private Laskuri _hirvio_viesti_laskuri;
  
  private color _taustaVari;
  private color _reittiVari;
    
  Kentta(color taustaVari, color reittiVari) {
    
    _taustaVari = taustaVari;
    _reittiVari = reittiVari;
    
    _hirvio_viesti_laskuri = new Laskuri();
    laskuri.setTime(2); // ensimmäinen aalto 2s päästä
    _hirvio_viesti_laskuri.setTime(0); // näytä varoitusviesti
    laskuri.starttaaLaskuri();
    _hirvio_viesti_laskuri.starttaaLaskuri();
    
   // background(140,199,78);
       
    // Määritellään ruudut jotka ovat osa hirviöiden reittiä
    _reitti = new ArrayList<PVector>();
    _reitti.addAll(Arrays.asList(
      new PVector(6, -1), new PVector(6, 0), new PVector(6, 1), new PVector(6, 2), // ...
      new PVector(6, 3), new PVector(6, 4), new PVector(6, 5), //alas
      new PVector(7, 5), new PVector(8, 5), new PVector(9, 5), // oikealle
      new PVector(9, 6), new PVector(9, 7) , new PVector(9, 8), new PVector(9, 9), // alas
      new PVector(8, 9), new PVector(7, 9), new PVector(6, 9), new PVector(5, 9), // vasemmalle
      new PVector(5, 10), new PVector(5, 11), new PVector(5, 12) // alas
      
    ));
    
    _hirviot = new ArrayList<Ormy>();
  }
  
  void spawnaaHirviot() {
    for(int i = 10; i < 80; i++) {
      _hirviot.add(new Ormy(_reitti, i*10, color(i*10 % 255)));
    }
  }
  
  /* Palauttaa pelilaudan koordinaatin joka vastaa hiiren koordinaattia
   * Vasen yläkulma on (0.0, 0.0) ja oikea alakulma (11.0, 11.0)
   */
  PVector get_coord(int x, int y) {
    PVector tmpcoord = new PVector((int)(x/50), (int)(y/50));
    if(tmpcoord.x > 11) {
      tmpcoord.x = 11;
    }
    if(tmpcoord.y > 11) {
      tmpcoord.y = 11;
    }
    return tmpcoord;
  }
  
  /* Jos k osoittama kenttäkoordinaatti (0,0) - (11, 11) on vapaa
   * (ei ole osa hirviöiden reittiä / ei sisällä jo tornia)
   * palautetaan true, muuten false
   */
  boolean is_free(PVector k) {
    
    boolean toisenTorninPaalle = false;
    PVector mousepos = get_coord(mouseX, mouseY);
    for(int i=0; i<tornienLkm-1; ++i) {
      PVector tornipos = get_coord(tornit[i]._x, tornit[i]._y);
      if((int)tornipos.x == (int)mousepos.x && (int)tornipos.y == (int)mousepos.y) {
        toisenTorninPaalle = true;
        break;
      }
    }
    //jos ei reitillä eikä toisen tornin päällä -> true
    return !_reitti.contains(k) && !toisenTorninPaalle;
  }
  
  void piirra_reittiruutu(PVector kk) {
    noStroke();
    fill(_reittiVari);
    rectMode(CORNER);
    rect(kk.x*50, kk.y*50, 50, 50);
  }
  
  void draw() {
    
    this.piirraTausta();
    
    // Väritellään reitin ruudut uudelleen, koska niiden yli on kulkenut örmyjä jotka muuten jättävät 
    // värivanan peräänsä
    Iterator ruudut_it = _reitti.iterator();
    while(ruudut_it.hasNext()) {
      this.piirra_reittiruutu((PVector)ruudut_it.next());
    }
    
    // Tarkistetaan onko hirviö kuollut, jos on poistetaan listalta
    Iterator hirviot_it = _hirviot.iterator();
    while(hirviot_it.hasNext()) {
      Ormy o = (Ormy)(hirviot_it.next());
      if(o.elossa()) {
        o.draw();
      } else {
        hirviot_it.remove();
      }      
    }
    
    /* Hirviöiden spawnaamisesta vastaa @laskuri
     * @_hirvio_viesti_laskuri asetetaan laukeamaan pari sekunttia ennen @laskuria
     * jolloin näytetään varoitusviesti. 
     */
    
    if(laskuri.getTime() <= 0) {
      spawnaaHirviot();
      int seuraava_aalto = 8;
      laskuri.setTime(seuraava_aalto);
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
  
}

